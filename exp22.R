library(ggplot2)

User_ID <- c(1,2,3,4,5)
Books_Borrowed <- c(2,5,3,6,1)
Days_Kept <- c(10,25,14,30,7)
Fine_Amount <- c(0,15,0,20,0)

data <- data.frame(User_ID,Books_Borrowed,Days_Kept,Fine_Amount)

ggplot(data,aes(x=Books_Borrowed))+
  geom_histogram(binwidth=1,fill="skyblue",color="black")+
  labs(title="Histogram of Books Borrowed",
       x="Books Borrowed",
       y="Frequency")

fine_status <- ifelse(data$Fine_Amount>0,"With Fine","No Fine")
fine_count <- table(fine_status)

pie(fine_count,
    col=c("tomato","lightgreen"),
    main="Users With and Without Fines")

barplot(data$Fine_Amount,
        names.arg=data$User_ID,
        col="orange",
        xlab="User ID",
        ylab="Fine Amount",
        main="Fine Amount by User")

plot(data$Days_Kept,
     data$Fine_Amount,
     pch=19,
     col="blue",
     xlab="Days Kept",
     ylab="Fine Amount",
     main="Days Kept vs Fine Amount")