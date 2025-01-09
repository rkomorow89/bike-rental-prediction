library(caret)

# Define the hyperparameter tuning grid
param_grid <- expand.grid(hidden = list(c(2, 3), c(4, 5)),
                          learningrate.limit = seq(0.1, 0.9, by = 0.1))

param_grid <- expand.grid(layer1 = c(10, 20),
                          layer2 = c(5, 10),
                          layer3 = c(2, 3))

# Use the train() function from the caret package to tune the hyperparameters
tuned_nn <- train(target ~ .,
                  train_set_normalized,
                  method = "neuralnet",
                  tuneGrid = param_grid,
                  metric = "RMSE")

# Extract the best combination of hyperparameters
best_params <- bestTune(tuned_nn)
best_params$hidden

# Train the neural network using the optimized hyperparameters
final_nn <- train(tuned_nn,
                  train_set_normalized,
                  hidden = best_params$hidden,
                  learningrate.limit = best_params$learningrate.limit)

# Use the tune() function to optimize the hyperparameters
tuned_nn_model <- tune(nn_model,
                       formula = target ~ .,
                       data = X_train_normalized,
                       hidden = hidden_range,
                       learningrate.limit = lr_range,
                       linear.output = TRUE)

# Print the optimized hyperparameters
print(tuned_nn_model$best.parameters)

