source("data_preparation_r.R")

df %>%
  filter(Casualty_Outcome=="Serious")%>%
  group_by(Weather) %>% 
  summarize(total_accidents=n_distinct(Accident_Index)) %>%
  ggplot(aes(x=Weather, y=total_accidents)) +
  geom_bar(stat="identity", fill="steelblue")+
  geom_text(aes(label=Weather), vjust=1.6, color="black", size=3)+
  ggtitle("Total Serious Accidents by weather from 2005 to 2014") +
  xlab("Weather Condition") + ylab("Total Accidents")+
  theme(plot.title = element_text(hjust = 0.5), panel.background = element_blank(), axis.text.x=element_blank())