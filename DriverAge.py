import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

casualties = pd.read_csv("data/Casualties0514.csv")
accidents = pd.read_csv("data/Accidents0514.csv")
vehicles = pd.read_csv("data/Vehicles0514.csv")
lookup = pd.ExcelFile("data/Road-Accident-Safety-Data-Guide.xls")

driver_age = vehicles["Age_of_Driver"].value_counts(dropna =False)

plt.figure(figsize=(25,25))
sns.barplot(x=driver_age.index, y=driver_age)
plt.xticks(rotation= 45)
plt.xlabel('DriverAge')
plt.ylabel('Drivers Number')
plt.title('Number of Drivers given the Age')

plt.show()