library(sf)

p1 = st_point(c(388700, 744700)) # upper-left
p2 = st_point(c(649200, 161500)) # down-right
p3 = st_point(c(188600, 550900)) # upper-left
p4 = st_point(c(842500, 350600)) # down-right

# one rectangle from two points
rec1 = st_as_sfc(st_bbox(st_sfc(p1, p2, crs = 2180)))
rec2 = st_as_sfc(st_bbox(st_sfc(p3, p4, crs = 2180)))
polygon = c(rec1, rec2)
polygon = st_union(polygon)

write_sf(polygon, "data/polygon.gpkg")
