library(sf)

points = read_sf("data/points.gpkg")
polygon = read_sf("data/polygon.gpkg")

###############################################
### geometry is not prepared
t_vec_1 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_intersects(points, polygon, sparse = FALSE, prepared = FALSE))
  t_vec_1[i] = t[["elapsed"]]

}

###############################################
### geometry is prepared
t_vec_2 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_intersects(points, polygon, sparse = FALSE, prepared = TRUE))
  t_vec_2[i] = t[["elapsed"]]

}

output = rbind(data.frame(task = "intersects", package = "sf", time = t_vec_1),
               data.frame(task = "intersects", package = "sf-prepared", time = t_vec_2))
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-sf.csv", row.names = FALSE)
