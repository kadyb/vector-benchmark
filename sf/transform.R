library(sf)

vec = read_sf("data/points.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_transform(vec, crs = 4326))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "transform", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/transform-sf.csv", row.names = FALSE)
