library(sf)

vec = read_sf("data/points.gpkg")

###############################################
### transform indirectly via GDAL
t_vec_1 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(st_transform(vec, crs = 4326))
  t_vec_1[i] = t[["elapsed"]]

}

###############################################
### transform directly using PROJ only
mat = st_coordinates(vec)

t_vec_2 = numeric(10)
for (i in seq_len(10)) {

  t = system.time(sf_project(from = "epsg:2180", to = "epsg:4326", mat))
  t_vec_2[i] = t[["elapsed"]]

}

output = rbind(data.frame(task = "transform", package = "sf-transform", time = t_vec_1),
               data.frame(task = "transform", package = "sf-project", time = t_vec_2))
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/transform-sf.csv", row.names = FALSE)
