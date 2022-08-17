library(terra)

vec = vect("data/points.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(project(vec, "epsg:4326"))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "transform", package = "terra", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/transform-terra.csv", row.names = FALSE)
