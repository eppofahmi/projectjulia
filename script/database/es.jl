using BenchmarkTools
using Distributed
using DistributedArrays
using PyCall
addprocs(4)

elasticsearch = pyimport("elasticsearch");
es = elasticsearch.Elasticsearch("https://search-socmed-vqog764djqh2mc3lzrfscki3au.ap-southeast-1.es.amazonaws.com:443");

q1 = Dict("query"=>Dict("match"=>Dict("full_text"=>Dict("query"=>"bintang emon"))));
t1 = es.search("twitter", body=q1)["hits"]["total"];
ta = es.search("twitter", body=q1);

@benchmark es.search("twitter", body=q1)["hits"]["hits"]

println(t1);

q2 = Dict("query"=>Dict("match"=>Dict("content"=>Dict("query"=>"jokowi"))));
t2 = es.search("onlinenews", body=q2)["hits"]["hits"];
println(t2)
println(q2)
