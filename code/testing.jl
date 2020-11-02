import Pkg
Pkg.add("Combinatorics")
using Combinatorics

function generate_random_adjacency_lists(n)
    possible_edges = collect(combinations(1:n,2))
    adj_lists = Dict(1:n .=> [[] for i in 1:n])
    for (u,v) in possible_edges
        if rand(0:1)==0
            adj_lists[u] = union(adj_lists[u], [v])
            adj_lists[v] = union(adj_lists[v], [u])
        end
    end

    return adj_lists
end

generate_random_adjacency_lists(5)