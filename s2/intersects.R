library(s2)
library(sf)

points = read_sf("data/points.gpkg")
points = as_s2_geography(points)
polygon = read_sf("data/polygon.gpkg")
polygon = as_s2_geography(polygon)

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(s2_intersects(points, polygon))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "intersects", package = "s2", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-s2.csv", row.names = FALSE)
