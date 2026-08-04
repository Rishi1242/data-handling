#=========================================
# Student Academic Performance Analysis
#=========================================

# Create Dataset

student <- data.frame(
  Student_ID = c(1,2,3,4,5,6,7,8,9,10,
                 11,12,13,14,15,16,17,18,19,20),
  
  Department = c(
    "Computer Science","Computer Science",
    "Computer Science","Computer Science",
    "Computer Science",
    "Mechanical","Mechanical",
    "Mechanical","Mechanical","Mechanical",
    "Civil","Civil","Civil","Civil","Civil",
    "Electronics","Electronics",
    "Electronics","Electronics","Electronics"
  ),
  
  Semester = c(
    "Semester 1","Semester 2",
    "Semester 1","Semester 2",
    "Semester 1",
    "Semester 1","Semester 2",
    "Semester 1","Semester 2","Semester 1",
    "Semester 1","Semester 2",
    "Semester 1","Semester 2","Semester 1",
    "Semester 1","Semester 2",
    "Semester 1","Semester 2","Semester 1"
  ),
  
  Score = c(
    85,90,78,92,88,
    70,75,68,72,80,
    60,65,70,58,62,
    80,85,88,90,82
  )
)

print(student)


#=========================================
# GRAPH 1 : Bar Plot
# Average Score by Department
#=========================================

avg_score <- aggregate(
  Score ~ Department,
  data = student,
  mean
)

print(avg_score)


bar <- barplot(
  avg_score$Score,
  names.arg = avg_score$Department,
  col = c("blue","green","orange","purple"),
  main = "Average Score by Department",
  xlab = "Department",
  ylab = "Average Score"
)

# Add Value Labels

text(
  x = bar,
  y = avg_score$Score,
  labels = round(avg_score$Score,2),
  pos = 3
)


#=========================================
# GRAPH 2 : Grouped Bar Chart
# Semester-wise Department Performance
#=========================================

semester_avg <- aggregate(
  Score ~ Department + Semester,
  data = student,
  mean
)

print(semester_avg)

matrix_data <- tapply(
  semester_avg$Score,
  list(
    semester_avg$Department,
    semester_avg$Semester
  ),
  identity
)


barplot(
  t(matrix_data),
  beside = TRUE,
  col = c("skyblue","pink"),
  main = "Semester-wise Department Performance",
  xlab = "Department",
  ylab = "Average Score",
  legend.text = TRUE
)


#=========================================
# GRAPH 3 : Histogram
# Student Score Distribution
#=========================================

hist(
  student$Score,
  col = "lightblue",
  border = "black",
  main = "Distribution of Student Scores",
  xlab = "Scores",
  ylab = "Frequency"
)


#=========================================
# GRAPH 4 : Boxplot
# Score Variation Across Departments
#=========================================

boxplot(
  Score ~ Department,
  data = student,
  col = c("yellow","lightgreen",
          "orange","pink"),
  main = "Score Variation Across Departments",
  xlab = "Department",
  ylab = "Student Scores"
)


#=========================================
# Display Student Data Table
#=========================================

plot.new()

title("Student Academic Performance Data Table")


table_data <- rbind(
  c("Student ID","Department","Semester","Score"),
  cbind(
    student$Student_ID,
    student$Department,
    student$Semester,
    student$Score
  )
)


text(
  x = 0.5,
  y = seq(0.95,0.1,length.out = nrow(table_data)),
  labels = apply(
    table_data,
    1,
    paste,
    collapse = "     "
  ),
  cex = 0.7
)


#=========================================
# Save Dataset
#=========================================

write.csv(
  student,
  "Student_Academic_Performance.csv",
  row.names = FALSE
)

cat("Student_Academic_Performance.csv saved successfully.\n")