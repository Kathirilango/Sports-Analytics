setwd("~/*****")
library(ggplot2)
library(ggimage)

# O-LINE SPEED VS SIZE CHART
df_oline <- read.csv("~/*****/oline_data.csv",header=TRUE)
ggplot(data = df_oline, aes(x=avg_40, y=avg_weight,))+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5),
        title = element_text(size= 15),
        panel.background = element_blank())+
  ggtitle("2019 Offensive Lines")+
  geom_text(aes(label=ifelse(df_oline$Team=="San Francisco",as.character("San Francisco 49ers"),'')),hjust=0.5,vjust=-2, size = 4)+
  geom_image(aes(image = df_oline$image), size=0.06)+
  scale_x_continuous(name="Avg. 40 Yard Dash Time (s)", limits= c(5.0,5.5), expand = c(0,0)) +
  scale_y_continuous(name="Avg. Weight (lbs)", limits= c(300,325), expand = c(0,0))

df_qb <- read.csv("~/*****/qb_data.csv",header=TRUE)

# QB PA CHART
df_qb$cond <- (df_qb$QB == "J. Garoppolo")
ggplot(data = df_qb[-c(36),], aes(x=reorder(QB, pa_pct, sum), y=pa_pct,fill=cond))+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5), title = element_text(size= 20),
        legend.title = element_blank(),
        axis.text.x = element_text(angle = 90, hjust=0.9, size=15),
        axis.text.y = element_text(size=15),
        panel.background = element_blank())+
  ggtitle("Play Action Percentage")+
  geom_bar(stat="identity",size=0.5, width=0.5)+
  scale_fill_manual(values = c("#3D3D3D","#ED1500"))+
  labs(x="", y="")

# QB PR CHART
df_qb$cond <- (df_qb$QB == "J. Garoppolo on PA" | df_qb$QB == "J. Garoppolo")
ggplot(data = df_qb, aes(x=reorder(QB, pr, sum), y=pr,fill=cond))+
  ggtitle("2019 Passer Rating")+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5), title = element_text(size= 20),
        legend.title = element_blank(),
        axis.text.x = element_text(angle = 90, hjust=0.9, size=15),
        axis.text.y = element_text(size=15),
        panel.background = element_blank())+
  geom_bar(stat="identity",size=0.5, width=0.5)+
  scale_fill_manual(values = c("#3D3D3D","#ED1500"))+
  labs(x="", y="")

# QB PERFORMANCE CHART
df_qb$cond <- (df_qb$QB == "J. Garoppolo")
ggplot(data=df_qb[-c(36),], aes(x=btt_pct, y=twp_pct, color=ifelse(QB=="J. Garoppolo", "Regular Season", "None")))+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5),
        title = element_text(size= 20),
        legend.title = element_blank(),
        legend.position = "None",
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        panel.background = element_blank())+
  ggtitle("2019 Quarterbacks")+
  geom_text(aes(label=QB, x=btt_pct, y=twp_pct, color="blue"),hjust=0.5,vjust=-1, size = 6)+
  geom_point(size=6)+
  scale_color_manual(values = c("black","#3D3D3D", "#ED1500"))+
  geom_hline(yintercept = 3.32, colour="#BDBDBD", linetype="dashed")+
  geom_vline(xintercept = 12.86, colour="#BDBDBD", linetype="dashed")+
  labs(x="Pct. 20+ Yard Throws", y="Pct. Turnover Worthy Plays")+
  annotate(geom="text", x=7, y=1, label="SAFE", color="#19B800", size=12)+
  annotate(geom="text", x=20, y=6, label="VOLATILE", color="#E46F00", size=12)+
  annotate(geom="text", x=20, y=1, label="GOOD", color="blue", size=12)+
  annotate(geom="text", x=7, y=6, label="BAD", color="#C21100", size=12)

# QB SCHEME LOOK CHART
df_qb$cond <- (df_qb$QB == "J. Garoppolo")
ggplot(data = df_qb[-c(36),], aes(x=reorder(QB, sch_pct, sum), y=sch_pct,fill=cond))+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5), title = element_text(size= 20),
        legend.title = element_blank(),
        axis.text.x = element_text(angle = 90, hjust=0.9, size = 15),
        axis.text.y = element_text(size=15),
        panel.background = element_blank())+
  ggtitle("Scheme Look Percentage")+
  geom_bar(stat="identity",size=0.5, width=0.5)+
  scale_fill_manual(values = c("#3D3D3D","#ED1500"))+
  labs(x="", y="")
  
# SF WR TARGET VS TTT CHART
df_wr <- read.csv("~/*****/wr_data.csv",header=TRUE)
df_wr$cond <- (df_wr$Name == "G. Kittle" | df_wr$Name == "D. Samuel")
ggplot(data=df_wr, aes(x=pct_comp, y=ttt, color=ifelse(Name=="D. Samuel" | Name=="G. Kittle", "Regular Season", "None")))+
  theme(text = element_text(family = "Arial", face = "bold"), plot.title = element_text(hjust = 0.5),
        title = element_text(size= 20),
        legend.title = element_blank(),
        legend.position = "None",
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        panel.background = element_blank())+
  ggtitle("2019 49ers Receivers")+
  geom_point(size=6)+
  geom_text(aes(label=Name, x=pct_comp, y=ttt, color="blue"),hjust=0.5,vjust=-1, size = 5)+
  scale_color_manual(values = c("black", "#3D3D3D","#ED1500"))+
  scale_y_continuous(name="Average Time to Throw", limits= c(1.8,3.5), expand = c(0,0)) +
  labs(x="Pct. Completions")+
  annotate(geom="text", x=20, y=3.0, label='atop(bold("* = Running Back"))', color="black", size=6, parse=TRUE)