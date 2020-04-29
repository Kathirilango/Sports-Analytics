setwd("~/*****")
library(tidyquant)
library(ggplot2)
library(plyr)
library(plotly)
source("https://raw.githubusercontent.com/iascchen/VisHealth/master/R/calendarHeat.R")

#FEDERER WORLD #1 CALENDAR
df_roger <-read.csv("~/*****/roger_calendar.csv")
df_roger$weekday = as.POSIXlt(df_roger$date)$wday 
df_roger$weekday<-factor(df_roger$weekdaynum,levels=rev(1:7),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)
df_roger$month<-factor(month(df_roger$date),levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
df_roger$yearmonth<- factor(as.yearmon(df_roger$date))
df_roger<-ddply(df_roger,.(yearmonth),transform,monthweek=1+week-min(week))
df_roger <- df_roger[!(df_roger$points == 0),]

roger_plot <- ggplot(df_roger, aes(monthweek, weekday, fill = df_roger$points)) + 
  theme(panel.background = element_rect(fill = "white", colour = "white", size = 1, linetype = "solid"),
        panel.grid.major = element_line(size = 0, linetype = 'solid', colour = "white"),
        panel.grid.minor = element_line(size = 0, linetype = 'solid', colour = "white"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 8),
        axis.text.y = element_text(color="Black", size = 8),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10),
        title = element_text(size=12))+
  ggtitle("Activity in World Number 1 Years: Roger Federer") + 
  geom_tile(colour = "white") + 
  facet_grid(~month) + 
  scale_fill_gradient(low="#FFDEDE", high="#FF0000") +  
  xlab("Week") + ylab("") + 
  labs(fill = "ATP Points Gained")+
  coord_fixed(3.0)

#NADAL WORLD #1 CALENDAR
df_rafa <- read.csv("~/*****/rafa_calendar.csv")
df_rafa$weekday = as.POSIXlt(df_rafa$date)$wday 
df_rafa$weekday<-factor(df_rafa$weekdaynum,levels=rev(1:7),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)
df_rafa$month<-factor(month(df_rafa$date),levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
df_rafa$yearmonth<- factor(as.yearmon(df_rafa$date))
df_rafa<-ddply(df_rafa,.(yearmonth),transform,monthweek=1+week-min(week))
df_rafa <- df_rafa[!(df_rafa$points == 0),]

rafa_plot <- ggplot(df_rafa, aes(monthweek, weekday, fill = df_rafa$points)) + 
  theme(panel.background = element_rect(fill = "white", colour = "white", size = 1, linetype = "solid"),
        panel.grid.major = element_line(size = 0, linetype = 'solid', colour = "white"),
        panel.grid.minor = element_line(size = 0, linetype = 'solid', colour = "white"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 8),
        axis.text.y = element_text(color="Black", size = 8),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10),
        title = element_text(size=12))+
  ggtitle("Activity in World Number 1 Years: Rafael Nadal") + 
  geom_tile(colour = "white") + 
  facet_grid(~month) + 
  scale_fill_gradient(low="#FFDEDE", high="#FF0000") +  
  xlab("Week") + ylab("") + 
  labs(fill = "ATP Points Gained")+
  coord_fixed(3.0)

#DJOKOVIC WORLD #1 CALENDAR
df_novak <- read.csv("~/*****/novak_calendar.csv")
df_novak$weekday = as.POSIXlt(df_novak$date)$wday 
df_novak$weekday<-factor(df_novak$weekdaynum,levels=rev(1:7),labels=rev(c("Mon","Tue","Wed","Thu","Fri","Sat","Sun")),ordered=TRUE)
df_novak$month<-factor(month(df_novak$date),levels=as.character(1:12),labels=c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"),ordered=TRUE)
df_novak$yearmonth<- factor(as.yearmon(df_novak$date))
df_novak<-ddply(df_novak,.(yearmonth),transform,monthweek=1+week-min(week))
df_novak <- df_novak[!(df_novak$points == 0),]

novak_plot <- ggplot(df_novak, aes(monthweek, weekday, fill = df_novak$points)) + 
  theme(panel.background = element_rect(fill = "white", colour = "white", size = 1, linetype = "solid"),
        panel.grid.major = element_line(size = 0, linetype = 'solid', colour = "white"),
        panel.grid.minor = element_line(size = 0, linetype = 'solid', colour = "white"),
        text=element_text(family="Arial", face="bold"), plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(color="Black", size = 8),
        axis.text.y = element_text(color="Black", size = 8),
        axis.title.x = element_text(size=10),
        axis.title.y = element_text(size=10),
        title = element_text(size=12))+
  ggtitle("Activity in World Number 1 Years: Novak Djokovic") + 
  geom_tile(colour = "white") + 
  facet_grid(~month) + 
  scale_fill_gradient(low="#FFDEDE", high="#FF0000") +  
  xlab("Week") + ylab("") + 
  labs(fill = "ATP Points Gained")+
  coord_fixed(3.0)

roger_plot
rafa_plot
novak_plot