library(ggplot2)
library(reshape2)

Student_ID <- c("S1","S2","S3","S4","S5")
Age <- c(19,21,20,22,23)
Study_Hours <- c(12,8,15,10,7)
Attendance <- c(90,70,95,85,60)
Test_Score <- c(85,70,92,80,65)
Participation_Score <- c(8,7,9,8,6)

data <- data.frame(Student_ID,Age,Study_Hours,Attendance,Test_Score,Participation_Score)

area_data <- data.frame(
  Student_ID=data$Student_ID,
  Test_Score=data$Test_Score,
  Participation_Score=data$Participation_Score
)

area_long <- melt(area_data,id.vars="Student_ID")

ggplot(area_long,aes(x=Student_ID,y=value,fill=variable,group=variable))+
  geom_area(alpha=0.7)+
  labs(title="Test Score and Participation Score Across Students",
       x="Student",
       y="Score")

data$Attendance_Quartile <- cut(data$Attendance,
                                breaks=quantile(data$Attendance,probs=seq(0,1,0.25)),
                                include.lowest=TRUE)

ggplot(data,aes(x=Attendance_Quartile,y=Study_Hours,fill=Attendance_Quartile))+
  geom_boxplot()+
  labs(title="Study Hours by Attendance Quartiles",
       x="Attendance Quartile",
       y="Study Hours")

ggplot(data,aes(x=Test_Score))+
  geom_density(fill="skyblue",alpha=0.5)+
  labs(title="Density Plot of Test Scores",
       x="Test Score",
       y="Density")

cat("Interpretation:\n")
cat("1. Test Scores are consistently higher than Participation Scores, with both showing similar trends across students.\n\n")
cat("2. Higher attendance quartiles generally correspond to higher study hours. The boxplot displays the median, interquartile range, and any potential outliers.\n\n")
cat("3. The density plot indicates that most test scores are concentrated between 70 and 90, with no significant outliers.\n")