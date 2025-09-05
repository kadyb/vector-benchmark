import os
import numpy
import timeit
import geopandas
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "polygon.gpkg")
gdf = geopandas.read_file(vec)

n = 100000
t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    smp = gdf.sample_points(n)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)
    
df = {'task': ['sample'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'sample-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
