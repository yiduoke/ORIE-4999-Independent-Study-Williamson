import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using LinearAlgebra
include("helpers.jl")


"""
    two_thresholds_spectral_cut(adj_lists)

given a graph `adj_lists`, returns the vector specified in the
2TSC algorithm in theorem 1

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array.
"""
function two_thresholds_spectral_cut(adj_lists)
    D = adj_lists_to_degree_matrix(adj_lists)
    A = adj_lists_to_matrix(adj_lists)
    n = length(adj_lists)

    sqrt_D = zeros(n,n)
    [sqrt_D[i,i] = D[i,i]^(-1/2) for i ∈ 1:n]
    x = smallest_eigenvector(sqrt_D * A * sqrt_D)
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