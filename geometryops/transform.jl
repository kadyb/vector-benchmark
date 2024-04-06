import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GMT # easiest package to use to load Geopackage files
using Chairmarks

using Proj # activate GeometryOps reprojection

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GMT.gmtread(joinpath(data_path, "points.gpkg"))
point_set = map(points_gpkg) do row
    Point2d(row[1], row[2])
end
# Benchmark the reproject function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
benchmark = @be GO.reproject($point_set, $(points_gpkg[1].proj4), $("EPSG:4326"); always_xy = false) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "transform")