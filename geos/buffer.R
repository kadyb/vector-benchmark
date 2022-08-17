library(sf)
library(geos)

vec = read_sf("data/points.gpkg")
vec = as_geos_geometry(vec)

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time({
    geos_buffer(vec, 100, params = geos_buffer_params(quad_segs = 30))
  })
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "buffer", package = "geos", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/buffer-geos.csv", row.names = FALSE)
