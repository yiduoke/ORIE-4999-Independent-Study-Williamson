import Pkg
Pkg.add("Combinatorics")
using Combinatorics
include("helpers.jl")


"""
    greedy_max_cut(adj_matrix) 

returns, for a given graph in adjacency matrix form `adj_matrix`,
the 0.5-approximation max cut value and its corresponding vertex 
set partition.

This is a greedy algorithm and runs in time linear to the number
of vertices.
"""
function greedy_max_cut(adj_matrix)
    A = []
    B = []
    n = num_vertices(adj_matrix)
    for vertex in 1:num_vertices(adj_matrix)
        relevant_row = adj_matrix[vertex, :]
        A_neighbors_weight = sum([relevant_row[i] for i ∈ filter(i -> relevant_row[i] != 0 && i in A, 1:n)])
        B_neighbors_weight = sum([relevant_row[i] for i ∈ filter(i -> relevant_row[i] != 0 && i in B, 1:n)])

        A_neighbors_weight > B_neighbors_weight ? B = union(B, [vertex]) : A = union(A, [vertex])
    end
    cut_val = cut_value(adj_matrix, A)

    return (cut_val, A)
end