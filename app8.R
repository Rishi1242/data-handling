library(shiny)
library(ggplot2)

Student_ID <- c("L01","L02","L03","L04","L05","L06")
Gender <- c("Male","Female","Male","Female","Male","Female")
Age <- c(20,22,19,21,23,20)
Course <- c("R","R","SQL","R","R","SQL")
Study_Time <- c(3.5,4.2,2.0,5.0,2.5,4.0)
Videos_Watched <- c(12,15,8,18,9,14)
Quiz_Score <- c(78,85,65,92,70,88)
Login_Date <- as.Date(c("2025-01-05","2025-01-05","2025-02-08","2025-02-08","2025-03-12","2025-03-12"))

data <- data.frame(
  Student_ID,
  Gender,
  Age,
  Course,
  Study_Time,
  Videos_Watched,
  Quiz_Score,
  Login_Date
)

trend <- data.frame(
  Month=c("Jan","Feb","Mar"),
  AvgScore=c(mean(c(78,85)),
             mean(c(65,92)),
             mean(c(70,88)))
)

trend$MovingAverage <- c(
  trend$AvgScore[1],
  mean(trend$AvgScore[1:2]),
  mean(trend$AvgScore[2:3])
)

ui <- fluidPage(
  
  titlePanel("Online Learning Activity Dashboard"),
  
  h3("1. Histogram"),
  plotOutput("hist"),
  
  h3("Boxplot"),
  plotOutput("box"),
  
  h3("2. Scatter Plot"),
  plotOutput("scatter"),
  
  h3("3. Monthly Average Quiz Score"),
  plotOutput("line"),
  
  h3("Student Performance"),
  verbatimTextOutput("insight")
  
)

server <- function(input,output){
  
  output$hist <- renderPlot({
    
    hist(data$Quiz_Score,
         col="skyblue",
         main="Quiz Score Distribution",
         xlab="Quiz Score",
         ylab="Frequency")
    
  })
  
  output$box <- renderPlot({
    
    boxplot(Quiz_Score~Course,
            data=data,
            col="lightgreen",
            main="Quiz Score by Course",
            xlab="Course",
            ylab="Quiz Score")
    
  })
  
  output$scatter <- renderPlot({
    
    ggplot(data,
           aes(x=Study_Time,
               y=Quiz_Score,
               size=Videos_Watched))+
      geom_point(alpha=0.6,color="blue")+
      labs(title="Study Time vs Quiz Score",
           x="Study Time (hrs)",
           y="Quiz Score")+
      theme_minimal()
    
  })
  
  output$line <- renderPlot({
    
    ggplot(trend,aes(x=Month,y=AvgScore,group=1))+
      geom_line(color="red",linewidth=1)+
      geom_point(size=3,color="red")+
      geom_line(aes(y=MovingAverage),
                color="blue",
                linetype="dashed",
                linewidth=1)+
      labs(title="Average Quiz Score per Month",
           x="Month",
           y="Average Quiz Score")+
      theme_minimal()
    
  })
  
  output$insight <- renderText({
    
    "Students who spend more time studying generally score higher in quizzes. Monthly average quiz scores show a slight improvement over time."
    
  })
  
}

shinyApp(ui,server)