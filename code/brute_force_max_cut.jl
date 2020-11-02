import Pkg
Pkg.add("Combinatorics")
using Combinatorics

function brute_force_max_cut(adj_lists)
  n = length(adj_lists)
  all_possible_A = vcat([collect(combinations(1:n,i)) for i=1:n-1]...)
  current_max_partition = []
  current_max_cut = 0

  for A in all_possible_A
    running_B = []
    for vertex in A
      running_B = vcat(running_B, setdiff(adj_lists[vertex], A))
    end
    if length(running_B) > length(current_max_partition)
      current_max_partition = A
      current_max_cut = length(running_B)
    end
  end

  println("max cut: $current_max_partition")
  println("max cut value: $current_max_cut")
  return length(current_max_partition)
end

println(brute_force_max_cut(Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])))
