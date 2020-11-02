import Pkg
Pkg.add("Combinatorics")
using Combinatorics

"""
  brute_force_max_cut(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the max cut value and its corresponding vertex set partition.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array. 

The algorithm is brute force and thus exponential time in 
the number of vertices.
"""
function brute_force_max_cut(adj_lists)
  n = length(adj_lists)
  all_possible_A = vcat([collect(combinations(1:n,i)) for i=1:n-1]...) # all non-empty proper subsets of V
  current_max_partition = [] # running partition (i.e. set A⊂V) with max cut value
  current_max_cut = 0 # running max cut value

  for A in all_possible_A # iterationg through each possible partition
    current_cut_value = length(reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A])) # value of (A,V-A) cut

    if current_cut_value > current_max_cut # updating the values when we get a new max
      current_max_partition = A
      current_max_cut = current_cut_value
    end
  end

  return (current_max_cut, current_max_partition)
end

graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
graph_2 = Dict(1=>[2,5], 2=>[1,3,5], 3=>[2,4], 4=>[3,5], 5=>[1,2,4])
graph_3 = Dict(1=>[2,3], 2=>[1,4,5], 3=>[1,6,7], 4=>[2], 5=>[2], 6=>[3], 7=>[3])

test_case_1 = brute_force_max_cut(graph_1)
test_case_2 = brute_force_max_cut(graph_2)
test_case_3 = brute_force_max_cut(graph_3)

println("test 1. max cut: $(test_case_1[1]) (should be 4). max cut partition: $(test_case_1[2])")
println("test 2. max cut: $(test_case_2[1]) (should be 5). max cut partition: $(test_case_2[2])")
println("test 3. max cut: $(test_case_3[1]) (should be 6). max cut partition: $(test_case_3[2])")
