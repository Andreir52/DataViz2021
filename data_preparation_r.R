library(tidyverse)
library(readxl)
library(factoextra)

Accidents <- read_csv("./data/Accidents0514.csv")
Casualties <- read_csv("./data/Casualties0514.csv")
Vehicles <- read_csv("./data/Vehicles0514.csv")

df <- merge(Accidents, Casualties, by='Accident_Index')
df <- merge(df, Vehicles, by='Accident_Index')


Location_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Police Force")
df <- left_join(df, Location_code, by=c("Police_Force"="code"))
df <- rename(df, Location=label)
rm(Location_code)

Casualty_severity <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Accident Severity")
df <- left_join(df, Casualty_severity, by=c("Casualty_Severity"="code"))
df <- rename(df, Casualty_Outcome=label)
rm(Casualty_severity)


gender_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Sex of Driver")
df <- left_join(df, gender_code, by=c("Sex_of_Driver"="code"))
df <- rename(df, Gender=label)
rm(gender_code)

weather_code <- read_excel("./data/Road-Accident-Safety-Data-Guide.xls", sheet="Weather")
df <- left_join(df, weather_code, by=c("Weather_Conditions"="code"))
df <- rename(df, Weather=label)
rm(weather_code)