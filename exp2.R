library(ggplot2)
library(wordcloud)

customer_id <- c(1,2,3,4,5)
age <- c(25,30,35,28,40)
score <- c(4,5,3,4,5)

data <- data.frame(customer_id,age,score)

hist(data$age,
     main="Customer Age Distribution",
     xlab="Age",
     ylab="Frequency",
     col="skyblue")

pie(table(data$score),
    main="Customer Satisfaction Scores",
    labels=c("Score 3","Score 4","Score 5"),
    col=c("red","yellow","green"))

data$AgeGroup <- c("21-30","21-30","31-40","21-30","31-40")

barplot(table(data$AgeGroup,data$score),
        main="Satisfaction by Age Group",
        xlab="Age Group",
        ylab="Count",
        col=c("red","yellow","green"),
        legend=TRUE)

feedback <- c("good","excellent","happy","quality","service","fast","friendly","support","good","excellent")

wordcloud(feedback,
          colors=rainbow(6))


