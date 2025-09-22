import os
import timeit
import geopandas
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "points.gpkg")
gdf = geopandas.read_file(vec)

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    buffer = gdf.buffer(100, resolution = 30)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 4)
    
df = {'task': ['buffer'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'buffer-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
