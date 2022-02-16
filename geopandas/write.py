import os
import timeit
import tempfile
import geopandas
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "points.gpkg")
gdf = geopandas.read_file(vec)

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    tmp = tempfile.TemporaryFile(suffix = ".gpkg")
    # it is obligatory to define the driver
    gdf.to_file(tmp, driver = "GPKG")

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)
    
df = {'task': ['write'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'write-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
