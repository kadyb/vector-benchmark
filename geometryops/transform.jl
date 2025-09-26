import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GeoDataFrames
import GMT
using Chairmarks
import GeoFormatTypes as GFT
using Proj # activate GeometryOps reprojection

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
points_gpkg.geometry = GI.Point.(points_gpkg.geometry)
point_set = GO.tuples(points_gpkg.geometry)
polygon = GO.tuples(polygon_gpkg.geometry)
polygon = GO.apply(p -> (GI.x(p), GI.y(p)), GI.PointTrait(), only(polygon_gpkg.geometry))
# Benchmark the reproject function
# This uses the `Chairmarks.jl` package to benchmark the
# `GO.reproject` function, which calls the Proj C-API.
# In future it will also support native Julia transformations.
# The benchmark will run for 15 seconds.
# @time GO.reproject(point_set, GI.crs(points_gpkg), GFT.EPSG(4326); always_xy = true);
# benchmark = @be GO.reproject($point_set, $(GI.crs(points_gpkg)), $(GFT.EPSG(4326)); always_xy = false) seconds=15

benchmark = @be GO.reproject(points_gpkg, GFT.EPSG(4326), always_xy = true) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "transform")
