library(sf)

vec = read_sf("data/points.gpkg")

t_vec = numeric(10)
for (i in seq_len(10)) {

  tmp = tempfile(fileext = ".gpkg")

  t = system.time(write_sf(vec, tmp))
  t_vec[i] = t[["elapsed"]]

  unlink(tmp)

}

output = data.frame(task = "write", package = "sf", time = t_vec)
if (!dir.exists("results")) dir.create("results")
write.csv2(output, "results/write-sf.csv", row.names = FALSE)
