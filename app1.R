library(shiny)
library(ggplot2)

product_id <- c(1,2,3,4,5)
product_name <- c("Product A","Product B","Product C","Product D","Product E")
quantity <- c(250,175,300,200,220)

category <- c("Electronics","Electronics","Furniture","Furniture","Accessories")
price <- c(1200,900,1500,1000,800)

data <- data.frame(product_id,product_name,quantity,category,price)

ui <- fluidPage(
  
  titlePanel("Product Inventory Dashboard"),
  
  h3("1. Bar Chart"),
  plotOutput("bar"),
  
  h3("2. Stacked Bar Chart"),
  plotOutput("stack"),
  
  h3("3. Scatter Plot"),
  plotOutput("scatter"),
  
  h3("Insight"),
  verbatimTextOutput("insight")
  
)

server <- function(input,output){
  
  output$bar <- renderPlot({
    
    ggplot(data,aes(x=product_name,y=quantity,fill=product_name))+
      geom_bar(stat="identity")+
      labs(title="Product Inventory",
           x="Product",
           y="Quantity Available")+
      theme_minimal()+
      theme(legend.position="none")
    
  })
  
  output$stack <- renderPlot({
    
    ggplot(data,aes(x=category,y=quantity,fill=product_name))+
      geom_bar(stat="identity")+
      labs(title="Quantity by Product Category",
           x="Category",
           y="Quantity",
           fill="Product")+
      theme_minimal()
    
  })
  
  output$scatter <- renderPlot({
    
    ggplot(data,aes(x=price,y=quantity))+
      geom_point(size=4,color="blue")+
      geom_smooth(method="lm",se=FALSE,color="red")+
      labs(title="Price vs Quantity Available",
           x="Product Price",
           y="Quantity Available")+
      theme_minimal()
    
  })
  
  output$insight <- renderText({
    
    "The scatter plot shows the relationship between product price and quantity available. There is no strong correlation in this sample data. Higher-priced products do not always have higher inventory."
    
  })
  
}

shinyApp(ui,server)