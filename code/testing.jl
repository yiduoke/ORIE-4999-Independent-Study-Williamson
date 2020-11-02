import Pkg
Pkg.add("Combinatorics")
using Combinatorics
include("brute_force_max_cut.jl")
include("flip_coin_max_cut.jl")
include("greedy_max_cut.jl")


"""
    generate_random_adjacency_lists(n)

returns a randomly generated graph with `n` vertices and the
number of edges in this graph.

The graph is in the form of adjacency lists
"""
function generate_random_adjacency_lists(n)
    possible_edges = collect(combinations(1:n,2))
    adj_lists = Dict(1:n .=> [[] for i in 1:n])
    num_edges = 0

    for (u,v) in possible_edges
        if rand(0:1)==0
            adj_lists[u] = union(adj_lists[u], [v])
            adj_lists[v] = union(adj_lists[v], [u])
            num_edges+= 1
        end
    end

    return (adj_lists, num_edges)
end


graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
graph_2 = Dict(1=>[2,5], 2=>[1,3,5], 3=>[2,4], 4=>[3,5], 5=>[1,2,4])
graph_3 = Dict(1=>[2,3], 2=>[1,4,5], 3=>[1,6,7], 4=>[2], 5=>[2], 6=>[3], 7=>[3])
graph_4 = Dict(1=>[6], 2=>[5], 3=>[0,5,6], 4=>[5,6,7], 5=>[0,2,3,4,7], 6=>[1,3,4], 7=>[4,5])
graph_5 = Dict(1=>[2,4], 2=>[1,3,5], 3=>[2,6], 4=>[1,5,7], 5=>[2,4,6,8], 6=>[3,5,9], 7=>[4,8], 8=>[5,7,9], 9=>[6,8])

brute_test_case_1 = brute_force_max_cut(graph_1)
brute_test_case_2 = brute_force_max_cut(graph_2)
brute_test_case_3 = brute_force_max_cut(graph_3)
brute_test_case_4 = brute_force_max_cut(graph_4)
brute_test_case_5 = brute_force_max_cut(graph_5)

coin_test_case_1 = mean([flip_coin_max_cut(graph_1)[1] for i in 1:100])
coin_test_case_2 = mean([flip_coin_max_cut(graph_2)[1] for i in 1:100])
coin_test_case_3 = mean([flip_coin_max_cut(graph_3)[1] for i in 1:100])
coin_test_case_4 = mean([flip_coin_max_cut(graph_4)[1] for i in 1:100])
coin_test_case_5 = mean([flip_coin_max_cut(graph_5)[1] for i in 1:100])

greedy_test_case_1 = greedy_max_cut(graph_1)[1]
greedy_test_case_2 = greedy_max_cut(graph_2)[1]
greedy_test_case_3 = greedy_max_cut(graph_3)[1]
greedy_test_case_4 = greedy_max_cut(graph_4)[1]
greedy_test_case_5 = greedy_max_cut(graph_5)[1]

println("brute force test 1. max cut: $(brute_test_case_1[1]) (should be 4). max cut partition: $(brute_test_case_1[2])")
println("brute force test 2. max cut: $(brute_test_case_2[1]) (should be 5). max cut partition: $(brute_test_case_2[2])")
println("brute force test 3. max cut: $(brute_test_case_3[1]) (should be 6). max cut partition: $(brute_test_case_3[2])")
println("brute force test 4. max cut: $(brute_test_case_4[1]) (should be 8). max cut partition: $(brute_test_case_4[2])")
println("brute force test 5. max cut: $(brute_test_case_5[1]) (should be 12). max cut partition: $(brute_test_case_5[2])")
println()

println("coin flip test 1. mean randomized max cut: $(coin_test_case_1) (should be ≈2)")
println("coin flip test 2. mean randomized max cut: $(coin_test_case_2) (should be ≈3)")
println("coin flip test 3. mean randomized max cut: $(coin_test_case_3) (should be ≈3)")
println("coin flip test 4. mean randomized max cut: $(coin_test_case_4) (should be ≈5)")
println("coin flip test 5. mean randomized max cut: $(coin_test_case_5) (should be ≈6)")
println()

println("greedy test 1. greedy max cut: $(greedy_test_case_1) (should be ≥2)")
println("greedy test 2. greedy max cut: $(greedy_test_case_2) (should be ≥3)")
println("greedy test 3. greedy max cut: $(greedy_test_case_3) (should be ≥3)")
println("greedy test 4. greedy max cut: $(greedy_test_case_4) (should be ≥5)")
println("greedy test 5. greedy max cut: $(greedy_test_case_5) (should be ≥6)")
println()