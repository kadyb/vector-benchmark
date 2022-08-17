library(s2)
library(sf)

vec = read_sf("data/points.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(as_s2_geography(vec))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "transform", package = "s2", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/transform-s2.csv", row.names = FALSE)
