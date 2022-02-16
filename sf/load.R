library(sf)

vec = "data/points.gpkg"
t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(read_sf(vec))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "load", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/load-sf.csv", row.names = FALSE)
