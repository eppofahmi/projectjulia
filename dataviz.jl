# menggunakan Pkg. Gadfly
using Gadfly, RDatasets
# Load the Data Set
iris = dataset("datasets", "iris")
# Plot the Data
plot(iris, x=:SepalLength, y=:SepalWidth, Geom.point)
p = plot(iris, x=:SepalLength, y=:SepalWidth, Geom.point);
#Save it to SVG Image format with the specified dimensions
img = SVG("iris_plot.svg", 14cm, 8cm)

# menggunakan Pkg. Makie
using Makie

x = rand(10)
y = rand(10)
colors = rand(10)

scene = scatter(x, y)
scene

# The Makie code to build a line plot is shown in the following code block:
x = range(0, stop = 2pi, length = 80)
f1(x) = sin.(x)
f2(x) = exp.(-x) .* cos.(2pi*x)
y1 = f1(x)
y2 = f2(x)
scene = lines(x, y1, color = :blue)
Makie.scatter!(scene, x, y1, color = :red, markersize = 0.1)
lines!(scene, x, y2, color = :black)
Makie.scatter!(scene, x, y2, color = :green, marker = :utriangle, markersize = 0.1)

# menggunakan Pkg. Plots
using Plots

# 10 data points in 4 series
xs = range(0, 2π, length = 10)
data = [sin.(xs) cos.(xs) 2sin.(xs) 2cos.(xs)]

# We put labels in a row vector: applies to each series
labels = ["Apples" "Oranges" "Hats" "Shoes"]

# Marker shapes in a column vector: applies to data points
markershapes = [:circle, :star5]

# Marker colors in a matrix: applies to series and data points
markercolors = [
    :green :orange :black :purple
    :red   :yellow :brown :white
]

Plots.plot(
    xs,
    data,
    label = labels,
    shape = markershapes,
    color = markercolors,
    markersize = 10
)


using StatsPlots, RDatasets
gr()
iris = dataset("datasets", "iris")
@df iris scatter(
    :SepalLength,
    :SepalWidth,
    group = :Species,
    m = (0.5, [:+ :h :star7], 12),
    bg = RGB(0.2, 0.2, 0.2)
)
