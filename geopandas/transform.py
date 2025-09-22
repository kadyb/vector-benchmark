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

    gdf_4326 = gdf.to_crs(4326)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 4)
    
df = {'task': ['transform'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'transform-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
