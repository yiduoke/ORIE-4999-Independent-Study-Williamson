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
    return eigvecs(A, [eigmin(matrix)])
end