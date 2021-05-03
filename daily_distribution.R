source("data_preparation_r.R")

new_df<-df %>% 
        group_by(Date) %>% 
        filter(Casualty_Outcome=="Fatal")%>%
        summarize(total_accidents=n_distinct(Accident_Index))

hist(new_df$total_accidents,main="Daily Accidents",xlim=c(0.5,max(new_df$total_accidents)), breaks=max(new_df$total_accidents))
  