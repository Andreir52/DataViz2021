import pickle
import pandas as pd
import numpy as np

from sklearn.cluster import KMeans

n_clusters = 100
count = 0
train_dataset = []


def load_dataset():
    global count
    global n_clusters
    global train_dataset
    vehicles = pd.read_csv("data/Vehicles0514.csv")

    Sex_of_Driver = vehicles["Sex_of_Driver"].values.tolist()
    Age_of_Driver = vehicles["Age_of_Driver"].values.tolist()
    Engine_Capacity = vehicles["Engine_Capacity_(CC)"].values.tolist()
    Age_of_Vehicle = vehicles["Age_of_Vehicle"].values.tolist()

    for i in range(len(Sex_of_Driver)):
        sex = Sex_of_Driver[i]
        age = Age_of_Driver[i]
        capacity = Engine_Capacity[i]
        age_vehicle = Age_of_Vehicle[i]

        if sex != -1 and age != -1 and capacity != -1 and age_vehicle != -1:
            train_dataset.append([sex, age, capacity / 1000, age_vehicle])
            count += 1


def train():
    global n_clusters
    global train_dataset

    X = np.array(train_dataset)
    kmeans = KMeans(n_clusters=n_clusters, random_state=0).fit(X)
    pickle.dump(kmeans, open("./data/kmeans.pkl", "wb"))


def predict():
    global n_clusters
    global count

    kmeans = pickle.load(open("./data/kmeans.pkl", "rb"))
    probability = np.bincount(kmeans.labels_) / (np.ones(shape=(n_clusters)) * count)
    print("done")

    label = kmeans.predict([[1, 23, 1.500, 15]])[0]
    print(probability[label])
    label = kmeans.predict([[2, 23, 1.995, 23]])[0]
    print(probability[label])
    label = kmeans.predict([[1, 24, 1.5, 5]])[0]
    print(probability[label])
    label = kmeans.predict([[1, 40, 1.968, 5]])[0]
    print(probability[label])
    label = kmeans.predict([[2, 24, 1.968, 5]])[0]
    print(probability[label])


load_dataset()
train()
predict()
