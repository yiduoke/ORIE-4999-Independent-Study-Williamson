include("brute_force_max_cut.jl")
include("flip_coin_max_cut.jl")
include("greedy_max_cut.jl")
include("SDP_max_cut.jl")
include("trevisan_max_cut.jl")


"""
    generate_random_adjacency_matrix(n,p)

returns a randomly generated graph with `n` vertices and the
number of edges in this graph. For every pair of vertices,
there's a `p` ∈ [0,1] probability there's an edge connecting them.
Edges that exist are randomly weighted; they're integers in the [1,30] range.
If p isn't given, then it's 0.5 (i.e. 50% chance)

The graph is in the form of an adjacency matrix.
"""
function generate_random_adjacency_matrix(n, p=0.5)
    possible_edges = collect(combinations(1:n,2))
    adj_matrix = zeros(n,n)

    for (u,v) in possible_edges
        if rand() < p
            weight = rand(1:30)
            adj_matrix[u,v] = weight
            adj_matrix[v,u] = weight
        end
    end

    return adj_matrix
end


graph_1 = [0 2 0 3; 2 0 4 0; 0 4 0 2; 3 0 2 0]
graph_2 = [0 2 0 0 8; 2 0 9 0 16; 0 9 0 26 0; 0 0 26 0 10; 8 16 0 10 0]
graph_3 = [0 18 28 0 0 0 0; 18 0 0 16 30 0 0; 28 0 0 0 0 17 2; 0 16 0 0 0 0 0; 0 30 0 0 0 0 0; 0 0 17 0 0 0 0; 0 0 2 0 0 0 0]
graph_4 = [0 0 0 0 0 207 0 0; 0 0 0 0 475 0 0 0; 0 0 0 0 112 75 0 3; 0 0 0 0 184 264 288 0; 0 475 112 184 0 0 9 12; 207 0 75 264 0 0 0 0; 0 0 0 288 9 0 0 0; 0 0 3 0 12 0 0 0]
graph_5 = [0 29 0 18 0 0 0 0 0; 29 0 11 0 10 0 0 0 0; 0 11 0 0 0 12 0 0 0; 18 0 0 0 13 0 14 0 0; 0 10 0 13 0 11 0 18 0; 0 0 12 0 11 0 0 0 19; 0 0 0 14 0 0 0 6 0; 0 0 0 0 18 0 6 0 27; 0 0 0 0 0 19 0 27 0]

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

println("brute force test 1. max cut: $(brute_test_case_1[1])")
println("brute force test 2. max cut: $(brute_test_case_2[1])")
println("brute force test 3. max cut: $(brute_test_case_3[1])")
println("brute force test 4. max cut: $(brute_test_case_4[1])")
println("brute force test 5. max cut: $(brute_test_case_5[1])")
println()

println("coin flip test 1. mean randomized max cut: $(coin_test_case_1) (should be ≈5.5)")
println("coin flip test 2. mean randomized max cut: $(coin_test_case_2) (should be ≈34.5)")
println("coin flip test 3. mean randomized max cut: $(coin_test_case_3) (should be ≈55.5)")
println("coin flip test 4. mean randomized max cut: $(coin_test_case_4) (should be ≈808.5)")
println("coin flip test 5. mean randomized max cut: $(coin_test_case_5) (should be ≈94.0)")
println()

println("greedy test 1. greedy max cut: $(greedy_test_case_1) (should be ≥5.5)")
println("greedy test 2. greedy max cut: $(greedy_test_case_2) (should be ≥34.5)")
println("greedy test 3. greedy max cut: $(greedy_test_case_3) (should be ≥55.5)")
println("greedy test 4. greedy max cut: $(greedy_test_case_4) (should be ≥808.5)")
println("greedy test 5. greedy max cut: $(greedy_test_case_5) (should be ≥94.0)")
println()

println("SDP test 1. SDP max cut: $(SDP_test_case_1) (should be ≈$(0.878*11)=0.878*11)")
println("SDP test 2. SDP max cut: $(SDP_test_case_2) (should be ≈$(0.878*69)=0.878*69)")
println("SDP test 3. SDP max cut: $(SDP_test_case_3) (should be ≈$(0.878*111)=0.878*111)")
println("SDP test 4. SDP max cut: $(SDP_test_case_4) (should be ≈$(0.878*1617)=0.878*1617)")
println("SDP test 5. SDP max cut: $(SDP_test_case_5) (should be ≈$(0.878*188)=0.878*188)")
println()

println("trevisan test 1. trevisan max cut: $(trevisan_test_case_1) (should be ≥$(0.531*11)=0.531*11)")
println("trevisan test 2. trevisan max cut: $(trevisan_test_case_2) (should be ≥$(0.531*69)=0.531*69)")
println("trevisan test 3. trevisan max cut: $(trevisan_test_case_3) (should be ≥$(0.531*111)=0.531*111)")
println("trevisan test 4. trevisan max cut: $(trevisan_test_case_4) (should be ≥$(0.531*1617)=0.531*1617)")
println("trevisan test 5. trevisan max cut: $(trevisan_test_case_5) (should be ≥$(0.531*188)=0.531*188)")
println()

for i ∈ 15:50
    for j ∈ 1:5
        generated_graph = generate_random_adjacency_matrix(i, rand())
        
        generated_coin_test_case = mean([flip_coin_max_cut(generated_graph)[1] for i in 1:100])
        generated_greedy_test_case = greedy_max_cut(generated_graph)[1]
        generated_SDP_test_case = mean([SDP_max_cut(generated_graph)[1] for i in 1:100])
        generated_trevisan_test_case = trevisan_max_cut(generated_graph)[1]

        OPT_upper_bound = SDP_max_cut(generated_graph)[3]
        half_OPT_bound = OPT_upper_bound/2
        SDP_approx_bound = 0.878 * OPT_upper_bound
        trevisan_approx_bound = 0.531 * OPT_upper_bound

        println("\nall results should be ≤$OPT_upper_bound")

        println("generated coin flip test. mean randomized max cut: $generated_coin_test_case (should be ≈$half_OPT_bound")
        println("generated greedy test. greedy max cut: $generated_greedy_test_case (should be ≥$half_OPT_bound)")
        println("generated SDP test. SDP max cut: $generated_SDP_test_case (should be ≈$SDP_approx_bound)")
        println("generated trevisan test. trevisan max cut: $generated_trevisan_test_case (should be ≈$trevisan_approx_bound)")
    end
end