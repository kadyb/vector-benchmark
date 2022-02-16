# skip the test of this function because it is very slow
if (FALSE) {

  library(s2)
  library(sf)

  vec = read_sf("data/points.gpkg")
  vec = as_s2_geography(vec)

  ## `quad_segs = 30` is similar to `max_cells = 1000`?
  ## this function is extremely slow (n = 1000)
  system.time({x = s2_buffer_cells(vec[1:1000], 100)})
  #>  user  system elapsed
  #> 26.68    0.01   26.74

}
