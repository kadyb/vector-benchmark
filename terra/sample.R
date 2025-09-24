library(terra)

vec = vect("data/polygon.gpkg")
n = 300000

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(spatSample(vec, n, method = "random"))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "sample", package = "terra", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/sample-terra.csv", row.names = FALSE)
