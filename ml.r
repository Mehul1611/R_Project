# Load required libraries
library(randomForest)
library(caret)

#Data Preprocessing and Cleaning
df<- read.csv("E://R//data.csv")
df <- df[, !(names(df) %in% c('url','city','res_id','delivery','takeaway', 'establishment','latitude','longitude','country_id','cuisines','rating_text','name','address','locality', 'zipcode', 'locality_verbose','timings','currency','highlights','opentable_support'))]
df <- na.omit(df)


# Define X and Y for model
X <- df[, !(names(df) %in% c(" aggregate_rating "))]
Y <- df$ aggregate_rating 

# Split the data into training and testing sets
set.seed(123)
data_split <- createDataPartition(Y, p = 0.8, list = FALSE)
X_train <- X[data_split, ]
X_test <- X[-data_split, ]
Y_train <- Y[data_split]
Y_test <- Y[-data_split]

# Fit a random forest model
model <- randomForest(Y_train ~ ., data = cbind(X_train, Y_train))

# Make predictions on the test set
Y_pred <- predict(model, newdata = X_test)

# Calculate the accuracy for the model
accuracy <- 1 - sum((Y_test - Y_pred)^2) / sum((Y_test - mean(Y_test))^2)
print(paste("Accuracy:", accuracy))

# prediction example
example_predictions <- data.frame(Actual = Y_test, Predicted = Y_pred)
print(head(example_predictions))

df

# Find the data type of each column
column_data_types <- sapply(df, class)

# Print the data types
print(column_data_types)
