library(shiny)

# Import Dataset
student <- read.csv("Student_Mini_Data.csv")

# Convert Date
student$Exam_Date <- as.Date(student$Exam_Date)

ui <- fluidPage(
  
  titlePanel("Student Mini Data Analysis Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput("gender",
                  "Select Gender",
                  choices = c("All", unique(student$Gender)),
                  selected = "All")
      
    ),
    
    mainPanel(
      
      plotOutput("hist"),
      plotOutput("box"),
      plotOutput("scatter"),
      plotOutput("line"),
      
      h3("Student Data"),
      tableOutput("table")
      
    )
  )
)

server <- function(input, output){
  
  data <- reactive({
    
    d <- student
    
    if(input$gender != "All")
      d <- d[d$Gender == input$gender,]
    
    d
    
  })
  
  # -----------------------------------
  # Question 1 Histogram
  # -----------------------------------
  output$hist <- renderPlot({
    
    hist(data()$Math_Score,
         col="skyblue",
         main="Histogram of Math Scores",
         xlab="Math Score")
    
  })
  
  # -----------------------------------
  # Question 1 Boxplot
  # -----------------------------------
  output$box <- renderPlot({
    
    boxplot(Science_Score ~ Gender,
            data=student,
            col=c("pink","lightgreen"),
            main="Science Score by Gender",
            xlab="Gender",
            ylab="Science Score")
    
  })
  
  # -----------------------------------
  # Question 2 Scatter Plot
  # -----------------------------------
  output$scatter <- renderPlot({
    
    cols <- ifelse(data()$Gender=="Male","blue","red")
    
    plot(data()$Study_Hours,
         data()$Math_Score,
         col=cols,
         pch=19,
         xlab="Study Hours",
         ylab="Math Score",
         main="Study Hours vs Math Score")
    
    abline(lm(Math_Score~Study_Hours,data=data()),
           col="darkgreen",
           lwd=2)
    
    legend("topleft",
           legend=c("Male","Female"),
           col=c("blue","red"),
           pch=19)
    
  })
  
  # -----------------------------------
  # Question 3 Line Chart
  # -----------------------------------
  output$line <- renderPlot({
    
    student$Month <- format(student$Exam_Date,"%Y-%m")
    
    avg <- aggregate(Math_Score~Month,
                     student,
                     mean)
    
    plot(avg$Math_Score,
         type="o",
         xaxt="n",
         col="blue",
         xlab="Month",
         ylab="Average Math Score",
         main="Monthly Average Math Score")
    
    axis(1,
         at=1:nrow(avg),
         labels=avg$Month)
    
    ma <- filter(avg$Math_Score,
                 rep(1/2,2),
                 sides=1)
    
    lines(ma,
          col="red",
          lwd=2)
    
    legend("topleft",
           legend=c("Average","Moving Average"),
           col=c("blue","red"),
           lty=1)
    
  })
  
  # -----------------------------------
  # Table
  # -----------------------------------
  output$table <- renderTable({
    
    data()
    
  })
  
}

shinyApp(ui,server)