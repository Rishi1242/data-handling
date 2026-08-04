Patient_ID <- c("P1","P2","P3","P4","P5")
Age <- c(25,40,55,35,60)
BMI <- c(22,28,30,26,32)
BP <- c(120,135,145,130,150)
Cholesterol <- c(180,210,240,200,260)

data <- data.frame(Patient_ID,Age,BMI,BP,Cholesterol)

pairs(data[,2:5],
      main="Scatterplot Matrix",
      col="blue")

qqnorm(data$Cholesterol,
       main="Q-Q Plot of Cholesterol")
qqline(data$Cholesterol,
       col="red")

plot(ecdf(data$Cholesterol),
     main="ECDF of Cholesterol",
     xlab="Cholesterol",
     ylab="ECDF")

avg <- c(mean(Age),
         mean(BMI),
         mean(BP),
         mean(Cholesterol))

barplot(avg,
        names.arg=c("Age","BMI","BP","Cholesterol"),
        col=c("red","blue","green","orange"),
        main="Average Health Indicators",
        xlab="Health Indicators",
        ylab="Average Value")

cat("Interpretation:\n")
cat("1. Scatterplot Matrix: Age, BMI, BP and Cholesterol show a positive relationship. Older patients generally have higher BP and Cholesterol.\n\n")

cat("2. Q-Q Plot and ECDF: Cholesterol values show slight deviation from normality with a mild right skew.\n\n")

cat("3. Bar Chart: Average BP and Cholesterol are comparatively high, indicating increased overall health risk among the patients.\n")
