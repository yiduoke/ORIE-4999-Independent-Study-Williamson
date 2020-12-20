import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using Statistics
include("helpers.jl")


"""
    flip_coin_max_cut(adj_matrix) 

returns, for a given graph in adjacency matrix form `adj_matrix`,
the 0.5-approximation max cut value and its corresponding vertex 
set partition. The expected cut value is |E|/2.

This is a randomized algorithm and runs in time linear to the 
number of vertices.
"""
function flip_coin_max_cut(adj_matrix)
    A = reduce(vcat,[rand(0:1)==0 ? [i] : [] for i in 1:num_vertices(adj_matrix)]) # after randomly getting 0 or 1, 0 means the vertex goes into A
    cut_val = cut_value(adj_matrix, A)

    return (cut_val, A)
end