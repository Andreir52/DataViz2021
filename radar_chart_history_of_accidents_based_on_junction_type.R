# Library
install.packages("fmsb")

source("data_preparation_r.R")


library(fmsb)



df$Date_aux<- as.Date(df$Date, "%d/%m/%Y")
df_2006_2008<- df %>%  
  filter(Casualty_Outcome=="Slight")%>%
  filter(junction_type_name!="Data missing or out of range")%>%
  filter(Date_aux>=as.Date("01/01/2006", "%d/%m/%Y") & Date_aux<=as.Date("01/01/2008", "%d/%m/%Y"))%>%
  group_by(junction_type_name,Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index))
df_2006_2008

df_2008_2010<- df %>%  
  filter(Casualty_Outcome=="Slight")%>%
  filter(Date_aux>=as.Date("01/01/2008", "%d/%m/%Y") & Date_aux<=as.Date("01/01/2010", "%d/%m/%Y"))%>%
  group_by(junction_type_name,Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index))
df_2008_2010

df_2010_2012<- df %>%  
  filter(Casualty_Outcome=="Slight")%>%
  filter(Date_aux>=as.Date("01/01/2010", "%d/%m/%Y") & Date_aux<=as.Date("01/01/2012", "%d/%m/%Y"))%>%
  group_by(junction_type_name,Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index))
df_2010_2012

df_2012_2014<- df %>%  
  filter(Casualty_Outcome=="Slight")%>%
  filter(junction_type_name!="Data missing or out of range")%>%
  filter(Date_aux>=as.Date("01/01/2012", "%d/%m/%Y") & Date_aux<=as.Date("01/01/2014", "%d/%m/%Y"))%>%
  group_by(junction_type_name,Casualty_Outcome) %>% 
  summarize(total_accidents=n_distinct(Accident_Index))
df_2012_2014

list_2006_2008 <- list(df_2006_2008$total_accidents) 
list_2008_2010 <- list(df_2008_2010$total_accidents)
list_2010_2012 <- list(df_2010_2012$total_accidents)
list_2012_2014 <- list(df_2012_2014$total_accidents)

junction_code = df_2012_2014$junction_type_name
junction_code

L1 = list(list_2006_2008, list_2008_2010, list_2010_2012, list_2012_2014)
L1 = as.data.frame(t(as.data.frame(L1)))
min_l1 = min(L1)
max_l1 = max(L1)
L1



# add 2 lines to the dataframe: the max and min of each variable to show on the plot!
data <- rbind(max_l1 , min_l1 , L1)
rownames(data) = c(1,2,3,4,5,6)
colnames(data) <- junction_code
data

# Color vector
colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )

# plot with default options:
radarchart( data  , axistype=1 , seg = 6,
            #custom polygon
            pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
            #custom the grid
            cglcol="grey", cglty=1, axislabcol="grey", cglwd=0.8, caxislabels=seq(0,max_l1,20000),
            #custom labels
            vlcex=0.8 
)

# Add a legend
legend_names <- c("2006-2008", "2008-2010", "2010-2012", "2012-2014")
legend(x=1.5, y=1, legend = legend_names, bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)