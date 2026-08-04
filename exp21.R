library(ggplot2)

Movie_ID <- c(1,2,3,4,5)
Genre <- c("Action","Comedy","Drama","Action","Comedy")
Rating <- c(4.5,3.8,4.2,4.7,3.5)
Duration <- c(120,90,140,130,95)

data <- data.frame(Movie_ID,Genre,Rating,Duration)

ggplot(data,aes(x=Rating))+
  geom_histogram(binwidth=0.5,fill="skyblue",color="black")+
  labs(title="Histogram of Movie Ratings",
       x="Rating",
       y="Frequency")

genre_count <- table(data$Genre)

pie(genre_count,
    col=c("red","green","blue"),
    main="Genre Distribution")

avg_rating <- aggregate(Rating~Genre,data,mean)

barplot(avg_rating$Rating,
        names.arg=avg_rating$Genre,
        col="orange",
        xlab="Genre",
        ylab="Average Rating",
        main="Average Rating by Genre")

text(x=1:length(avg_rating$Genre),
     y=avg_rating$Rating,
     labels=round(avg_rating$Rating,2),
     pos=3)

plot(data$Duration,
     data$Rating,
     pch=19,
     col="blue",
     xlab="Duration (Minutes)",
     ylab="Rating",
     main="Duration vs Rating")