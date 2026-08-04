#=========================================
# Water Quality Monitoring Analysis
#=========================================

# Create Dataset

water <- data.frame(
  Sample_ID = c(1,2,3,4,5),
  pH_Level = c(7.2,6.8,7.5,6.5,7.1),
  Turbidity = c(3,5,2,7,4),
  Quality = c("Good",
              "Fair",
              "Good",
              "Poor",
              "Fair")
)

print(water)


#=========================================
# GRAPH 1 : Histogram
# pH Level Distribution
#=========================================

hist(
  water$pH_Level,
  col = "lightblue",
  border = "black",
  main = "Distribution of pH Levels",
  xlab = "pH Level",
  ylab = "Frequency"
)


#=========================================
# GRAPH 2 : Pie Chart
# Water Quality Categories
#=========================================

quality_count <- table(water$Quality)

pie(
  quality_count,
  col = c("green","orange","red"),
  main = "Water Quality Category Distribution",
  labels = paste(
    names(quality_count),
    quality_count
  )
)


#=========================================
# GRAPH 3 : Bar Chart
# Turbidity by Sample
#=========================================

bar <- barplot(
  water$Turbidity,
  names.arg = paste("Sample",water$Sample_ID),
  col = c("skyblue",
          "purple",
          "green",
          "red",
          "orange"),
  main = "Turbidity Level by Sample",
  xlab = "Sample ID",
  ylab = "Turbidity"
)

# Add Value Labels

text(
  x = bar,
  y = water$Turbidity,
  labels = water$Turbidity,
  pos = 3
)


#=========================================
# GRAPH 4 : Scatter Plot
# pH Level vs Turbidity
#=========================================

plot(
  water$pH_Level,
  water$Turbidity,
  pch = 19,
  cex = 1.5,
  col = "blue",
  main = "pH Level vs Turbidity",
  xlab = "pH Level",
  ylab = "Turbidity"
)

# Add Trend Line

model <- lm(
  Turbidity ~ pH_Level,
  data = water
)

abline(
  model,
  col = "red",
  lwd = 2
)


#=========================================
# Display Water Quality Data Table
#=========================================

plot.new()

title("Water Quality Monitoring Data Table")

table_data <- rbind(
  c("Sample ID","pH Level","Turbidity","Quality"),
  cbind(
    water$Sample_ID,
    water$pH_Level,
    water$Turbidity,
    water$Quality
  )
)

text(
  x = 0.5,
  y = seq(0.9,0.2,length.out = nrow(table_data)),
  labels = apply(table_data,1,paste,collapse="     "),
  cex = 0.9
)


s#=========================================
# Save Dataset
#=========================================

write.csv(
  water,
  "Water_Quality_Monitoring.csv",
  row.names = FALSE
)

cat("Water_Quality_Monitoring.csv saved successfully.\n")