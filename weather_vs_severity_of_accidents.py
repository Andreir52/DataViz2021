import pandas as pd
import matplotlib.pyplot as plt

casualties = pd.read_csv("data/Casualties0514.csv")
accidents = pd.read_csv("data/Accidents0514.csv")
vehicles = pd.read_csv("data/Vehicles0514.csv")
lookup = pd.ExcelFile("data/Road-Accident-Safety-Data-Guide.xls")

weather_lookup = lookup.parse("Weather")
accident_severity_lookup = lookup.parse("Accident Severity")
accidents_weather = pd.merge(accidents["Accident_Severity"], accidents["Weather_Conditions"], right_index=True,
                             left_index=True)

fatal = accidents_weather[accidents_weather['Accident_Severity'] == 1]["Weather_Conditions"].value_counts(
    dropna=False).values
serious = accidents_weather[accidents_weather['Accident_Severity'] == 2]["Weather_Conditions"].value_counts(
    dropna=False).values
slight = accidents_weather[accidents_weather['Accident_Severity'] == 3]["Weather_Conditions"].value_counts(
    dropna=False).values

total = fatal + serious + slight

fatal = fatal * 100 / total
serious = serious * 100 / total
slight = slight * 100 / total

weather_labels = weather_lookup["label"].values.tolist()

testdata = pd.DataFrame({"Fatal": fatal, "Serious": serious, "Slight": slight},
                        index=weather_labels)
ax = testdata.plot.bar()
plt.xticks(rotation=15)
plt.xlabel('Weather Condition')
plt.ylabel('Number of Accidents in %')
plt.title('Percentage of Accidents Given Weather Condition')
plt.show()