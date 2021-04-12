source("data_preparation_r.R")


gender <- df %>% select(Casualty_Outcome, Gender) %>% 
  filter(Gender !="Data missing or out of range") %>% 
  group_by(Gender, Casualty_Outcome) %>% 
  summarise(t_count = n())
gender


ggplot(gender, aes(x=t_count, y=Gender, fill=Casualty_Outcome)) + 
  geom_bar(stat="identity") + 
  theme_minimal() +
  guides(fill = guide_legend(reverse=TRUE)) + 
  coord_flip() + 
  labs(y="Gender") +
  labs(x="Total count")
