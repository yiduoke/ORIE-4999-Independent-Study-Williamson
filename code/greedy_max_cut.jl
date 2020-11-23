import Pkg
Pkg.add("Combinatorics")
using Combinatorics


"""
    greedy_max_cut(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the 2-approximation max cut value and its corresponding vertex 
set partition. The expected cut value is |E|/2.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array. 

This is a greedy algorithm and runs in time linear to the number
of vertices.
"""
function greedy_max_cut(adj_lists)
    A = []
    B = []
    for vertex in 1:length(adj_lists)
        num_B_neighbors = length(intersect(adj_lists[vertex], B))
        num_A_neighbors = length(intersect(adj_lists[vertex], A))

        num_A_neighbors > num_B_neighbors ? B = union(B, [vertex]) : A = union(A, [vertex])
    end
    cut_value = length(reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A]))

    return (cut_value, A)
end