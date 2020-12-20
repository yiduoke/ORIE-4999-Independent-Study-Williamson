import Pkg
Pkg.add("Combinatorics")
using Combinatorics
include("helpers.jl")

"""
  brute_force_max_cut(adj_matrix) 

returns, for a given graph in adjacency matrix form `adj_matrix`,
the max cut value and its corresponding vertex set partition.

The algorithm is brute force and thus runs in time exponential 
to the number of vertices.
"""
function brute_force_max_cut(adj_matrix)
  n = num_vertices(adj_matrix)
  all_possible_A = vcat([collect(combinations(1:n,i)) for i=1:n-1]...) # all non-empty proper subsets of V
  current_max_partition = [] # running partition (i.e. set A⊂V) with max cut value
  current_max_cut = 0 # running max cut value

  for A in all_possible_A # iterationg through each possible partition
    current_cut_value = cut_value(adj_matrix, A) # value of (A,V-A) cut

    if current_cut_value > current_max_cut # updating the values when we get a new max
      current_max_partition = A
      current_max_cut = current_cut_value
    end
  end

  return (current_max_cut, current_max_partition)
end
