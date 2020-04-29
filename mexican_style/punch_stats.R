setwd("~/*****")
library(ggplot2)

df <- read.csv("~/*****/MS_powerpunches.csv",header=TRUE)
df_w <- df[df$Result=='W',]
df$P <- df$PP.Thrown / (df$PP.Thrown + df$Jabs.Thrown) *100
ggplot(data=df, aes(x=Result,y=Pct.PP,fill=Result)) +
  geom_violin(color="White", alpha=8/10) +
  theme(text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0), 
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=20),
        legend.title = element_blank(),
        legend.text = element_text(size = 12),
        panel.background = element_rect(fill="White", color="White"))+
  ggtitle("Power Punch % in Winning Rounds vs. Losing Rounds")+
  labs(y="Power Punch %")+
  theme_minimal() +
  scale_fill_manual(values = c("#FE0D0D", "#2B3EED"), labels = c("Width = # rds LOST with given PP pct.", "Width = # rds WON with given PP pct."))