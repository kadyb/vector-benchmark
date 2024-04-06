import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GMT # easiest package to use to load Geopackage files
using Chairmarks

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GMT.gmtread(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GMT.gmtread(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
point_set = map(points_gpkg) do row
    Point2d(row[1], row[2])
end
polygon = GI.Polygon([GI.LinearRing(Point2d.(eachrow(polygon_gpkg)))])
# Benchmark the distance function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
benchmark = @be GO.intersects.(point_set, (polygon,)) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "intersects")