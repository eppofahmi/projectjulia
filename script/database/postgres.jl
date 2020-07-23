# connect to posgresql db
using Octo, LibPQ, Tables, DataFrames

# connect to local postrgres
conn = LibPQ.Connection("dbname=ujangfahmi");

# get the table
dtks = execute(conn, "SELECT * FROM dtks");
dtks = columntable(dtks);
dtks = dtks |> DataFrame;
