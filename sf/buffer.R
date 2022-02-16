library(sf)

vec = read_sf("data/points.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_buffer(vec, 100, nQuadSegs = 30))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "buffer", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/buffer-sf.csv", row.names = FALSE)
