using BenchmarkTools
using Distributed
using DistributedArrays
addprocs(4)

# loop
for i in 1:10
    println(i)
end

function tesfungsi(angka)
    for i in 1:10^angka
        if mod(i, 10^4) == 0
            println("oke")
        else
            println(i)
        end
    end
end

tesfungsi(3)

loopBM = @benchmark tesfungsi($7)
