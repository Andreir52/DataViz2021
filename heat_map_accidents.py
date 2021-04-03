import folium
import pandas as pd
import matplotlib.pyplot as plt

casualties = pd.read_csv("data/Casualties0514.csv")
accidents = pd.read_csv("data/Accidents0514.csv")
vehicles = pd.read_csv("data/Vehicles0514.csv")
lookup = pd.ExcelFile("data/Road-Accident-Safety-Data-Guide.xls")

accidents['Latitude'] = accidents['Latitude'].astype(float)
accidents['Date'] = accidents['Date'].astype('datetime64')
accidents['Longitude'] = accidents['Longitude'].astype(float)
heat_df = accidents[['Latitude', 'Longitude']]
heat_df = heat_df.dropna(axis=0, subset=['Latitude', 'Longitude'])

heat_data = heat_df.values

from folium.plugins import HeatMap

m = folium.Map(location=[54.251186, -4.463196], width=800, height=700, min_zoom=5, max_zoom=18, zoom_start=6,
               min_lat=48, max_lat=60, min_lon=-13, max_lon=4,
               control_scale=False,
               zoom_control=False)
HeatMap(heat_data, radius=9.5).add_to(m)
m.save("./Data/HeatMap.html")
