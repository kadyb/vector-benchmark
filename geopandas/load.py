import os
import timeit
import geopandas
# import pyogrio
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "points.gpkg")

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    gdf = geopandas.read_file(vec, engine = "pyogrio")

    # if we have pyarrow in the environment, you can pass data using
    # arrow stream - 0.163s vs 0.32s

    # gdf = geopandas.read_file(vec, use_arrow=True)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 4)

df = {'task': ['load'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'load-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
