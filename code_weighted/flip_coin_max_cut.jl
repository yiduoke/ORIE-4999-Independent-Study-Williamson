import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using Statistics
include("helpers.jl")


"""
    flip_coin_max_cut(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the 2-approximation max cut value and its corresponding vertex 
set partition. The expected cut value is |E|/2.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array. 

This is a randomized algorithm and runs in time linear to the 
number of vertices.
"""
function flip_coin_max_cut(adj_lists)
    A = reduce(vcat,[rand(0:1)==0 ? [i] : [] for i in 1:length(adj_lists)]) # after randomly getting 0 or 1, 0 means the vertex goes into A
    cut_val = cut_value(adj_lists, A)

    return (cut_val, A)
end