# fNIRS Data Processing pipelines for natual language processing (NLP)

This repository contains different MATLAB and Python scripts for fNIRS data processing pipelines (NLP tasks). 

**NOTE**:
#### NIRS toolbox
You will need to first install **NIRS toolbox** (see [Installation](#installation) for details) in MATLAB in order to run these pipelines.

#### Suprisal Calculation

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
This repository is organized into three main parts:
1. **Sample data**
   - Three de-id data was included in the Example_data/raw_data
   - The cutted data was stored in the Example_data/cutted_data, the Q&A sections were cutted and only the story listening parts are kept
   - The surprisals were stored in the Example_data/surprisal_data/HH_DesignMatrix_augmented.csv
   - The analysis results were stored in the Example_data/Temp

2. **Data preparation**
   - Data preparation mainly based on Henry Huggings story listening data
   - Data cut (remove the Q&A part and reconnect the story listening part)

3. **Three-Way split analysis**  
   - Suprisal calculation at 3 different levels lexcial/sytactical/phonem (with parallel workers)  
   - Data recoding - insert the suprisal data into fNIRS data to become its design matrix
   - First level, group level analysis and contrast and plotting are covered in https://github.com/xiaosuhu/fNIRS-DataProcessing-Pipelines-w-functions, in this repo, these are just added for convinience

4. **NLP forecasting with future words**  
   - GPT2 embeeding calculation  
   - HbO data prep for the analysis
   - design matrix prep
   - Calculate brain score (correlation) and brain forcast score (forcasted brain score)
   - Plotting and stats in Matlab
   - This method comes from the paper "Evidence of a predictive coding hierarchy in the human brain listening to speech" - https://www.nature.com/articles/s41562-022-01516-2

   Here is an illustration of the workflow:

   ![Workflow Diagram](Forcasting_pipeline.png)

### Results
![Workflow Diagram](sample-result.png)

---

## Installing the Python Environment

### 1. Install Miniconda

Miniconda is a minimal installer for conda.  
Download it from the official page: [https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)

Example (Linux / macOS):

```bash
# Download installer (example for Linux x86_64)
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Run installer
bash Miniconda3-latest-Linux-x86_64.sh

# Restart shell so conda is available
source ~/.bashrc
```

On Windows: just run the `.exe` installer from the same link.


### 2. Create and Activate a New Environment

```bash
conda create -n myenv python=3.10
conda activate myenv
```


### 3. Install Packages from requirements.txt

Since the file was generated with `conda list -e`, you can restore it like this:

```bash
conda install --yes --file requirements.txt
```

This will recreate the environment with the same package versions.


---

## Requirements
- Matlab:
  - Please have the following toolbox or pipelines in path:
    - https://github.com/huppertt/nirs-toolbox
    - https://github.com/xiaosuhu/fNIRS-DataProcessing-Pipelines-w-functions
    - https://github.com/xiaosuhu/fNIRS_NLP
- Python:
  - see above **Installing the Python Environment**

---

## Contact
For questions or collaborations:  
**Frank Hu** – [xiaosuhu@umich.edu]  
