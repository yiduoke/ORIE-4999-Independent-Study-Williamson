import Pkg
Pkg.add("Combinatorics")
Pkg.add("JuMP")
Pkg.add("ProxSDP")
Pkg.add("Distributions")
using Combinatorics
using JuMP, ProxSDP, LinearAlgebra, Distributions
include("helpers.jl")



"""
    SDP_max_cut(adj_matrix) 

returns, for a given graph in adjacency matrix form `adj_matrix`,
the 0.878-approximation max cut value and its corresponding vertex 
set partition. The expected cut value is 0.878*OPT, where OPT is 
the actual max cut.

This is a randomized approximation algorithm and runs in time 
polynomial to the number of vertices.
"""
function SDP_max_cut(adj_matrix)
    n = num_vertices(adj_matrix)
    model = Model(with_optimizer(ProxSDP.Optimizer))
    @variable(model, V[1:n, 1:n], PSD)
    @objective(model, Max, 0.25 * dot(adj_matrix, 1 .- V))
    @constraint(model, diag(V) .== 1)
    JuMP.optimize!(model)

    maximized_objective = 0.25 * dot(adj_matrix, 1 .- JuMP.value.(V))

    factorization = cholesky(nearest_pos_def(JuMP.value.(V)))

    r = rand(Normal(), n)
    r /= norm(r)
    
    Z = factorization.U
    A = filter(i -> dot(Z[1:n, i], r) < 0, 1:n)
    cut_val = cut_value(adj_matrix, A)
    return cut_val, A, maximized_objective
end