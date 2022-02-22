library(sf)
library(geos)

points = read_sf("data/points.gpkg")
points = as_geos_geometry(points)
polygon = read_sf("data/polygon.gpkg")
polygon = as_geos_geometry(polygon)

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(geos_prepared_intersects(points, polygon))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "intersects", package = "geos", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-geos.csv", row.names = FALSE)
