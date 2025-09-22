import os
import timeit

import geopandas
import pandas as pd

wd = os.getcwd()
points_path = os.path.join(wd, "data", "points.gpkg")
points = geopandas.read_file(points_path)
polygon_path = os.path.join(wd, "data", "polygon.gpkg")
polygon = geopandas.read_file(polygon_path)

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    output = points.sindex.query(
        polygon.geometry.iloc[0], predicate="intersects", output_format="dense"
    )

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 4)

df = {"task": ["intersects"] * 10, "package": ["geopandas"] * 10, "time": t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir("results"):
    os.mkdir("results")
savepath = os.path.join("results", "intersects-geopandas.csv")
df.to_csv(savepath, index=False, decimal=",", sep=";")
