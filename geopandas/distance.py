import os
import timeit
import geopandas
import shapely
import numpy as np
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "points.gpkg")
gdf = geopandas.read_file(vec)
gdf = gdf[0:4000]

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    dist = shapely.distance(
        np.repeat(gdf.geometry.array.to_numpy().reshape(4000, 1), 4000, 1),
        np.repeat(gdf.geometry.array.to_numpy().reshape(1, 4000), 4000, 0),
    )

    # the same could be done with the following but NxN distance matrix
    # shall be optimally computed using shapely. The time difference
    # on M1 Air is 0.372 vs 0.488

    # dist = gdf.geometry.apply(lambda f: gdf.distance(f))

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)

df = {"task": ["distance"] * 10, "package": ["geopandas"] * 10, "time": t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir("results"):
    os.mkdir("results")
savepath = os.path.join("results", "distance-geopandas.csv")
df.to_csv(savepath, index=False, decimal=",", sep=";")
