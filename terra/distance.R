library(terra)

vec = vect("data/points.gpkg")
vec = vec[1:5000, ]

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(as.matrix(distance(vec)))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "distance", package = "terra", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/distance-terra.csv", row.names = FALSE)
