
import matplotlib.pyplot as plt
import pandas as pd

vehicles = pd.read_csv("data/Vehicles0514.csv")
lookup = pd.ExcelFile("data/Road-Accident-Safety-Data-Guide.xls")
vehicle_type_lookup = lookup.parse("Vehicle Type")

vehicle_type_lookup = vehicle_type_lookup.values.tolist()

vehicle_count = vehicles["Vehicle_Type"].value_counts(
    dropna=False).values

fig1, ax1 = plt.subplots()
wedges, texts, autotexts = ax1.pie(vehicle_count, autopct='%1.1f%%',
        shadow=True, startangle=90)

ax1.legend(wedges, vehicle_type_lookup,
          title="Types",
          loc="center left",
          bbox_to_anchor=(0, 0, 0.5, 1))

ax1.axis('equal')

plt.show()