Post_ID <- c(1,2,3,4,5)
Likes <- c(120,200,150,300,180)
Comments <- c(15,30,20,40,25)
Shares <- c(10,20,12,35,18)

hist(Likes,
     main="Likes",
     xlab="Likes",
     col="blue")

Engagement <- c(sum(Likes),sum(Comments),sum(Shares))
Names <- c("Likes","Comments","Shares")

pie(Engagement,
    labels=Names,
    main="Total Engagement Components",
    col=c("red","green","blue"))

barplot(Comments,
        names.arg=Post_ID,
        main="Comments by Post",
        xlab="Post ID",
        ylab="Comments",
        col="orange")

plot(Likes,Shares,
     main="Likes vs Shares",
     xlab="Likes",
     ylab="Shares",
     pch=19,
     col="blue")