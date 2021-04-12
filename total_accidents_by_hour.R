source("data_preparation_r.R")

df$Time_Slot <- as.numeric(substr(df$Time,0,2))

df %>%
  filter(Casualty_Outcome=="Serious")%>%
  group_by(Time_Slot) %>% 
  summarize(total_accidents=n_distinct(Accident_Index)) %>%
    ggplot(aes(x=Time_Slot, y=total_accidents)) +
    geom_bar(stat="identity", fill="steelblue")+
    geom_text(aes(label=total_accidents), vjust=1.6, color="black", size=3)+
    scale_x_continuous(breaks = round(seq(0, 24, by = 2),0)) +
    ggtitle("Total Serious Accidents by Hours from 2005 to 2014") +
    xlab("Hours") + ylab("Total Accidents")+
    theme(plot.title = element_text(hjust = 0.5), panel.background = element_blank())