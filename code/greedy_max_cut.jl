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

This is a greedy algorithm and linear in the number
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

graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
graph_2 = Dict(1=>[2,5], 2=>[1,3,5], 3=>[2,4], 4=>[3,5], 5=>[1,2,4])
graph_3 = Dict(1=>[2,3], 2=>[1,4,5], 3=>[1,6,7], 4=>[2], 5=>[2], 6=>[3], 7=>[3])
graph_4 = Dict(1=>[6], 2=>[5], 3=>[0,5,6], 4=>[5,6,7], 5=>[0,2,3,4,7], 6=>[1,3,4], 7=>[4,5])
graph_5 = Dict(1=>[2,4], 2=>[1,3,5], 3=>[2,6], 4=>[1,5,7], 5=>[2,4,6,8], 6=>[3,5,9], 7=>[4,8], 8=>[5,7,9], 9=>[6,8])

test_case_1 = greedy_max_cut(graph_1)[1]
test_case_2 = greedy_max_cut(graph_2)[1]
test_case_3 = greedy_max_cut(graph_3)[1]
test_case_4 = greedy_max_cut(graph_4)[1]

println("test 1. greedy max cut: $(test_case_1) (should be ≥2)")
println("test 2. greedy max cut: $(test_case_2) (should be ≥3)")
println("test 3. greedy max cut: $(test_case_3) (should be ≥3)")
println("test 4. greedy max cut: $(test_case_4) (should be ≥5)")
println("test 5. greedy max cut: $(test_case_4) (should be ≥6)")