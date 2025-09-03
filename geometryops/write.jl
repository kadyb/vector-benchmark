import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GeoDataFrames  # easiest package to use to load Geopackage files
using Chairmarks

include("utils.jl")

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
point_set = GO.tuples(points_gpkg.geometry)
polygon = GO.tuples(polygon_gpkg.geometry)
function _write(gdf)
    GeoDataFrames.write(joinpath(tempdir(), "temp.gpkg"), gdf; crs = GI.crs(first(gdf.geometry)))
end
# Benchmark the writing function
# This uses the `Chairmarks.jl` package to benchmark the `GeoDataFrames.write` function.
# The benchmark will run for 15 seconds.
gdf = GeoDataFrames.DataFrame(:geometry => point_set)
benchmark = @be _write($gdf) seconds=20

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "write")