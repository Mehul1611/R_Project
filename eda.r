##### Load required libraries #####
library(shiny)
library(dplyr)
library(plotly)
library(shinythemes)
library(rgl)
library(rpart)
library(shinyjs)

source("E:/R/ml.r")

##### Load Zomato data #####
zomato_data <- read.csv("E:/R/data.csv", stringsAsFactors = FALSE)

######## Data Cleaning ###########

zomato_data <- zomato_data[, !(names(zomato_data) %in% c('res_id', 'url', 'address','locality', 'zipcode', 'locality_verbose','cuisines','timings','currency','highlights','opentable_support'))]

names(zomato_data) <- c("Name","Establ","City", "City_id", "Lat","Long", "C_ID", "Cost", "Price", "Agg", "Rating",'Votes','Count','Delivery','Takeaway')


###### UI Creation ######
ui <- fluidPage(
  theme = shinytheme("cyborg"),
  titlePanel("Zomato Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x_axis", "X-Axis", choices = c("None", names(zomato_data)), selected = "None"),
      selectInput("y_axis", "Y-Axis", choices = c("None", names(zomato_data)), selected = "None"),
      selectInput("z_axis", "Z-Axis", choices = c("None", names(zomato_data)), selected = "None"),
      numericInput("city_id"," city id",min=1,max=12000,value=34),
       numericInput("average_cost_for_two","Average cost",min=1,max=12000,value=600),
      numericInput("price_range","Price Range",min=1,max=12000,value=2),
      numericInput("aggregate_rating","Agrgregate rating",min=1,max=12000,value=4.2),
      numericInput("votes","Votes",min=2,max=1000,value=1500),
      numericInput("photo_count","Photo Count",min=1,max=1000,value=154),
      
      
      actionButton("predict_button", "Predict"),
      br(),
      h3("Random Forest Model Results:"),
      textOutput("prediction_result")
     
      
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Bar Chart", plotlyOutput("barChart")),
        tabPanel("3D Scatter Plot", plotlyOutput("scatterPlot")),
        tabPanel("Heatmap", plotlyOutput("heatmap")),
        tabPanel("Clustered Bar Chart", plotlyOutput("clusteredBarChart")),
        tabPanel("Line Chart", plotlyOutput("lineChart")),
        tabPanel("Scatter Plot", plotlyOutput("simpleScatterPlot")),
        tabPanel("RGL 3D Plot", rglwidgetOutput("rglPlot"))
        
        
      )
    )
    
  )
)

#### Server Creation ####
server <- function(input, output) {
  # Bar Chart
  output$barChart <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None") {
      bar_chart <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), type = 'bar', name = 'Rating')
      bar_chart %>% layout(title = paste("Bar Chart: ", input$y_axis, " by ", input$x_axis), 
                           xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
    }
  })
  
  # 3D Scatter Plot
  output$scatterPlot <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None" && input$z_axis != "None") {
      scatter_plot <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), 
                              z = ~get(input$z_axis), type = 'scatter3d', mode = 'markers')
      scatter_plot %>% layout(title = paste("3D Scatter Plot: ", input$z_axis, " by ", input$x_axis, " and ", input$y_axis), 
                              scene = list(xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis), 
                                           zaxis = list(title = input$z_axis)))
    }
  })
  # Clustered Bar Chart
  output$clusteredBarChart <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None") {
      clustered_bar_chart <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), type = 'bar',
                                     name = 'Rating', split = ~City_id)
      clustered_bar_chart %>% layout(title = paste("Clustered Bar Chart: ", input$y_axis, " by ", input$x_axis), 
                                     xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
    }
  })
  
  # Heatmap
  output$heatmap <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None" && input$z_axis != "None") {
      heatmap_plot <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), z = ~get(input$z_axis), type = 'heatmap')
      heatmap_plot %>% layout(title = paste("Heatmap: ", input$z_axis, " by ", input$x_axis, " and ", input$y_axis),
                              xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
    }
  })
  
  # Line Chart
  output$lineChart <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None") {
      line_chart <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), 
                            type = 'scatter', mode = 'lines', name = 'Rating')
      line_chart %>% layout(title = paste("Line Chart: ", input$y_axis, " by ", input$x_axis), 
                            xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
    }
  })
  # rgl 3D Scatter Plot
  output$rglPlot <- renderRglwidget({
    if (input$x_axis != "None" && input$y_axis != "None" && input$z_axis != "None") {
      rgl.open()
      plot3d(zomato_data[[input$x_axis]], zomato_data[[input$y_axis]], zomato_data[[input$z_axis]], col = 'blue', size = 2)
      rglwidget()
    }
  })
  
  # Scatter Plot
  output$simpleScatterPlot <- renderPlotly({
    if (input$x_axis != "None" && input$y_axis != "None") {
      scatter_plot_simple <- plot_ly(zomato_data, x = ~get(input$x_axis), y = ~get(input$y_axis), 
                                     type = 'scatter', mode = 'markers', name = 'Rating')
      scatter_plot_simple %>% layout(title = paste("Scatter Plot: ", input$y_axis, " by ", input$x_axis),
                                     xaxis = list(title = input$x_axis), yaxis = list(title = input$y_axis))
    }
  })
observeEvent(input$predict_button, {
    isolate({
      if (!is.null(input$city_id)&& !is.null(input$average_cost_for_two) && !is.null(input$price_range) && !is.null(input$aggregate_rating) && !is.null(input$votes) &&  !is.null(input$photo_count)) {
        # Create a new data frame with the numeric Age, Category, Size, Gender, and Channel
        new_data <- data.frame(city_id=input$city_id, average_cost_for_two=input$average_cost_for_two,price_range=input$price_range, aggregate_rating = input$aggregate_rating ,votes = input$votes, photo_count = input$photo_count)
        
        # Predict using the random forest model
        predictions <- predict(model, new_data)
        # Extract the first prediction
        prediction <- predictions[1]
        output$prediction_result <- renderText({
          paste("Aggregate Rating is:", round(as.numeric(prediction), 2))
          paste("Accuracy:", round(as.numeric(prediction), 2))
        })
      } else {
        output$prediction_result <- renderText({
          "Please enter Age, Category, Size, Gender, and Channel to predict the Amount."
        })
      }
    })
  })
  
}


shinyApp(ui = ui, server = server)