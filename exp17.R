library(ggplot2)
library(reshape2)

Vehicle_ID <- c("V1","V2","V3","V4","V5")
Engine_Size <- c(1.5,2.0,3.0,2.5,1.8)
Horsepower <- c(110,150,250,200,130)
Fuel_Efficiency <- c(18,15,12,14,17)
Top_Speed <- c(180,200,250,220,190)
Safety_Rating <- c(4,5,5,4,3)

data <- data.frame(Vehicle_ID,Engine_Size,Horsepower,Fuel_Efficiency,Top_Speed,Safety_Rating)

ggplot(data,aes(x=factor(Safety_Rating),y=Fuel_Efficiency))+
  geom_violin(fill="skyblue")+
  geom_jitter(width=0.1,color="red")+
  labs(title="Fuel Efficiency by Safety Rating",
       x="Safety Rating",
       y="Fuel Efficiency")

ggplot(data,aes(x=Horsepower,y=Top_Speed,color=Engine_Size))+
  geom_point(size=4)+
  labs(title="Horsepower vs Top Speed",
       x="Horsepower",
       y="Top Speed")

corr <- cor(data[,2:6])

corr_df <- melt(corr)

ggplot(corr_df,aes(Var1,Var2,fill=value))+
  geom_tile()+
  geom_text(aes(label=round(value,2)),color="white")+
  scale_fill_gradient2(low="blue",mid="white",high="red",midpoint=0)+
  labs(title="Correlation Heatmap")

