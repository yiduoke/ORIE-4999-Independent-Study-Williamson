import Pkg
Pkg.add("Combinatorics")
Pkg.add("JuMP")
Pkg.add("ProxSDP")
using Combinatorics
using JuMP, ProxSDP, LinearAlgebra

function unique_edges(adj_lists)
    n = length(adj_lists)
    possible_edges = collect(combinations(1:n,2))
    return filter(((u,v)=x) -> v in adj_lists[u], possible_edges)
end

function adj_lists_to_matrix(adj_lists)
    n = length(adj_lists)
    adj_matrix = zeros(n,n)
    [adj_matrix[i,j] = 1 for i ∈ 1:n for j ∈ adj_lists[i]]
    return adj_matrix
end

function SDP_force_max_cut(adj_lists)
    n = length(adj_lists)
    adj_matrix = adj_lists_to_matrix(adj_lists)
    model = Model(with_optimizer(ProxSDP.Optimizer))
    @variable(model,  V[1:n, 1:n], PSD)
    @objective(model, Max, 0.5 * dot(adj_matrix, V))
    @constraint(model, diag(V) .== 1)
    JuMP.optimize!(model)

    println(JuMP.value.(V))
    return JuMP.value.(V)
end

graph_1 = Dict(1=>[2,3], 2=>[1,3], 3=>[1,2])
println(size(SDP_force_max_cut(graph_1)))