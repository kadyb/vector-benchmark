library(sf)
library(geos)

points = read_sf("data/points.gpkg")
points = as_geos_geometry(points)
polygon = read_sf("data/polygon.gpkg")
polygon = as_geos_geometry(polygon)

###############################################
### geometry is not prepared
t_vec_1 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(geos_intersects(points, polygon))
  t_vec_1[i] = t[["elapsed"]]

}

###############################################
### geometry is prepared
t_vec_2 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(geos_prepared_intersects(points, polygon))
  t_vec_2[i] = t[["elapsed"]]

}

output = rbind(data.frame(task = "intersects", package = "geos", time = t_vec_1),
               data.frame(task = "intersects", package = "geos-prepared", time = t_vec_2))
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-geos.csv", row.names = FALSE)
