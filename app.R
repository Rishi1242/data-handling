library(shiny)
library(ggplot2)

Survey_ID <- c(1,2,3)
Question1 <- c("A","B","C")
Question2 <- c("B","A","A")
Question3 <- c("C","D","B")

data <- data.frame(Survey_ID,Question1,Question2,Question3)

response <- data.frame(
  Question=c(rep("Question1",3),rep("Question2",3),rep("Question3",3)),
  Answer=c(Question1,Question2,Question3)
)

ui <- fluidPage(
  
  titlePanel("Survey Responses Dashboard"),
  
  h3("1. Grouped Bar Chart"),
  plotOutput("groupbar"),
  
  h3("2. Stacked Bar Chart"),
  plotOutput("stackbar"),
  
  h3("3. Survey Response Table"),
  tableOutput("table")
  
)

server <- function(input,output){
  
  output$groupbar <- renderPlot({
    
    ggplot(data,aes(x=Question1,fill=Question1))+
      geom_bar(position="dodge")+
      labs(title="Distribution of Question 1 Responses",
           x="Answer",
           y="Count")+
      theme_minimal()+
      theme(legend.position="none")
    
  })
  
  output$stackbar <- renderPlot({
    
    ggplot(response,aes(x=Question,fill=Answer))+
      geom_bar()+
      labs(title="Overall Distribution of Survey Responses",
           x="Question",
           y="Count",
           fill="Answer")+
      theme_minimal()
    
  })
  
  output$table <- renderTable({
    
    data
    
  })
  
}

shinyApp(ui,server)