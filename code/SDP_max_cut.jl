import Pkg
Pkg.add("Combinatorics")
Pkg.add("JuMP")
Pkg.add("Ipopt")
using Combinatorics
using JuMP, Ipopt

function unique_edges(adj_lists)
    n = length(adj_lists)
    possible_edges = collect(combinations(1:n,2))
    return filter(((u,v)=x) -> v in adj_lists[u], possible_edges)
end

function adj_lists_to_matrix(adj_lists)
    n = length(adj_lists)
    adj_matrix = zeros(n,n)
    # [adj_matrix[i,j] = 1 for i ∈ 1:n, j ∈ adj_lists[i]]
    [adj_matrix[i,j] = 1 for i ∈ 1:n for j ∈ adj_lists[i]]
    return adj_matrix
end

function SDP_force_max_cut(adj_lists)
    n = length(adj_lists)
    adj_matrix = adj_lists_to_matrix(adj_lists)
    model = Model(with_optimizer(Ipopt.Optimizer))
    @variable(model,  V[1:n, 1:n])
    [@constraint(model, V[1:n, i]'V[1:n, i] == 1) for i ∈ 1:n]
    @objective(model, Max, 0.5 * adj_matrix - V'V)
    JuMP.optimize!(model)

    return JuMP.value.(y)
end

graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
println(SDP_force_max_cut(graph_1))