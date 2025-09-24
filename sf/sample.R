library(sf)

vec = read_sf("data/polygon.gpkg")
n = 300000

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_sample(vec, n, type = "random", exact = TRUE))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "sample", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/sample-sf.csv", row.names = FALSE)
