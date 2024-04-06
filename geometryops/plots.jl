using CairoMakie, AlgebraOfGraphics, DelimitedFiles, Statistics

results_path = joinpath(dirname(@__DIR__), "results")
results_files = readdir(results_path; join = false)
regex = r"(\w+)-(\w+).csv"
regex_matches = match.(regex, results_files)
results = map(regex_matches) do match
    task, package = match.captures
    data = DelimitedFiles.readdlm(joinpath(results_path, "$task-$package.csv"), ';', header = true)
    (task, package, parse.(Float64, replace.(data[1][:, end], ("," => ".",))))
end

m1 = regex_matches[1]
task, package = m1.captures
data = DelimitedFiles.readdlm(joinpath(results_path, "$task-$package.csv"), ';', header = true)
data[1][:, end]


f = Figure()

for (idx, task) in enumerate(unique(first.(results)))
    records = filter(r -> r[1] == task, results)
    colors = fill(Makie.wong_colors()[1], length(records))
    records_ind = findfirst(==("geometryops"), getindex.(records, 2))
    if !isnothing(records_ind)
        println("Found GeometryOps for $task, coloring it")
        colors[findfirst(==("geometryops"), getindex.(records, 2))] = Makie.wong_colors()[3]
    end
    a, p = barplot(f[idx, 1],
        1:length(records), 
        Statistics.median.(last.(records)); 
        color = colors,
        direction = :x, 
        axis = (; 
            title = task, 
            yticks = (1:length(records), getindex.(records, 2)),
            ylabel = "Package",
            xlabel = "Median time (s)",
        )
    )
    display(f)
end

resize!(f, 800, 1500)
f

# summary plot

marker_map = Dict(
    # R packages
    "sf" => :utriangle,
    "s2" => :utriangle,
    "terra" => :utriangle,
    "geos" => :utriangle,
    # Python package
    "geopandas" => :circle,
    # Julia package
    "geometryops" => :rect,
)

color_map = Dict(
    # R packages
    "sf" => Makie.wong_colors()[1],
    "s2" => Makie.wong_colors()[2],
    "terra" => Makie.wong_colors()[3],
    "geos" => Makie.wong_colors()[4],
    # Python package
    "geopandas" => Makie.wong_colors()[5],
    # Julia package
    "geometryops" => Makie.wong_colors()[6],
)

result_tasks = getindex.(results, 1) .|> string
result_pkgs  = getindex.(results, 2) .|> string
result_times = Statistics.median.(getindex.(results, 3))

using SwarmMakie

using CategoricalArrays

ca = CategoricalArray(result_tasks)
f, a, p = beeswarm(
    ca.refs, result_times;
    marker = getindex.((marker_map,), result_pkgs), 
    color = getindex.((color_map,), result_pkgs),
    axis = (;
        xticks = (1:length(ca.pool.levels), ca.pool.levels),
        xlabel = "Task",
        ylabel = "Median time (s)",
    )
)



Legend(
    f[1, 2],

)

aog_data = AlgebraOfGraphics.data(
    (; 
    tasks = result_tasks, times = result_times, 
    markers = , 
    colors = 
)
) * mapping(
    :tasks, :times; 
    marker = :markers => nonnumeric, 
    color = :colors => nonnumeric
) * visual(Beeswarm) |> draw



beeswarm