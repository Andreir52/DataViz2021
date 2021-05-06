library(ggplot2)
library(dplyr)
source("data_preparation_r.R")

df$Time_Slot <- as.numeric(substr(df$Time,0,2))

ggplot(df, aes(x=as.factor(Number_of_Casualties), y=as.factor(Time), fill=as.factor(Age_Band_of_Driver))) + 
  geom_area(colour = "black", size = .2, alpha = .4) +
  scale_fill_brewer(palette = "Blues")