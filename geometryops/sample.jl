import GeometryOps as GO, GeoInterface as GI
using CairoMakie
import GMT # easiest package to use to load Geopackage files
using Chairmarks
using Proj # activate GeometryOps reprojection
include("utils.jl") # include saving utilities as common code

# Load the data
data_path = joinpath(dirname(@__DIR__), "data")
points_gpkg = GeoDataFrames.read(joinpath(data_path, "points.gpkg"))
polygon_gpkg = GeoDataFrames.read(joinpath(data_path, "polygon.gpkg"))
# Process it into a Julia form
point_set = map(points_gpkg.geom) do row
    Point2d(GI.x(row), GI.y(row))
end
polygon = GO.apply(p -> Point2d(GI.x(p), GI.y(p)), GI.PointTrait(), only(polygon_gpkg.geom))
# Create a `sample` function in the vein of the Python function

function _sample(polygon, size)
    ext = GI.extent(polygon)
    xmin, xmax = ext.X
    ymin, ymax = ext.Y

    count = 0
    points = Point2d[]

    while count < size
        x = xmin + (xmax - xmin) * rand()
        y = ymin + (ymax - ymin) * rand()
        point = Point2d(x, y)
        if GO.contains(polygon, point)
            push!(points, point)
            count += 1
        end
    end

    return points

end

# Benchmark the `_sample` function
# This uses the `Chairmarks.jl` package to benchmark the `GO.distance` function.
# The benchmark will run for 15 seconds.
benchmark = @be _sample($polygon, 100_000) seconds=15

# Write the results to a CSV file
write_benchmark_as_csv(benchmark; task = "sample")