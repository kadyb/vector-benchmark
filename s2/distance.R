# skip this test because it is quite slow
# (it's not actually Euclidean distance too)
if (FALSE) {

  library(s2)
  library(sf)

  vec = read_sf("data/points.gpkg")
  vec = vec[1:5000, ]
  vec = as_s2_geography(vec)

  t_vec = numeric(10)
  for (i in seq_len(10)) {

    t = system.time(sapply(vec, FUN = s2_distance, y = vec))
    t_vec[i] = t[["elapsed"]]
    #> mean time: 16.74 s

  }

  output = data.frame(task = "distance", package = "s2", time = t_vec)
  if (!dir.exists("results")) dir.create("results")
  write.csv2(output, "results/distance-s2.csv", row.names = FALSE)

}
