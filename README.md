# LoFX

[![Python](https://img.shields.io/badge/python-3.9%2B-blue.svg)](https://www.python.org/)
[![Django](https://img.shields.io/badge/django-4.2%2B-092e20.svg)](https://www.djangoproject.com/)


**LoFX** is a machine learning-based  application for predicting the impact of **loss-of-function (LoF) variants**, with a focus on **stop-gain**, **stop-loss**, and **start-loss** variants. It provides a browser-based interface for uploading variant files, processing annotations, and displaying structured prediction results — including LoFX scores, predicted classifications, and job status.(6.6 MB unzipped / 2.4 MB zipped)

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Required Model Files](#required-model-files)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Usage](#usage)
- [Input Data](#input-data)
- [Output](#output)
- [Configuration and Deployment](#configuration-and-deployment)
- [Troubleshooting](#troubleshooting)
- [Citation](#citation)
- [License](#license)
- [Contact](#contact)

---

## Overview

LoFX supports user-friendly evaluation of LoF variants through a web interface. It integrates a trained machine learning model with variant-level and gene-level features to generate pathogenicity predictions.

The application allows users to:

- Upload input files through a web browser
- Process supported variant annotation data
- Generate LoFX prediction scores
- View structured results in the web interface
- Inspect variant annotations and prediction status

---

## Features

- Django-based web interface
- Pathogenicity prediction for LoF variants: **stop-gain**, **stop-loss**, and **start-loss**
- Structured output including:
  - Variant annotations
  - LoFX score
  - Predicted classification
  - Job / processing status
- Inference powered by a pre-trained machine learning model
- Gene-level constraint mapping resources for prediction

---



## Prerequisites

Ensure the following are installed before running the application locally:

- **Python 3.9 or higher**
- **pip**
- **Git** (optional, for cloning the repository)
- A modern web browser (Chrome, Firefox, or Edge)

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/Masouddehghant/LoFX.git
cd LoFX
```

Alternatively, download the repository as a ZIP file from GitHub and extract it locally.

### 2. Create and activate a virtual environment

Using a virtual environment is strongly recommended.

**Windows**

```bash
python -m venv venv
venv\Scripts\activate
```

**Linux / macOS**

```bash
python3 -m venv venv
source venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

The `requirements.txt` file contains all packages required to run the Django application and load the trained model. Core dependencies include `Django`, `pandas`, `numpy`, `scikit-learn`, `xgboost`, and `joblib`.

If you obtained the project without `requirements.txt`, install packages manually:

```bash
pip install Django pandas numpy scikit-learn xgboost joblib
```

---

## Required Model Files

The following files must be present in the `trained_model/` directory before running predictions:

| File | Description |
|------|-------------|
| `lofx_model.pkl` | Trained, calibrated LoFX model |
| `lofx_features.pkl` | Feature list expected by the model |
| `gnomad_constraint.tsv` | Gene-level constraint lookup table |

These files are required for inference and should remain in their expected locations unless the inference code is updated accordingly.

---

## Database Setup

On first run, apply Django migrations:

```bash
python manage.py migrate
```

Optionally, create a superuser account for the Django admin panel:

```bash
python manage.py createsuperuser
```

---

## Running the Application

From the project root directory (containing `manage.py`), start the development server:

```bash
python manage.py runserver
```

Then open the application in your browser:

```
http://127.0.0.1:8000/
```

---

## Usage

1. Open `http://127.0.0.1:8000/` in a web browser.
2. Upload the required input file through the web interface.
3. Submit the file for processing.
4. Review the structured output displayed by the application.

The interface displays uploaded variant information, variant annotations, the LoFX score, the predicted classification, and the processing status.

---

## Input Data

The application processes variant annotation data prepared in the format expected by the model pipeline. Accepted formats may include:

- Tab-delimited text files
- CSV files
- Pre-annotated variant tables including: Gene.refGene, ExonicFunc.refGene, ExAC_ALL, 1000g2015aug_ALL, phastCons100way_vertebrate, SiPhy_29way_logOdds, CADD_phred, Eigen-phred_coding, GenoCanyon_score



---

## Output

The web interface presents prediction results in a structured format, including:

- Variant-level annotations
- LoFX prediction score
- Predicted class or interpretation
- Job / processing status



---

## Configuration and Deployment

This repository is suitable for local development and research use. A typical runtime environment requires:

```text
Django>=4.2,<5.0
pandas>=2.0
numpy>=1.24
scikit-learn>=1.3
xgboost>=2.0
joblib>=1.3
```

---

## Troubleshooting

**Missing package errors**

```bash
pip install -r requirements.txt
```

**Port already in use** — run on an alternative port:

```bash
python manage.py runserver 8001
```

Then open `http://127.0.0.1:8001/`.

**Model files not found** — confirm the following files exist:

```text
trained_model/lofx_model.pkl
trained_model/lofx_features.pkl
trained_model/gnomad_constraint.tsv
```

**Static files not loading**

```bash
python manage.py collectstatic
```

**Database errors**

```bash
python manage.py makemigrations
python manage.py migrate
```

---

## Citation

If you use LoFX in research, publications, or academic work, please cite the relevant manuscript, software repository, or associated study. Citation details will be provided upon publication.

---

## License

#

---

## Contact

For questions, collaboration, or support, please reach out via the details below:

Masoud Dehghan Tezerjani: masoud.dehghan@amt.mui.ac.ir,  
Dr. Mohammadreza Sehhati: mr.sehhati@amt.mui.ac.ir,   
Department of Bioinformatics, School of Advanced Technologies in Medicine, Isfahan University of Medical Sciences, Isfahan, Iran

