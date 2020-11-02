import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using Statistics


"""
    flip_coin_max_cut(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the 2-approximation max cut value and its corresponding vertex 
set partition. The expected cut value is |E|/2.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array. 

This is a randomized algorithm and linear in the number
of vertices.
"""
function flip_coin_max_cut(adj_lists)
    A = reduce(vcat,[rand(0:1)==0 ? [i] : [] for i in 1:length(adj_lists)])
    cut_value = length(A)>0 ? length(reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A])) : 0

    return (cut_value, A)
end


graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
graph_2 = Dict(1=>[2,5], 2=>[1,3,5], 3=>[2,4], 4=>[3,5], 5=>[1,2,4])
graph_3 = Dict(1=>[2,3], 2=>[1,4,5], 3=>[1,6,7], 4=>[2], 5=>[2], 6=>[3], 7=>[3])

test_case_1 = mean([flip_coin_max_cut(graph_1)[1] for i in 1:100])
test_case_2 = mean([flip_coin_max_cut(graph_2)[1] for i in 1:100])
test_case_3 = mean([flip_coin_max_cut(graph_3)[1] for i in 1:100])

println("test 1. mean randomized max cut: $(test_case_1) (should be ≈2)")
println("test 2. mean randomized max cut: $(test_case_2) (should be ≈3)")
println("test 3. mean randomized max cut: $(test_case_3) (should be ≈3)")