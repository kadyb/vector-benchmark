import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GMT # easiest package to use to load Geopackage files
using Chairmarks

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GMT.gmtread(joinpath(data_path, "points.gpkg"))
point_set = map(view(points_gpkg, 1:4000)) do row
    Point2d(row[1], row[2])
end
# Benchmark the distance function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
distance_benchmark = @be [GO.distance(point1, point2) for point1 in $point_set, point2 in $point_set] seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(distance_benchmark; task = "distance")