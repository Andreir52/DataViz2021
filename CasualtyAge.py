import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

casualties = pd.read_csv("data/Casualties0514.csv")
accidents = pd.read_csv("data/Accidents0514.csv")
vehicles = pd.read_csv("data/Vehicles0514.csv")
lookup = pd.ExcelFile("data/Road-Accident-Safety-Data-Guide.xls")

people_age = casualties["Age_of_Casualty"].value_counts(dropna =False)

plt.figure(figsize=(25,25))
sns.barplot(x=people_age.index, y=people_age)
plt.xticks(rotation= 45)
plt.xlabel('Casualities Age')
plt.ylabel('Casualities Number')
plt.title('Number of Casualities given the Age')

plt.show()