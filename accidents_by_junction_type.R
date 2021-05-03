source("data_preparation_r.R")

junction_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Junction Detail")
df <- left_join(df, junction_code, by=c("Junction_Detail"="code"))
df <- rename(df, junction_type_name=label)
rm(junction_code)

df %>% 
  filter(Casualty_Outcome=="Slight")%>%
  group_by(junction_type_name,Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index)) %>%
  ggplot(aes(x=Casualty_Outcome, y=total_accidents,fill=junction_type_name)) +
  geom_bar(stat="identity", position="dodge")+
  ggtitle("Accident by Junction Type") +
  xlab(" ") + ylab("Total Accidents")+
  theme(plot.title = element_text(hjust = 0.5), panel.background = element_blank(),axis.text.x = element_text(angle = 45, hjust = 1))
