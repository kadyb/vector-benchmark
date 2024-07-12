import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GeoDataFrames # easiest package to use to load Geopackage files
using Chairmarks

using LibGEOS # activate buffer capabilities in GeometryOps

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
point_set = GO.tuples(points_gpkg.geom)
polygon = GO.tuples(only(polygon_gpkg.geom))

# Benchmark the distance function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
benchmark = @be GO.buffer.((GO.GEOS(),), point_set, 100) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "buffer")