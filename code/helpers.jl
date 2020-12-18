using LinearAlgebra

"""
    adj_lists_to_matrix(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the adjacency matrix.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array.
"""
function adj_lists_to_matrix(adj_lists)
    n = length(adj_lists)
    adj_matrix = zeros(n,n)
    [adj_matrix[i,j] = 1 for i ∈ 1:n for j ∈ adj_lists[i]]
    return adj_matrix
end

"""
    adj_lists_to_degree_matrix(adj_lists) 

returns, for a given graph in adjacency list form `adj_lists`,
the diagonal degree matrix. This matrix D has 0 everywhere except
the diagonal, where D(i,i)=degree of vertex i.

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array.
"""
function adj_lists_to_degree_matrix(adj_lists)
    n = length(adj_lists)
    deg_matrix = zeros(n,n)
    [deg_matrix[i,i] = length(adj_lists[i]) for i ∈ 1:n]
    return deg_matrix
end

"""
    smallest_eigenvector(matrix)

returns the eigenvector corresponding to the smallest eigenvalue
of `matrix` in the form of a nx1 array where n is the number of
columns of `matrix`
"""
function smallest_eigenvector(matrix)
    return eigen(matrix).vectors[:,1] # eigen(matrix) returns sorted results in ascending order of eigenvalue
end

"""
    induced_subgraph(adj_lists)

returns the vertex-induced subgraph in adjacency matrix form of the
graph represented by `adj_lists` 

`adj_lists` is a Dict with each vertex as a key, whose value 
is its neighboring vertices in the form of an Array.
"""
function induced_subgraph(adj_lists, V_prime)
    n = length(adj_lists)
    adj_matrix = adj_lists_to_matrix(adj_lists)
    induced_subgraph = zeros(n,n)
    [induced_subgraph[i,j] = adj_matrix[i,j] for i ∈ V_prime for j ∈ V_prime]
    return induced_subgraph
end

function cut_value(adj_lists, A)
    return length(A)>0 ? length(reduce(vcat, [setdiff(adj_lists[vertex], A) for vertex in A])) : 0 # need the ternary operator because reduce doesn't work on empty lists
end

"""
    nearest_pos_def(matrix)

given a `matrix` that's almost positive definite, return a 
near (not the nearest, but close) matrix that is positive definite.
It is done by adding a small multiple of the identity matrix.
"""
function nearest_pos_def(matrix)
    k = 1/1000000000000000000
    orig_matrix = matrix
    while minimum(eigen(matrix).values) < 0
        matrix = orig_matrix + I * k
        k *= 10
    end
    return matrix
    print(eigvals(matrix))
end