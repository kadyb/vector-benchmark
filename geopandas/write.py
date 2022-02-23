import os
import timeit
import tempfile
import geopandas
import pandas as pd
# import pyogrio

wd = os.getcwd()
vec = os.path.join(wd, "data", "points.gpkg")
gdf = geopandas.read_file(vec)

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    tmp = tempfile.TemporaryFile(suffix = ".gpkg")
    gdf.to_file(tmp)
    # as with read, pyogrio is much faster in writing (10.5s vs 3.79s)
    # but the released version is not able to write to
    # virtual file, so this would fail
    # pyogrio.write_dataframe(gdf, "path")

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)
    
df = {'task': ['write'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'write-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
