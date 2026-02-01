library(here)
library(readr)
library(tidyverse)
library(ggplot2)


# Importing 
work_dir <- here() 
kaggle_df <- read_csv(file.path(work_dir, "shopping", "data", "raw_data", "kaggle_shopping.csv"))

# EDA
head(kaggle_df) # Gender, ProductCategory, LoyaltyProgram, and PurchaseStatus are categorical

kaggle_df <- kaggle_df %>%
  mutate(across(c(Gender, ProductCategory, LoyaltyProgram, PurchaseStatus), as.factor))

summary(kaggle_df)

## Histogram of continuous variables 
continuous_var <- c("Age", "AnnualIncome", "NumberOfPurchases", "TimeSpentOnWebsite", "DiscountsAvailed")

for (i in 1:length(continuous_var)) {
  hist(kaggle_df[[continuous_var[i]]], xlab = continuous_var[i], 
       main = paste("Histogram of", continuous_var[i]))
}

## Box plots  
ggplot(data = kaggle_df, mapping = aes(x = PurchaseStatus, y = TimeSpentOnWebsite)) +
  geom_boxplot()

ggplot(data = kaggle_df, mapping = aes(x = PurchaseStatus, y = AnnualIncome)) +
  geom_boxplot()

ggplot(data = kaggle_df, mapping = aes(x = PurchaseStatus, y = Age)) +
  geom_boxplot()

## Frequency tables
prop.table(table(kaggle_df$LoyaltyProgram, kaggle_df$PurchaseStatus))

## NEXT STEP: create a new column that introduces censoring (1 if customer bought something,
## and 0 if the customer didn't buy something and if time spent is longer than cut off period)
