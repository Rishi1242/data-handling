library(shiny)

# ======================================
# Stock Price Dataset
# ======================================
stock_data <- data.frame(
  Date = as.Date(c("2023-01-01",
                   "2023-01-02",
                   "2023-01-03")),
  StockA = c(100,105,110),
  StockB = c(150,152,148),
  StockC = c(120,118,122)
)

# Daily Percentage Change for Stock A
pct_change <- c(NA,
                diff(stock_data$StockA) /
                  head(stock_data$StockA,-1) * 100)

stock_data$PercentChange <- round(pct_change,2)

# ======================================
# User Interface
# ======================================
ui <- fluidPage(
  
  titlePanel("Stock Analysis Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      dateRangeInput(
        "dates",
        "Select Date Range",
        start = min(stock_data$Date),
        end = max(stock_data$Date)
      )
      
    ),
    
    mainPanel(
      
      fluidRow(
        
        column(
          6,
          plotOutput("lineChart", height="300px")
        ),
        
        column(
          6,
          plotOutput("barChart", height="300px")
        )
        
      ),
      
      hr(),
      
      h3("Stock Price Table"),
      
      tableOutput("stockTable")
      
    )
    
  )
  
)

# ======================================
# Server
# ======================================
server <- function(input, output){
  
  filtered <- reactive({
    
    stock_data[
      stock_data$Date >= input$dates[1] &
        stock_data$Date <= input$dates[2],
    ]
    
  })
  
  # ----------------------------------
  # Question 1 - Line Chart
  # ----------------------------------
  output$lineChart <- renderPlot({
    
    data <- filtered()
    
    matplot(
      data$Date,
      data[,2:4],
      type="o",
      pch=1:3,
      lty=1,
      col=c("blue","red","darkgreen"),
      xlab="Date",
      ylab="Stock Price ($)",
      main="Stock Prices Over Time"
    )
    
    legend(
      "topleft",
      legend=c("Stock A","Stock B","Stock C"),
      col=c("blue","red","darkgreen"),
      lty=1,
      pch=1:3
    )
    
  })
  
  # ----------------------------------
  # Question 2 - Bar Chart
  # ----------------------------------
  output$barChart <- renderPlot({
    
    data <- filtered()
    
    values <- data$PercentChange
    values[is.na(values)] <- 0
    
    barplot(
      values,
      names.arg=as.character(data$Date),
      col="orange",
      xlab="Date",
      ylab="Percentage Change (%)",
      main="Daily Percentage Change - Stock A"
    )
    
  })
  
  # ----------------------------------
  # Question 3 - Table
  # ----------------------------------
  output$stockTable <- renderTable({
    
    filtered()[,1:4]
    
  })
  
}

# ======================================
# Question 4 - Dashboard
# ======================================
shinyApp(ui=ui, server=server)