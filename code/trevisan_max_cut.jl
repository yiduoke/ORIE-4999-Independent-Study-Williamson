import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using LinearAlgebra
include("helpers.jl")


function get_x(adj_lists)

end

"""
    trevisan_max_cut(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the 0.531-approximation max cut value and its corresponding vertex 
set partition.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array.
"""
function trevisan_max_cut(adj_lists)
    

    return (cut_value, A)
end