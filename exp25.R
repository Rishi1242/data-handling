library(ggplot2)

User_ID <- c(1,2,3,4,5)
Steps <- c(7000,10000,8500,12000,6500)
Calories_Burned <- c(250,400,320,500,220)
Active_Minutes <- c(40,60,50,75,35)

data <- data.frame(User_ID,Steps,Calories_Burned,Active_Minutes)

ggplot(data,aes(x=Steps))+
  geom_histogram(binwidth=1000,fill="skyblue",color="black")+
  labs(title="Histogram of Daily Steps",
       x="Daily Steps",
       y="Frequency")

activity_level <- ifelse(data$Active_Minutes>=60,"High",
                         ifelse(data$Active_Minutes>=40,"Medium","Low"))
activity_count <- table(activity_level)

pie(activity_count,
    col=c("lightgreen","orange","tomato"),
    main="Activity Level Categories")

barplot(data$Calories_Burned,
        names.arg=data$User_ID,
        col="orange",
        xlab="User ID",
        ylab="Calories Burned",
        main="Calories Burned by User")

plot(data$Steps,
     data$Calories_Burned,
     pch=19,
     col="blue",
     xlab="Steps",
     ylab="Calories Burned",
     main="Steps vs Calories Burned")
