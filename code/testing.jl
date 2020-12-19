include("brute_force_max_cut.jl")
include("flip_coin_max_cut.jl")
include("greedy_max_cut.jl")
include("SDP_max_cut.jl")
include("trevisan_max_cut.jl")


"""
    generate_random_adjacency_lists(n,p)

returns a randomly generated graph with `n` vertices and the
number of edges in this graph. For every pair of vertices,
there's a `p` ∈ [0,1] probability there's an edge connecting them.
If p isn't given, then it's 0.5 (i.e. 50% chance)

The graph is in the form of adjacency lists
"""
function generate_random_adjacency_lists(n, p=0.5)
    possible_edges = collect(combinations(1:n,2))
    adj_lists = Dict([i => [] for i in 1:n])
    num_edges = 0

    for (u,v) in possible_edges
        if rand() < p
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
graph_4 = Dict(1=>[6], 2=>[5], 3=>[5,6,8], 4=>[5,6,7], 5=>[2,3,4,7,8], 6=>[1,3,4], 7=>[4,5], 8=>[3,5])
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

SDP_test_case_1 = mean([SDP_max_cut(graph_1)[1] for i in 1:100])
SDP_test_case_2 = mean([SDP_max_cut(graph_2)[1] for i in 1:100])
SDP_test_case_3 = mean([SDP_max_cut(graph_3)[1] for i in 1:100])
SDP_test_case_4 = mean([SDP_max_cut(graph_4)[1] for i in 1:100])
SDP_test_case_5 = mean([SDP_max_cut(graph_5)[1] for i in 1:100])

trevisan_test_case_1 = mean([trevisan_max_cut(graph_1)[1] for i in 1:100])
trevisan_test_case_2 = mean([trevisan_max_cut(graph_2)[1] for i in 1:100])
trevisan_test_case_3 = mean([trevisan_max_cut(graph_3)[1] for i in 1:100])
trevisan_test_case_4 = mean([trevisan_max_cut(graph_4)[1] for i in 1:100])
trevisan_test_case_5 = mean([trevisan_max_cut(graph_5)[1] for i in 1:100])

println("brute force test 1. max cut: $(brute_test_case_1[1]) (should be =4). max cut partition: $(brute_test_case_1[2])")
println("brute force test 2. max cut: $(brute_test_case_2[1]) (should be =5). max cut partition: $(brute_test_case_2[2])")
println("brute force test 3. max cut: $(brute_test_case_3[1]) (should be =6). max cut partition: $(brute_test_case_3[2])")
println("brute force test 4. max cut: $(brute_test_case_4[1]) (should be =8). max cut partition: $(brute_test_case_4[2])")
println("brute force test 5. max cut: $(brute_test_case_5[1]) (should be =12). max cut partition: $(brute_test_case_5[2])")
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

println("SDP test 1. SDP max cut: $(SDP_test_case_1) (should be ≈$(0.878*4)=0.878*4)")
println("SDP test 2. SDP max cut: $(SDP_test_case_2) (should be ≈$(0.878*5)=0.878*5)")
println("SDP test 3. SDP max cut: $(SDP_test_case_3) (should be ≈$(0.878*6)=0.878*6)")
println("SDP test 4. SDP max cut: $(SDP_test_case_4) (should be ≈$(0.878*8)=0.878*8)")
println("SDP test 5. SDP max cut: $(SDP_test_case_5) (should be ≈$(0.878*12)=0.878*12)")
println()

println("trevisan test 1. trevisan max cut: $(trevisan_test_case_1) (should be ≥$(0.531*4)=0.531*4)")
println("trevisan test 2. trevisan max cut: $(trevisan_test_case_2) (should be ≥$(0.531*5)=0.531*5)")
println("trevisan test 3. trevisan max cut: $(trevisan_test_case_3) (should be ≥$(0.531*6)=0.531*6)")
println("trevisan test 4. trevisan max cut: $(trevisan_test_case_4) (should be ≥$(0.531*8)=0.531*8)")
println("trevisan test 5. trevisan max cut: $(trevisan_test_case_5) (should be ≥$(0.531*12)=0.531*12)")
println()

for i ∈ 15:50
    for j ∈ 1:5
        generated_graph, num_edges = generate_random_adjacency_lists(i, rand()/2)
        
        generated_coin_test_case = mean([flip_coin_max_cut(generated_graph)[1] for i in 1:100])
        generated_greedy_test_case = greedy_max_cut(generated_graph)[1]
        generated_SDP_test_case = mean([SDP_max_cut(generated_graph)[1] for i in 1:100])
        generated_trevisan_test_case = trevisan_max_cut(generated_graph)[1]

        OPT_upper_bound = SDP_max_cut(generated_graph)[3]
        half_edges = div(num_edges,2)
        SDP_approx_bound = 0.878 * OPT_upper_bound
        trevisan_approx_bound = 0.531 * OPT_upper_bound

        println("\nall results should be ≤$OPT_upper_bound")

        println("generated coin flip test. mean randomized max cut: $generated_coin_test_case (should be ≈$half_edges")
        println("generated greedy test. greedy max cut: $generated_greedy_test_case (should be ≥$half_edges)")
        println("generated SDP test. SDP max cut: $generated_SDP_test_case (should be ≈$SDP_approx_bound)")
        println("generated trevisan test. trevisan max cut: $generated_trevisan_test_case (should be ≈$trevisan_approx_bound)")
    end
end