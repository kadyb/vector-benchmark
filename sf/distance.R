library(sf)

vec = read_sf("data/points.gpkg")
vec = vec[1:4000, ]

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_distance(vec, which = "Euclidean"))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "distance", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/distance-sf.csv", row.names = FALSE)
