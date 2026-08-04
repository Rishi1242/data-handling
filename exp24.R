library(ggplot2)

Booking_ID <- c(1,2,3,4,5)
Stay_Nights <- c(2,5,3,7,4)
Guests <- c(2,4,1,3,2)
Room_Type <- c("Standard","Deluxe","Standard","Suite","Deluxe")

data <- data.frame(Booking_ID,Stay_Nights,Guests,Room_Type)

ggplot(data,aes(x=Stay_Nights))+
  geom_histogram(binwidth=1,fill="skyblue",color="black")+
  labs(title="Histogram of Stay Nights",
       x="Stay Nights",
       y="Frequency")

room_count <- table(data$Room_Type)

pie(room_count,
    col=c("lightgreen","orange","tomato"),
    main="Room Type Distribution")

barplot(data$Guests,
        names.arg=data$Booking_ID,
        col="orange",
        xlab="Booking ID",
        ylab="Number of Guests",
        main="Guests per Booking")

plot(data$Guests,
     data$Stay_Nights,
     pch=19,
     col="blue",
     xlab="Guests",
     ylab="Stay Nights",
     main="Guests vs Stay Nights")