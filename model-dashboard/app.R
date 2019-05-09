library(ggplot2)
library(httr)
library(shiny)

model_endpoint <- "https://colorado.rstudio.com/rsc/model-management/model-router/predict"
model_inputs <- "35,500000,1,1,1,58,-2,-2,-2,-2,-2,-2,13709,5006,31130,3180,0,5293,5006,31178,3180,0,5293,768"

ui <- fluidPage(
  titlePanel("Model Management Dashboard"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numApiHits", "Number of Model Queries", 10, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("modelResults")
    )
  )
)

server <- function(input, output) {
  output$modelResults <- renderPlot({
    results <- data.frame()
    for (i in c(1:input$numApiHits)){
      r <- POST(model_endpoint,
                body = list(input = model_inputs),
                encode = "json")
      result <- unlist(content(r))
      results <- rbind(results, result)
    }
    ggplot(results, aes(rownames(results), results[,1])) +
      geom_point()
  })
}

shinyApp(ui = ui, server = server)
