Plant_ID <- c(1,2,3,4,5)
Output <- c(120,150,100,170,110)
Temperature <- c(65,70,60,75,62)
Status <- c("Active","Active","Maintenance","Active","Maintenance")

hist(Output,
     main="Power Output",
     xlab="Output",
     col="blue")

pie(table(Status),
    main="Plant Status",
    col=c("red","green"))

barplot(Temperature,
        names.arg=Plant_ID,
        main="Temperature by Plant",
        xlab="Plant ID",
        ylab="Temperature",
        col="orange")

plot(Output,Temperature,
     main="Output vs Temperature",
     xlab="Output",
     ylab="Temperature",
     pch=19,
     col="blue")