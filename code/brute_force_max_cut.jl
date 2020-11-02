import Pkg
Pkg.add("Combinatorics")
using Combinatorics

function brute_force_max_cut(adj_lists)
  n = length(adj_lists)
  all_possible_A = vcat([collect(combinations(1:n,i)) for i=1:n-1]...) # all non-empty proper subsets of V
  current_max_partition = [] # running partition with max cut value
  current_max_cut = 0 # running max cut value

  for A in all_possible_A # iterationg through each possible partition
    running_B = reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A]) # cardinality of running_B is the value of (A,V-A) cut

    if length(running_B) > current_max_cut # updating the values when we get a new max
      current_max_partition = A
      current_max_cut = length(running_B)
    end
  end

  println("max cut: $current_max_partition")
  println("max cut value: $current_max_cut\n")
  return (current_max_cut, current_max_partition)
end

brute_force_max_cut(Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])) # max cut should be 4
brute_force_max_cut(Dict(1=>[2,5], 2=>[1,3,5], 3=>[2,4], 4=>[3,5], 5=>[1,2,4])) # max cut should be 5
brute_force_max_cut(Dict(1=>[2,3], 2=>[1,4,5], 3=>[1,6,7])) # this is a perfect binary tree. max cut should be 6
