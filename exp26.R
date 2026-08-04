Order_id <- c(1,2,3,4,5)
Items_Ordered <- c(2,5,3,4,2)
Bill_Amount <- c(25,60,35,50,20)
Dining_Type <- c("Dine-in","Takeaway","Dine-in","Delivery","Takeaway")
hist(Bill_Amount,main="Bill_Amount",xlab="Bill_Amount",col="blue")
pie(table(Dining_Type),main="dining Types",col=c("red","green","blue"))
barplot(Items_Ordered,
        names.arg=Order_id,
        main="Items Ordered",
        xlab="Order ID",
        ylab="Items",
        col="orange")

plot(Items_Ordered,Bill_Amount,
     main="Items Ordered vs Bill Amount",
     xlab="Items Ordered",
     ylab="Bill Amount",
     pch=19,
     col="blue")
