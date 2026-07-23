library(shiny)
library(ggplot2)

customer_id <- c(1,2,3)
age <- c(28,35,42)
gender <- c("Female","Male","Female")
income <- c(50000,60000,75000)

data <- data.frame(customer_id,age,gender,income)

ui <- fluidPage(
  
  titlePanel("Customer Demographics Dashboard"),
  
  h3("1. Customer Age Distribution"),
  plotOutput("bar"),
  
  h3("2. Gender Distribution"),
  plotOutput("pie"),
  
  h3("3. Customer Demographics Table"),
  tableOutput("table")
  
)

server <- function(input,output){
  
  output$bar <- renderPlot({
    
    ggplot(data,aes(x=factor(age),fill=factor(age)))+
      geom_bar()+
      labs(title="Customer Age Distribution",
           x="Age",
           y="Count")+
      theme_minimal()+
      theme(legend.position="none")
    
  })
  
  output$pie <- renderPlot({
    
    pie(table(data$gender),
        labels=names(table(data$gender)),
        main="Gender Distribution",
        col=rainbow(2))
    
  })
  
  output$table <- renderTable({
    
    data
    
  })
  
}

shinyApp(ui,server)