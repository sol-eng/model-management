library(plumber)
library(xgboost)

bst = xgb.load("model/xgb.model")

#* @apiTitle Credit Payment Risk - Model B
#* @apiDescription XGBoost Classification Model

#* @param input List of input variables
#* @post /predict
function(input = "1,20000,2,2,1,24,2,2,-1,-1,-2,-2,3913,3102,689,0,0,0,0,689,0,0,0,0") {
  values <- as.numeric(unlist(strsplit(input, split = ",")))
  test_data <- matrix(values, nrow = 1)
  pred <- predict(bst, test_data)
}
