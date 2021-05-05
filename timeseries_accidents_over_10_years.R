source("data_preparation_r.R")

install.packages("forecast")
library(forecast)
library(lubridate)


df$Date_aux<- as.Date(df$Date, "%d/%m/%Y")


new_df<-df %>%  
  filter(Casualty_Outcome=="Fatal")%>%
  group_by(Date_aux) %>%
  arrange(Date_aux) %>%
  summarize(total_accidents=n_distinct(Accident_Index))


startDate<-min(df$Date)
endDate<-max(df$Date)
ts<- msts(new_df$total_accidents,seasonal.periods=12,start=decimal_date(as.Date(startDate, "%d/%m/%Y")))
plot(ts, main="Monthly Fatal Accidents", xlab="Year", ylab="Accidents")


ts.components <- decompose(ts)
plot(ts.components)