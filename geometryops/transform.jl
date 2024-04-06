import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GMT # easiest package to use to load Geopackage files
using Chairmarks

using Proj # activate GeometryOps reprojection

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
point_set = map(points_gpkg.geom) do row
    Point2d(GI.x(row), GI.y(row))
end
polygon = GO.apply(p -> Point2d(GI.x(p), GI.y(p)), GI.PointTrait(), only(polygon_gpkg.geom))
# Benchmark the reproject function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
benchmark = @be GO.reproject($point_set, $(points_gpkg[1].proj4), $("EPSG:4326"); always_xy = false) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "transform")