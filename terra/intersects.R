library(terra)

points = vect("data/points.gpkg")
polygon = vect("data/polygon.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(relate(points, polygon, "intersects"))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "intersects", package = "terra", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/intersects-terra.csv", row.names = FALSE)
