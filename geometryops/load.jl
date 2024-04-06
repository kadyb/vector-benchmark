import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GeoDataFrames # easiest package to use to load Geopackage files
using Chairmarks

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
function _read(path)
    GeoDataFrames.read(path)
end
# Benchmark the reading/loading function
# This uses the `Chairmarks.jl` package to benchmark the `GeoDataFrames.read` function.
# The benchmark will run for 15 seconds.
benchmark = @be GeoDataFrames.read($(joinpath(data_path, "points.gpkg"))) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "load")