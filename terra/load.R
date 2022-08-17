library(terra)

vec = "data/points.gpkg"
t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(vect(vec, proxy = FALSE))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "load", package = "terra", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/load-terra.csv", row.names = FALSE)
