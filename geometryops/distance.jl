import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GeoDataFrames # easiest package to use to load Geopackage files
using Chairmarks

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form.
# In this particular case, we only compute
# distance between the first 4000 points - otherwise it would get excessive.
point_set = GO.tuples(points_gpkg.geometry[1:5000])
polygon = GO.tuples(only(polygon_gpkg.geometry))

# Benchmark the distance function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
distance_benchmark = @be [GO.distance(point1, point2) for point1 in $point_set, point2 in $point_set] seconds=15 gc=false

# Write the results to a CSV file
write_benchmark_as_csv(distance_benchmark; task = "distance")
