import os
import timeit
import pandas
import geopandas
import pandas as pd

wd = os.getcwd()
points_path = os.path.join(wd, "data", "points.gpkg")
points = geopandas.read_file(points_path)
polygon_path = os.path.join(wd, "data", "polygon.gpkg")
polygon = geopandas.read_file(polygon_path)

# this function is much faster than loop checking all points
def intersects(points, polygon):
    nrow = len(points)
    rep = [polygon.iloc[0].repeat(nrow)] # replicate polygon geometry
    df = pandas.concat(rep, ignore_index = True)
    gdf = geopandas.GeoDataFrame(geometry = df, crs = polygon.crs)
    x = points.intersects(gdf, align = False)
    return(x)

t_list = [None] * 10
for i in range(10):
    tic = timeit.default_timer()

    output = intersects(points, polygon)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 2)
    
df = {'task': ['intersects'] * 10, 'package': ['geopandas'] * 10, 'time': t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir('results'): os.mkdir('results')
savepath = os.path.join('results', 'intersects-geopandas.csv')
df.to_csv(savepath, index = False, decimal = ',', sep = ';')
