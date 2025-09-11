# Install and load required packages
install.packages(c("tidyverse", "readr", "dplyr", "ggplot2", "caret", "e1071", "randomForest"))

library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)
library(caret)
library(e1071)
library(randomForest)

# Load and preview data
df <- read_csv("data.csv")
head(df)
glimpse(df)

# Clean and format columns
df <- df %>%
  rename(default = `default.payment.next.month`) %>%
  mutate(
    SEX = factor(SEX, levels = c(1, 2), labels = c("Male", "Female")),
    EDUCATION = factor(EDUCATION),
    MARRIAGE = factor(MARRIAGE),
    default = factor(default, levels = c(0, 1), labels = c("No", "Yes"))
  ) %>%
  select(-...1)

glimpse(df)

# Class balance check
table(df$default)

# Basic visualizations
ggplot(df, aes(x = default, fill = default)) +
  geom_bar() +
  labs(title = "Default Status Distribution") +
  theme_minimal()

ggplot(df, aes(x = default, y = LIMIT_BAL, fill = default)) +
  geom_boxplot() +
  labs(title = "Credit Limit vs Default") +
  theme_minimal()

ggplot(df, aes(x = default, y = AGE, fill = default)) +
  geom_boxplot() +
  labs(title = "Age vs Default") +
  theme_minimal()

ggplot(df, aes(x = as.factor(PAY_0), fill = default)) +
  geom_bar(position = "fill") +
  labs(title = "PAY_0 vs Default") +
  theme_minimal()

# Split data
set.seed(123)
split <- createDataPartition(df$default, p = 0.8, list = FALSE)
train_data <- df[split, ]
test_data <- df[-split, ]

# Logistic regression (baseline)
log_model <- glm(default ~ ., data = train_data, family = "binomial")
summary(log_model)

log_probs <- predict(log_model, newdata = test_data, type = "response")
log_preds <- factor(ifelse(log_probs > 0.5, "Yes", "No"), levels = c("No", "Yes"))

confusionMatrix(log_preds, test_data$default)

# Logistic regression with upsampling
ctrl_up <- trainControl(
  method = "cv",
  number = 5,
  sampling = "up",
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)

log_model_up <- train(
  default ~ ., 
  data = train_data,
  method = "glm",
  family = "binomial",
  trControl = ctrl_up,
  metric = "ROC"
)

log_preds_up <- predict(log_model_up, newdata = test_data)
confusionMatrix(log_preds_up, test_data$default)

# Random forest with upsampling
ctrl_rf <- trainControl(
  method = "cv",
  number = 5,
  sampling = "up",
  classProbs = TRUE,
  summaryFunction = twoClassSummary
)

rf_model <- train(
  default ~ .,
  data = train_data,
  method = "rf",
  trControl = ctrl_rf,
  metric = "ROC",
  ntree = 100
)

rf_preds <- predict(rf_model, newdata = test_data)
confusionMatrix(rf_preds, test_data$default)

# Feature importance
importance_df <- varImp(rf_model, scale = TRUE)

ggplot(importance_df, aes(x = reorder(rownames(importance_df$importance), Overall), y = Overall)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Feature Importance - Random Forest") +
  theme_minimal()

# ROC curves
library(pROC)

log_probs <- predict(log_model, newdata = test_data, type = "response")
rf_probs  <- predict(rf_model, newdata = test_data, type = "prob")[, "Yes"]
actual <- ifelse(test_data$default == "Yes", 1, 0)

roc_log <- roc(actual, log_probs)
roc_rf  <- roc(actual, rf_probs)

plot(roc_log, col = "blue", main = "ROC Curve Comparison", legacy.axes = TRUE)
lines(roc_rf, col = "red")
legend("bottomright", legend = c("Logistic", "Random Forest"), col = c("blue", "red"), lwd = 2)
