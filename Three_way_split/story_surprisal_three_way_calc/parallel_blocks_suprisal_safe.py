# parallel_blocks_suprisal_safe.py

import os, math, sys
import numpy as np
import pandas as pd
import multiprocessing as mp
from concurrent.futures import ProcessPoolExecutor, as_completed

# Prevent thread explosion inside each worker
os.environ.setdefault("OMP_NUM_THREADS", "1")
os.environ.setdefault("MKL_NUM_THREADS", "1")

# Add the directory containing lingpred to sys.path
sys.path.append(os.path.abspath("/Users/xiaosuhu/Python_Proj/Pilot_Analysis_3_Way_Split/lingpred/lingpred"))
# sys.path.append(os.path.abspath("F:\Matlab_Project\PROJECT_HH_ENGLISH\Pilot_Analysis_3_Way_Split\lingpred\lingpred"))


def _safe_last(arr):
    try:
        return arr[-1] if arr is not None and len(arr) > 0 else None
    except Exception:
        return None

def _to_float(x):
    try:
        xf = float(x)
        return xf if math.isfinite(xf) else None
    except Exception:
        return None

def _process_block(words, start_i, end_i, window_words, compute_pos, compute_phoneme):
    """Worker: process indices [start_i, end_i). Returns list[(i, rowdict), ...] or raises ImportError info."""
    # Import inside worker so failure surfaces clearly
    try:
        # CHANGE THIS to your actual module path:
        # from lingpred import LingPred
        from lingpred.lingpred.pipeline import LingPred

    except Exception as e:
        # Return a synthetic error row for visibility
        return [(start_i, {"error": f"ImportError: {e}"})]

    # Optional: restrict torch threads if present
    try:
        import torch
        torch.set_num_threads(1)
    except Exception:
        pass

    rows_out = []
    lp = LingPred()

    for i in range(start_i, end_i):
        left = max(0, i - window_words)
        text_chunk = " ".join(words[left:i+1])  # include target word

        try:
            lp.preprocess(text_chunk)
            lp.fit()
            lp.get_lexical_info()
            if compute_pos:
                lp.get_POS_info()
            if compute_phoneme:
                lp.get_phonemic_info()

            words_chunk           = getattr(lp, "words", words[left:i+1]) or []
            lexical_logp_arr      = lp.out_dict.get("lexical_surprise") or []  # likely log p (≤0)
            pos_logp_arr          = lp.out_dict.get("POS_surprise") or []      # likely log p (≤0)
            content_labels_arr    = lp.out_dict.get("content_words") or []
            function_labels_arr   = lp.out_dict.get("function_words") or []
            phoneme_initial_arr   = lp.out_dict.get("phoneme") or []
            phonemic_surpr_nat    = lp.out_dict.get("phonemic_surprise") or [] # already −log p

            w_model          = _safe_last(words_chunk) or words[i]
            lex_logp         = _to_float(_safe_last(lexical_logp_arr))
            lex_bits         = (-lex_logp / np.log(2)) if lex_logp is not None else None

            if compute_pos:
                pos_logp     = _to_float(_safe_last(pos_logp_arr))
                pos_bits     = (-pos_logp / np.log(2)) if pos_logp is not None else None
                is_content   = _safe_last(content_labels_arr)
                is_function  = _safe_last(function_labels_arr)
                is_content   = bool(is_content) if is_content is not None else None
                is_function  = bool(is_function) if is_function is not None else None
            else:
                pos_bits, is_content, is_function = None, None, None

            if compute_phoneme:
                pho_init     = _safe_last(phoneme_initial_arr)
                pho_nat      = _to_float(_safe_last(phonemic_surpr_nat))
                pho_bits     = (pho_nat / np.log(2)) if pho_nat is not None else None
            else:
                pho_init, pho_bits = None, None

            rows_out.append((
                i,
                {
                    "orig_index": i,
                    "word": words[i],
                    "model_word": w_model,
                    "lex_surprisal_bits": lex_bits,
                    "pos_surprisal_bits": pos_bits,
                    "is_content_word": is_content,
                    "is_function_word": is_function,
                    "phoneme_initial": pho_init,
                    "phoneme_surprisal_bits": pho_bits,
                    "window_start_index": left,
                    "window_len_words": i - left + 1,
                }
            ))
        except Exception as e:
            rows_out.append((
                i,
                {
                    "orig_index": i,
                    "word": words[i],
                    "model_word": None,
                    "lex_surprisal_bits": None,
                    "pos_surprisal_bits": None,
                    "is_content_word": None,
                    "is_function_word": None,
                    "phoneme_initial": None,
                    "phoneme_surprisal_bits": None,
                    "window_start_index": left,
                    "window_len_words": i - left + 1,
                    "error": str(e),
                }
            ))
    return rows_out

def compute_suprisal_parallel_blocks(
    cleaned_text: str,
    window_words: int = 200,
    n_workers: int = 8,         # start small to test; then 20
    block_size: int = 32,       # start small; then 128/256
    compute_pos: bool = True,
    compute_phoneme: bool = True,
    save_path: str = None,
):
    words = cleaned_text.split()
    n = len(words)

    tasks = [(start, min(n, start + block_size)) for start in range(0, n, block_size)]
    results = {}

    ctx = mp.get_context("spawn")  # macOS/Jupyter safe
    with ProcessPoolExecutor(max_workers=n_workers, mp_context=ctx) as ex:
        futs = [ex.submit(_process_block, words, s, e, window_words, compute_pos, compute_phoneme)
                for (s, e) in tasks]
        done = 0
        for fut in as_completed(futs):
            try:
                rows = fut.result()
            except Exception as e:
                # Surface which task died instead of BrokenProcessPool
                print(f"[error] A worker crashed with: {repr(e)}")
                continue
            for i, row in rows:
                # If we returned an import error sentinel, mark all indices in this block as error
                if "error" in row and row.get("orig_index") is None:
                    # replicate error across its intended block size  (best-effort diagnostics)
                    results[i] = {"orig_index": i, "word": words[i], **row}
                else:
                    results[i] = row
            done += 1
            if done % 10 == 0 or done == len(futs):
                print(f"[progress] finished {done}/{len(futs)} blocks")

    # Assemble in order
    ordered = []
    for i in range(n):
        if i in results:
            ordered.append(results[i])
        else:
            ordered.append({
                "orig_index": i,
                "word": words[i],
                "model_word": None,
                "lex_surprisal_bits": None,
                "pos_surprisal_bits": None,
                "is_content_word": None,
                "is_function_word": None,
                "phoneme_initial": None,
                "phoneme_surprisal_bits": None,
                "window_start_index": max(0, i - window_words),
                "window_len_words": min(window_words, i) + 1,
                "error": "missing_from_worker"
            })

    df = pd.DataFrame(ordered)
    if save_path:
        df.to_csv(save_path, index=False)
        print(f"Saved results to {save_path}")
    return df
