import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using LinearAlgebra
include("helpers.jl")


"""
    y_ik(x)

given a vector `x` of length n, and indices i and k, 

cases:
    x[i] < -abs(x[k]): return -1
    x[i] > abs(x[k]): return 1
    abs(x[i]) <= abs(x[k]): return 0

"""
function y_ik(x,i,k)
    if x[i] < -abs(x[k])
        -1
    elseif x[i] > abs(x[k])
        1
    elseif abs(x[i]) <= abs(x[k])
        0
    end
end

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

    neg_sqrt_D = zeros(n,n)
    [neg_sqrt_D[i,i] = D[i,i]^(-1/2) for i ∈ 1:n]
    x = smallest_eigenvector(neg_sqrt_D * A * neg_sqrt_D)

    Y = zeros(n,n)
    [Y[i,k] = y_ik(x,i,k) for i ∈ 1:n for k ∈ 1:n]

    ratios = zeros(n)
    ratios = [(sum(A[i,j] * abs(Y[i,k] + Y[j,k]) for i ∈ 1:n for j ∈ 1:n) / sum(D[i,i] * abs(Y[i,k]) for i ∈ 1:n)) for k ∈ 1:n]
    return Y[:, findmin(ratios)[2]]
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