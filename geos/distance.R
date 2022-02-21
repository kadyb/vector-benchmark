library(sf)
library(geos)

vec = read_sf("data/points.gpkg")
vec = vec[1:4000, ]
vec = as_geos_geometry(vec)

t_vec = numeric(10)
for (i in seq_len(10)) {

  t = system.time(sapply(vec, FUN = geos_distance, geom2 = vec))
  t_vec[i] = t[["elapsed"]]

}

output = data.frame(task = "distance", package = "geos", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/distance-geos.csv", row.names = FALSE)

### alternative 1
# system.time({
#   mat = matrix(0.0, nrow = length(vec), ncol = length(vec))
#   for (i in seq_along(vec)) {
#     mat[i, ] = geos_distance(vec[i], vec)
#   }
# })
#> 11.28

### alternative 2
# system.time({
#   mat = geos_distance(rep(vec, length(vec)), rep(vec, each = length(vec)))
#   mat = matrix(mat, length(vec), length(vec))
# })
#> 11.12
