library(httr)
library(plumber)

models <- c("model-a", "model-b")
prob_weights <- c(0.80, 0.20)
api_prefix <- "https://colorado.rstudio.com/rsc/model-management/"
api_suffix <- "-predict/predict"

#* @apiTitle Credit Payment Risk - Model Router
#* @apiDescription API endpoint to route traffic betweeen models

#* @param input A list of variables
#* @post /predict
function(input = "1,20000,2,2,1,24,2,2,-1,-1,-2,-2,3913,3102,689,0,0,0,0,689,0,0,0,0") {
  selected_model <- sample(models, 1, prob = prob_weights)
  r <- POST(paste0(api_prefix, selected_model, api_suffix),
            body = list(input = input),
            encode = "json")
  result <- content(r)
  return(result)
}
