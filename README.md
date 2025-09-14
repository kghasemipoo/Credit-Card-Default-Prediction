# Supervised Learning Analysis: Credit Default Prediction

## Project Overview

This project implements and compares various supervised learning algorithms for predicting credit card default payments. The analysis uses a comprehensive dataset of credit card client information to build and evaluate machine learning models for binary classification.

---

## Dataset

The analysis is performed on a credit card default dataset containing client demographics, payment history, and billing information. The target variable indicates whether a client will default on their next payment.

---

## Methods Implemented

### Machine Learning Algorithms
- **Logistic Regression**: Baseline linear model for binary classification
- **Support Vector Machine (SVM)**: Non-linear classification using kernel methods
- **Random Forest**: Ensemble method using multiple decision trees

### Model Evaluation
- Cross-validation with upsampling for class imbalance
- ROC-AUC analysis for performance comparison
- Confusion matrices for classification accuracy assessment
- Feature importance analysis

---

## Key Features

- Data preprocessing and exploratory analysis
- Handling of categorical variables and missing data
- Implementation of cross-validation techniques
- Comprehensive model comparison using multiple metrics
- Feature importance visualization
- ROC curve analysis for model performance evaluation

---

## Requirements

The project requires the following R packages:
- tidyverse
- caret
- e1071
- randomForest
- pROC
- ggplot2
- dplyr

---

## Project Structure

- `supervised.R`: Main analysis script containing all model implementations
- `data.csv`: Credit card default dataset (not tracked in version control)
- `supervisedReport.pdf`: Comprehensive analysis report with results and visualizations

---

## Results

The analysis provides insights into:
- Comparative performance of different supervised learning algorithms
- Feature importance rankings for credit default prediction
- Model accuracy and reliability metrics
- Recommendations for deployment considerations

---

## Usage

1. Install required R packages
2. Load the dataset into the working directory
3. Run the `supervised.R` script to execute the complete analysis
4. Review the generated report for detailed findings and model comparisons

---

## Output

The project generates performance metrics, visualizations, and a detailed report comparing the effectiveness of different supervised learning approaches for credit default prediction.

---

## Author & Credits

- **Project by**: Kasra Ghasemipoo
- **University**: Università degli Studi di Milano
- **Academic Year**: 2024/25
- **Contact**:
  - kghasemipoo@gmail.com
  - kasra.ghasemipoo@studenti.unimi.it
