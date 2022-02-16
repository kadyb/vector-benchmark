library(sf)

bbox = st_bbox(c(xmin = 171670, xmax = 861890, ymax = 775020, ymin = 133220),
               crs = st_crs(2180))
bbox = st_as_sfc(bbox)

set.seed(1)
n = 300000
pts = st_sample(bbox, n, type = "random", exact = FALSE)
write_sf(pts, "data/points.gpkg")
