source("data_preparation_r.R")

gender_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Junction Detail")
df <- left_join(df, gender_code, by=c("Junction_Detail"="code"))
df <- rename(df, Gender=label)
rm(gender_code)

df %>% 
  group_by(junction_type_name,accident_severity) %>% 
  summarize(total_accidents=n_distinct(accident_index)) %>%
  ggplot(aes(x=accident_severity, y=total_accidents,fill=junction_detail)) +
  geom_bar(stat="identity", position="dodge")+
  ggtitle("Accident Severity by Junction Type") +
  xlab("Accident Severity") + ylab("Total Accidents")+
  theme(plot.title = element_text(hjust = 0.5), panel.background = element_blank(),axis.text.x = element_text(angle = 45, hjust = 1))