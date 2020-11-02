import Pkg
Pkg.add("Combinatorics")
using Combinatorics
using Statistics

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

test_case_1 = greedy_max_cut(graph_1)[1]
test_case_2 = greedy_max_cut(graph_2)[1]
test_case_3 = greedy_max_cut(graph_3)[1]

println("test 1. greedy max cut: $(test_case_1) (should be ≥2)")
println("test 2. greedy max cut: $(test_case_2) (should be ≥3)")
println("test 3. greedy max cut: $(test_case_3) (should be ≥3)")