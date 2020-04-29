setwd("~/*****")
library(ggplot2)
library(scales)
library(reshape2)

df_1 <- read.csv("~/*****/world_number1_data.csv",header=TRUE)

#WORLD NUMBER 1 POINTS CHART
ggplot(data=df_1, aes(x=Year, y=Points))+
  geom_point()+
  theme(text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16)
        )+ 
  ggtitle("Annual ATP Points of Year-end World Number 1: 2000-2018")+
  geom_smooth(method=lm, color="blue")+
  scale_x_continuous(breaks=seq(2000,2018, 2))+
  scale_y_continuous(breaks=seq(0,18000, 4000), limits = c(0,18000))+
  xlab("Year") + ylab("Year-end ATP Points")

#WORLD NUMBER ONE TOURNAMENTS CHART
ggplot(data=df_1, aes(x=Year, y=T_played))+
  geom_point()+
  theme(text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16)
  )+
  ggtitle("Annual Tournaments Played by Year-end World Number 1: 2000-2018")+
  geom_smooth(method=lm, color="red")+
  scale_x_continuous(breaks=seq(2000,2018, 2))+
  scale_y_continuous(breaks=seq(0,24, 5), limits = c(0,24))+
  ylab("Tournaments Played")

#BIG 3
df_2 <- read.csv("~/*****/2018_big3_data.csv",header=TRUE)
df_2$Date <- as.Date(df_2$Date, format="%m/%d/%y")
mdf_2 <- reshape2::melt(df_2, id.var="Date")
ggplot(data=mdf_2, aes(x=Date, y=value, color=variable ))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        axis.line=element_line(color = "black"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16))+
  ggtitle("ATP Points Earned on 2018 Tour: Big 3")+
  scale_fill_manual("variable", values = c("#F09200", "#0B007C", "#00DD2C"))+
  scale_x_date(labels = date_format("%b"), date_breaks = "1 month")+
  scale_y_continuous(breaks = c(0,2000,4000,6000,8000,10000), limits = c(0,10000))+
  theme_bw()+
  xlab("") + ylab("Points")+
  geom_line(size=0.5)

#REST OF TOP 10
df_3 <- read.csv("~/*****/2018_top10_data.csv",header=TRUE)
df_3$Date <- as.Date(df_3$Date, format="%m/%d/%y")
mdf_3 <- reshape2::melt(df_3, id.var="Date")
ggplot(data=mdf_3, aes(x=Date, y=value, color=variable))+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        axis.line=element_line(color = "black"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16)
        )+
  ggtitle("ATP Points Earned on 2018 Tour: Other Players in Top 10")+
  scale_x_date(labels = date_format("%b"), date_breaks = "1 month")+
  scale_y_continuous(breaks = c(0,2000,4000,6000,8000,10000), limits = c(0,10000))+
  theme_bw()+
  xlab("") + ylab("Points")+
  geom_line(size=0.5)

#BIG 3 AVG TOURNAMENTS CHART
df_4 <- read.csv("~/*****/big3_tournaments.csv")
ggplot(data=df_4, aes(x=tournament, y=value, fill=player))+
  theme(panel.background = element_rect(fill = "white",
                                        colour = "white",
                                        size = 1, linetype = "solid"),
        panel.grid.major = element_line(size = 0.2, linetype = 'solid',
                                        colour = "gray"),
        panel.grid.minor = element_line(size = 0.2, linetype = 'solid',
                                        colour = "gray"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16),
        legend.text = element_text(size = 12)
        )+
  ggtitle("Big 3 Average Tournaments Played per Year: 2004-2018")+
  geom_col(position = "dodge", width = 0.7, alpha=0.9, color="black")+
  scale_fill_manual("Player", values = c("#0B007C", "#00DD2C", "#F09200"))+
  scale_y_continuous(breaks = c(0,2,4,6,8), limits = c(0,8))+
  scale_x_discrete(limits = c("ATP 250", "ATP 500", "Masters 1000", "Grand Slam"))+
  xlab("") + ylab("")+

#ELO CHART
df_5 <- read.csv("~/*****/elo_data.csv")
df_5$cond <- (df_5$Year == 2017 | df_5$Year == 2018)
ggplot(data=df_5, aes(x=Year, y=diff, fill=cond))+
  theme(panel.background = element_rect(fill = "white",
                                        colour = "white",
                                        size = 1, linetype = "solid"),
        panel.grid.major = element_line(size = 0.2, linetype = 'solid',
                                        colour = "gray"),
        panel.grid.minor = element_line(size = 0.1, linetype = 'solid',
                                        colour = "gray"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 15),
        axis.text.y = element_text(color="Black", size = 15),
        axis.title.x = element_text(size=20),
        axis.title.y = element_text(size=20),
        title = element_text(size=16),
        legend.position = "none"
  )+
  ggtitle("Elo Rating Differential of Year-end World No. 1: \nWorld No. 1 Year vs. Career")+
  xlab("") + ylab("Improvement Over Career Elo")+
  geom_histogram(stat="identity",binwidth=1, size=0, alpha=1, col="black")+
  scale_fill_manual(values = c("#27CA00","#FF0000"))+
  scale_y_continuous(breaks = c(-100,0,+100,+200,+300,+400,+500,+600), limits = c(-100,+600))+
  scale_x_continuous(breaks = c(1970,1980,1990,2000,2010,2020), limits = c(1970,2020))