library(shiny)

# Import Dataset
energy <- read.csv("Energy_Consumption_Data.csv")

ui <- fluidPage(
  
  titlePanel("Energy Consumption Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("month","Select Month",
                  choices=c("All",unique(energy$Month)),
                  selected="All"),
      
      selectInput("sector","Select Sector",
                  choices=c("All",unique(energy$Sector)),
                  selected="All")
      
    ),
    
    mainPanel(
      
      h3("1. Histogram & Density Plot"),
      plotOutput("hist"),
      
      h3("2. Bubble Scatter Plot"),
      plotOutput("scatter"),
      
      h3("3. Average Renewable Usage"),
      plotOutput("bar"),
      
      h3("4. Monthly Energy Usage"),
      plotOutput("line"),
      
      h3("Energy Consumption Table"),
      tableOutput("table")
      
    )
    
  )
)

server <- function(input, output){
  
  data <- reactive({
    
    d <- energy
    
    if(input$month!="All")
      d <- d[d$Month==input$month,]
    
    if(input$sector!="All")
      d <- d[d$Sector==input$sector,]
    
    d
  })
  
  # Histogram + Density
  output$hist <- renderPlot({
    
    hist(data()$Units_Consumed,
         probability=TRUE,
         col="lightblue",
         main="Units Consumed Histogram",
         xlab="Units Consumed")
    
    lines(density(data()$Units_Consumed),
          col="red",
          lwd=2)
    
  })
  
  # Bubble Scatter Plot
  output$scatter <- renderPlot({
    
    symbols(data()$Temperature,
            data()$Units_Consumed,
            circles=data()$Peak_Hours,
            inches=0.25,
            bg=rgb(0,0,1,0.4),
            fg="black",
            xlab="Temperature (°C)",
            ylab="Units Consumed (kWh)",
            main="Temperature vs Units Consumed")
    
  })
  
  # Average Renewable Usage
  output$bar <- renderPlot({
    
    avg <- aggregate(Renewable_Usage~Sector,
                     energy,
                     mean)
    
    barplot(avg$Renewable_Usage,
            names.arg=avg$Sector,
            col="green",
            ylab="Renewable Usage (%)",
            main="Average Renewable Usage")
    
  })
  
  # Monthly Line Chart
  output$line <- renderPlot({
    
    monthly <- aggregate(Units_Consumed~Month,
                         energy,
                         sum)
    
    month_order <- c("Jan","Feb","Mar","Apr","May","Jun",
                     "Jul","Aug","Sep","Oct","Nov","Dec")
    
    monthly$Month <- factor(monthly$Month,
                            levels=month_order)
    
    monthly <- monthly[order(monthly$Month),]
    
    plot(1:nrow(monthly),
         monthly$Units_Consumed,
         type="o",
         pch=16,
         col="blue",
         xaxt="n",
         xlab="Month",
         ylab="Units Consumed",
         main="Monthly Energy Usage")
    
    axis(1,
         at=1:nrow(monthly),
         labels=monthly$Month)
    
  })
  
  # Table
  output$table <- renderTable({
    
    data()
    
  })
  
}

shinyApp(ui, server)