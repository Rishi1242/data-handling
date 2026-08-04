library(ggplot2)

Passenger_ID <- c(1,2,3,4,5)
Age <- c(28,45,33,52,39)
Flight_Hours <- c(2,8,5,10,6)
Satisfaction <- c("High","Medium","High","Low","Medium")

data <- data.frame(Passenger_ID,Age,Flight_Hours,Satisfaction)

ggplot(data,aes(x=Age))+
  geom_histogram(binwidth=5,fill="skyblue",color="black")+
  labs(title="Histogram of Passenger Ages",
       x="Age",
       y="Frequency")

satisfaction_count <- table(data$Satisfaction)

pie(satisfaction_count,
    col=c("lightgreen","orange","tomato"),
    main="Satisfaction Levels")

barplot(data$Flight_Hours,
        names.arg=data$Passenger_ID,
        col="orange",
        xlab="Passenger ID",
        ylab="Flight Hours",
        main="Flight Hours by Passenger")

plot(data$Age,
     data$Flight_Hours,
     pch=19,
     col="blue",
     xlab="Age",
     ylab="Flight Hours",
     main="Age vs Flight Hours")