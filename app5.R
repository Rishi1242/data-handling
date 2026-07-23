library(shiny)
library(ggplot2)

date <- c("2023-01-01","2023-01-02","2023-01-03","2023-01-04","2023-01-05")
page_views <- c(1500,1600,1400,1650,1800)
ctr <- c(2.3,2.7,2.0,2.4,2.6)

likes <- c(300,350,280,370,400)
shares <- c(120,140,100,130,150)
comments <- c(80,90,70,85,95)

traffic <- data.frame(date,page_views,ctr)

interaction <- data.frame(
  date=rep(date,3),
  type=rep(c("Likes","Shares","Comments"),each=5),
  count=c(likes,shares,comments)
)

ui <- fluidPage(
  
  titlePanel("Website Analytics Dashboard"),
  
  h3("1. Daily Page Views"),
  plotOutput("line"),
  
  h3("2. Click Through Rate"),
  plotOutput("bar"),
  
  h3("3. User Interactions"),
  plotOutput("area")
  
)

server <- function(input,output){
  
  output$line <- renderPlot({
    
    ggplot(traffic,aes(x=date,y=page_views,group=1))+
      geom_line(color="blue")+
      geom_point(size=3,color="red")+
      labs(title="Daily Page Views",
           x="Date",
           y="Page Views")+
      theme_minimal()
    
  })
  
  output$bar <- renderPlot({
    
    ggplot(traffic,aes(x=date,y=ctr,fill=date))+
      geom_bar(stat="identity")+
      labs(title="Click Through Rate",
           x="Date",
           y="CTR (%)")+
      theme_minimal()+
      theme(legend.position="none")
    
  })
  
  output$area <- renderPlot({
    
    ggplot(interaction,aes(x=date,y=count,fill=type,group=type))+
      geom_area()+
      labs(title="User Interactions",
           x="Date",
           y="Count",
           fill="Interaction")+
      theme_minimal()
    
  })
  
}

shinyApp(ui,server)