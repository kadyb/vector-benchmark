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

    # https://github.com/kadyb/vector-benchmark/issues/6
    with tempfile.TemporaryDirectory() as tmpdir:
        filename = os.path.join(tmpdir, "test_file.gpkg")
        gdf.to_file(filename, engine = "pyogrio")

        # if we have pyarrow in the environment, you can pass data using
        # arrow stream - 0.68s vs 0.758s

        # gdf.to_file(filename, use_arrow=True)

    toc = timeit.default_timer()
    t_list[i] = round(toc - tic, 4)

df = {"task": ["write"] * 10, "package": ["geopandas"] * 10, "time": t_list}
df = pd.DataFrame.from_dict(df)
if not os.path.isdir("results"):
    os.mkdir("results")
savepath = os.path.join("results", "write-geopandas.csv")
df.to_csv(savepath, index=False, decimal=",", sep=";")
