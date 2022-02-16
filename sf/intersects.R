library(sf)

points = read_sf("data/points.gpkg")
polygon = read_sf("data/polygon.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_intersects(points, polygon, sparse = FALSE))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "intersects", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-sf.csv", row.names = FALSE)
