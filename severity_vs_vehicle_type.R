source("data_preparation_r.R")

library(scales)

percent <- function(x, digits = 2, format = "f", ...) {
  paste0(formatC(100 * x, format = format, digits = digits, ...), "%")
}

vehicle_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Vehicle Type")
df <- left_join(df, vehicle_code, by=c("Vehicle_Type"="code"))
df <- rename(df, Vehicle_name=label)
rm(vehicle_code)

df %>% 
  group_by(Vehicle_name, Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index)) %>%
  mutate(freq = percent(total_accidents / sum(total_accidents))) %>%
  ggplot(aes(x=Vehicle_name, y=freq,fill=Casualty_Outcome)) +
  geom_bar(stat="identity", position="dodge")+
  geom_text(aes(label=freq), vjust=1.6, color="black", size=3)+
  ggtitle("Accident Severity Proportion per vehicle") +
  xlab("Accident Severity") + ylab("Accident Proportion")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  theme(plot.title = element_text(hjust = 0.5), panel.background = element_blank())