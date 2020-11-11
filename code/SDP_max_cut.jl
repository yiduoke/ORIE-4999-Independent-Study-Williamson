import Pkg
Pkg.add("Combinatorics")
Pkg.add("JuMP")
Pkg.add("ProxSDP")
Pkg.add("Distributions")
using Combinatorics
using JuMP, ProxSDP, LinearAlgebra, Distributions


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
    @objective(model, Max, 0.5 * dot(adj_matrix, 1 .- V))
    @constraint(model, diag(V) .== 1)
    JuMP.optimize!(model)

    factorization = cholesky(Hermitian(JuMP.value.(V)), Val(true), check = false)
    Y = (factorization.P * factorization.L)'

    r = rand(Normal(), n)
    
    A = filter(i -> dot(Y[1:n, i], r) < 0, 1:n)
    cut_value = length(reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A]))
    return cut_value, A
end

graph_1 = Dict(1=>[2,4], 2=>[1,3], 3=>[2,4], 4=>[1,3])
println(SDP_force_max_cut(graph_1))