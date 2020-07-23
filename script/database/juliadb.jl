using JuliaDB
using JuliaDBMeta


data_url = "https://raw.githubusercontent.com/estadistika/assets/master/data/nycflights13.csv";
down_dir = joinpath(homedir(), "Downloads", "nycflights13.csv");
download(data_url, down_dir);

# Load the csv file
nycflights = loadtable(down_dir);
nycflights;

# Filter the columns
cols = (:year, :month, :day, :dep_time, :dep_delay, :arr_time, :arr_delay, :tailnum, :air_time, :dest, :distance);
flights = select(nycflights, cols);

# Access the dimension of the data
length(rows(flights))
length(columns(flights))

# Accessing the Head of the Data
println(select(flights, cols)[1:6]);

# Accessing the Tail of the Data
println(select(flights, cols)[end - 5:end])

# Filter Rows
# Using JuliaDB
println(filter((:month => x -> x .== 1, :day => x -> x .== 1), flights));

# Using JuliaDBMeta
println(@filter flights :month .== 1 && :day .== 1)

# Arrange Rows
println(sort(flights, (:year, :month, :day)))
# for descending order
println(sort(flights, (:year, :month, :day), rev = true))

# Select Columns
println(select(flights, (:year, :month, :day)))

# select columns between year and day (inclusive)
println(select(flights, Between(:year, :day)))

# select all columns except those from year to day (inclusive)
println(select(flights, Not(Between(:year, :day))))

# Rename Column
println(flights)
println(rename(flights, :tailnum, :tail_num))

# Add New Column gain and speed
flights = @transform flights {gain = :arr_delay - :dep_delay, speed = :distance / :air_time * 60};
println(flights)

# Summarize Data
using Statistics
summarize(mean, dropmissing(flights), select = :dep_delay)
@with dropmissing(flights) mean(:dep_delay)

# Grouped Operations
# For grouped operations, we can use the JuliaDB.groupby function or the JuliaDBMeta.@groupby:
# Using JuliaDB
delay = groupby(
    (
        count = length,
        dist = :distance => x -> mean(skipmissing(x)),
        delay = :arr_delay => x -> mean(skipmissing(x))
    ),
    flights,
    :tailnum
    );
println(delay)

# Using JuliaDBMeta
delay = @groupby flights :tailnum {
    count = length(_),
    dist = mean(skipmissing(:distance)),
    delay = mean(skipmissing(:arr_delay))
    }

# Vosualisasi data
using Gadfly
Gadfly.push_theme(:dark)
using DataFrames

delay = filter((:count => x -> x .> 20, :dist => x -> x .< 2000), delay);
plot(
    DataFrame(filter(:delay => x -> !isnan(x), delay)),
    layer(
        x = :dist,
        y = :delay,
        Geom.smooth,
        style(default_color = colorant"red", line_width = 2pt)
    ),
    layer(
        x = :dist,
        y = :delay,
        color = :count,
        size = :count,
        Geom.point,
        style(default_color = colorant"orange", highlight_width = 0pt)
    )
)

# To find the number of planes and the number of flights that go to each possible destination, run:
destinations = JuliaDB.groupby(
    (
        planes = :tailnum => x -> length(unique(x)),
        flights = length
    ),
    flights,
    :dest
); # remove ; to see result

# Using JuliaDBMeta
destinations = @groupby flights :dest {
    planes = length(unique(:tailnum)),
    flights = length(_)
    }

# Piping Multiple Operations
@apply dropmissing(flights) begin
        @groupby (:year, :month, :day) {
            arr = mean(:arr_delay),
            dep = mean(:dep_delay)
        }
        @filter :arr .> 30 || :dep .> 30
    end;
