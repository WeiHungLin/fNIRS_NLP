# fNIRS Data Processing pipelines for natual language processing (NLP)

This repository contains different MATLAB and Python scripts for fNIRS data processing pipelines (NLP tasks). 

**NOTE**:
## Suprisal Calculation

If you would like to calculate surprisal values yourself, please request access to the following package:

👉 [LingPred](https://github.com/cnllab/lingpred)

Access to LingPred is managed by **Dr. Jonathan Brennan (University of Michigan)**.  
Please reach out to him directly to obtain the necessary permissions before running the surprisal pipeline.  

Once you have access, follow the setup instructions provided in the LingPred repository to install dependencies and run the surprisal extraction tools.

<p align="left">
  <img src="https://img.shields.io/badge/version-0.1-blue" alt="Version Badge">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License Badge">
  <img src="https://img.shields.io/badge/build-building_inprogress-yellow" alt="Build Badge">
</p>


---

## Overview
This repository is organized into two main parts:

1. **Three-Way Split Analysis**  
   - Data preprocessing and experimental setup with three-way splits  
   - Used for [your research goal / motivation]

2. **NLP Forecasting with Future Words**  
   - Predictive modeling with language models  
   - Forecasting brain/behavioral responses (or other target variable) using future word information

---

## Repository Structure
```
repo-root/
│
├── part1_three_way_split/
│   ├── notebooks/        # Jupyter notebooks for analysis
│   ├── scripts/          # Reusable scripts
│   └── results/          # Example outputs
│
├── part2_nlp_forecasting/
│   ├── notebooks/        # Forecasting experiments
│   ├── models/           # Pretrained / fine-tuned models
│   └── results/          # Predictions and evaluations
│
└── README.md
```

---

## Part 1: Three-Way Split Analysis

### Goals
- [Write here the purpose of this analysis]
- [Example: To evaluate model generalization under different splits]

### Methods
- [Describe your methodology]
- [List datasets used]
- [Key equations or steps]

### How to Run
```bash
cd part1_three_way_split
python scripts/run_analysis.py --config configs/config.yaml
```

### Results
- [Insert summary / plots / metrics]

---

## Part 2: NLP Forecasting with Future Words

### Goals
- [State your forecasting objective]
- [Example: Predict brain response using surprisal values at future words]

### Methods
- [Models: GPT-2, LLaMA, etc.]
- [Feature extraction pipeline]
- [Evaluation metrics]

### How to Run
```bash
cd part2_nlp_forecasting
python scripts/run_forecast.py --model gpt2 --future 5
```

### Results
- [Add figures / performance tables]

---

## Installation
```bash
git clone https://github.com/yourusername/yourrepo.git
cd yourrepo
conda env create -f environment.yml
conda activate yourenv
```

---

## Requirements
- Python >= 3.9
- PyTorch / TensorFlow [specify version]
- [Other packages]

---

## Citation
If you use this repository, please cite:
```
[Add your paper / project citation here]
```

---

## License
[MIT / Apache / Other]

---

## Contact
For questions or collaborations:  
**Your Name** – [your.email@domain.com]  
