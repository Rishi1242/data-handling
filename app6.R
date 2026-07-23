library(shiny)
library(ggplot2)

product <- c("Product A","Product B","Product C")
jan <- c(2000,1500,1200)
feb <- c(2200,1800,1400)
mar <- c(2400,1600,1100)

sales <- data.frame(
  Product=rep(product,3),
  Month=rep(c("January","February","March"),each=3),
  Sales=c(jan,feb,mar)
)

table_data <- data.frame(
  Product=product,
  January=jan,
  February=feb,
  March=mar
)

ui <- fluidPage(
  
  titlePanel("Monthly Product Sales Dashboard"),
  
  h3("1. Grouped Bar Chart"),
  plotOutput("bar"),
  
  h3("2. Stacked Area Chart"),
  plotOutput("area"),
  
  h3("3. Monthly Sales Table"),
  tableOutput("table")
  
)

server <- function(input,output){
  
  output$bar <- renderPlot({
    
    ggplot(sales,aes(x=Month,y=Sales,fill=Product))+
      geom_bar(stat="identity",position="dodge")+
      labs(title="Monthly Product Sales",
           x="Month",
           y="Sales")+
      theme_minimal()
    
  })
  
  output$area <- renderPlot({
    
    ggplot(sales,aes(x=Month,y=Sales,fill=Product,group=Product))+
      geom_area()+
      labs(title="Overall Sales Trend",
           x="Month",
           y="Sales")+
      theme_minimal()
    
  })
  
  output$table <- renderTable({
    
    table_data
    
  })
  
}

shinyApp(ui,server)