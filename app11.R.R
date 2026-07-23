# ============================================
# Geographic Data Dashboard using Shiny
# ============================================

library(shiny)

# Dataset
geo_data <- data.frame(
  City = c("City A", "City B", "City C"),
  Population = c(500000, 700000, 600000),
  AvgTemperature = c(75, 68, 80),
  Elevation = c(1000, 800, 1200),
  
  # Sample coordinates (for demonstration)
  Latitude = c(13.08, 28.61, 19.07),
  Longitude = c(80.27, 77.20, 72.88)
)

ui <- fluidPage(
  
  titlePanel("Geographic Data Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      checkboxGroupInput(
        "city",
        "Select Cities:",
        choices = geo_data$City,
        selected = geo_data$City
      )
      
    ),
    
    mainPanel(
      
      fluidRow(
        
        column(
          6,
          plotOutput("mapPlot", height = "350px")
        ),
        
        column(
          6,
          plotOutput("scatterPlot", height = "350px")
        )
        
      ),
      
      hr(),
      
      h3("Geographic Data Table"),
      
      tableOutput("geoTable"),
      
      hr(),
      
      h4("Scatter Plot Insight"),
      
      verbatimTextOutput("insight")
      
    )
    
  )
  
)

server <- function(input, output) {
  
  filtered <- reactive({
    geo_data[geo_data$City %in% input$city, ]
  })
  
  # -----------------------------
  # Question 1 - Map Chart
  # -----------------------------
  output$mapPlot <- renderPlot({
    
    data <- filtered()
    
    plot(
      data$Longitude,
      data$Latitude,
      pch = 19,
      cex = 2,
      col = "blue",
      xlab = "Longitude",
      ylab = "Latitude",
      main = "Geographic Distribution of Cities"
    )
    
    text(
      data$Longitude,
      data$Latitude,
      labels = data$City,
      pos = 3
    )
    
  })
  
  # -----------------------------
  # Question 2 - Scatter Plot
  # -----------------------------
  output$scatterPlot <- renderPlot({
    
    data <- filtered()
    
    plot(
      data$Population,
      data$AvgTemperature,
      pch = 19,
      col = "red",
      cex = 2,
      xlab = "Population",
      ylab = "Average Temperature",
      main = "Population vs Average Temperature"
    )
    
    text(
      data$Population,
      data$AvgTemperature,
      labels = data$City,
      pos = 3
    )
    
  })
  
  # -----------------------------
  # Question 3 - Table
  # -----------------------------
  output$geoTable <- renderTable({
    
    filtered()[,1:4]
    
  })
  
  # -----------------------------
  # Question 2 Insight
  # -----------------------------
  output$insight <- renderText({
    
    "From this small dataset, there is no strong relationship between population and average temperature. City B has the highest population but the lowest temperature, while City C has a moderate population and the highest temperature."
    
  })
  
}

shinyApp(ui = ui, server = server)