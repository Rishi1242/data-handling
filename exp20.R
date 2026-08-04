library(ggplot2)

Patient_ID <- c(1,2,3,4,5)
Age <- c(25,40,35,50,29)
Waiting_Time <- c(2,5,1,7,3)
Appointment_Status <- c("Attended","Missed","Attended","Missed","Attended")

data <- data.frame(Patient_ID,Age,Waiting_Time,Appointment_Status)

ggplot(data,aes(x=Age))+
  geom_histogram(binwidth=5,fill="skyblue",color="black")+
  labs(title="Histogram of Patient Ages",
       x="Age",
       y="Frequency")

status_count <- table(data$Appointment_Status)

pie(status_count,
    col=c("lightgreen","tomato"),
    main="Appointment Status Distribution")

barplot(data$Waiting_Time,
        names.arg=data$Patient_ID,
        col="orange",
        xlab="Patient ID",
        ylab="Waiting Time (Days)",
        main="Waiting Time by Patient")

plot(data$Age,
     data$Waiting_Time,
     pch=19,
     col="blue",
     xlab="Age",
     ylab="Waiting Time (Days)",
     main="Age vs Waiting Time")