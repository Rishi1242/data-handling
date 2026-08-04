library(ggplot2)
library(dplyr)

User_ID <- c("U01","U02","U03","U04","U05","U06")
Gender <- c("Male","Female","Male","Female","Male","Female")
Age <- c(20,22,19,21,23,20)
Screen_Time <- c(4.5,6.0,3.2,7.1,2.8,5.4)
App_Usage_Count <- c(18,25,12,30,10,22)
Data_Used <- c(2.4,3.8,1.6,4.5,1.2,3.1)
Satisfaction <- c(3,5,3,5,2,4)
Usage_Date <- as.Date(c("2025-01-08","2025-01-08","2025-02-11","2025-02-11","2025-03-14","2025-03-14"))

data <- data.frame(User_ID,Gender,Age,Screen_Time,App_Usage_Count,Data_Used,Satisfaction,Usage_Date)

ggplot(data, aes(x=Screen_Time)) +
  geom_histogram(binwidth=1, fill="skyblue", color="black") +
  geom_density(aes(y=after_stat(count)), fill="red", alpha=0.3) +
  labs(title="Histogram and Density Plot of Screen Time",
       x="Screen Time (hrs)",
       y="Count")

ggplot(data, aes(x=Screen_Time, y=Data_Used)) +
  geom_point(color="blue", size=3) +
  geom_smooth(method="lm", color="red", se=FALSE) +
  labs(title="Scatter Plot of Screen Time vs Data Used",
       x="Screen Time (hrs)",
       y="Data Used (GB)")

correlation <- cor(data$Screen_Time, data$Data_Used)
print(correlation)

avg <- data %>%
  group_by(Gender) %>%
  summarise(Average_Satisfaction = mean(Satisfaction))

ggplot(avg, aes(x=Gender, y=Average_Satisfaction, fill=Gender)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=round(Average_Satisfaction,2)), vjust=-0.5) +
  labs(title="Average Satisfaction by Gender",
       x="Gender",
       y="Average Satisfaction")

cat("Correlation between Screen Time and Data Used:", correlation, "\n\n")

cat("Interpretation:\n")
cat("1. The histogram and density plot show that most users spend between 3 and 7 hours on mobile apps.\n\n")
cat("2. The scatter plot indicates a positive relationship between Screen Time and Data Used. As screen time increases, data usage also tends to increase.\n\n")
cat("3. The bar chart compares the average satisfaction scores of Male and Female users. Female users have a slightly higher average satisfaction score.\n")
