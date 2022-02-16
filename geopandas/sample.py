import os
import timeit
import random
import geopandas
import pandas as pd
from shapely import geometry

wd = os.getcwd()
vec = os.path.join(wd, "data", "polygon.gpkg")
gdf = geopandas.read_file(vec)

def sample(polygon, size):
    points = []
    x_min, y_min, x_max, y_max = polygon.total_bounds
    i = 0
    while i < size:
        x = random.uniform(x_min, x_max)
        y = random.uniform(y_min, y_max)
        point = geometry.Point(x, y)
        if polygon.contains(point)[0]:
            points.append(point)
            i = i + 1
    gdf = geopandas.GeoDataFrame(geometry = points, crs = polygon.crs)
    return gdf

n = 100000
t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    smp = sample(gdf, n)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)
    
df = {'task': ['sample'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'sample-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
