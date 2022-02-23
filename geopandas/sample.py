import os
import numpy
import timeit
import geopandas
import pandas as pd

wd = os.getcwd()
vec = os.path.join(wd, "data", "polygon.gpkg")
gdf = geopandas.read_file(vec)

def sample(polygon, size):
    count = 0
    points = []
    x_min, y_min, x_max, y_max = polygon.total_bounds

    while count < size:
        pts = geopandas.GeoSeries.from_xy(
            numpy.random.uniform(x_min, x_max, size),
            numpy.random.uniform(y_min, y_max, size)
        )
        hits = pts[pts.sindex.query(polygon.geometry.iloc[0], predicate = "contains")]
        count += len(hits)
        points.extend(hits)

    gdf = geopandas.GeoDataFrame(geometry = points[0:size], crs = polygon.crs)
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
