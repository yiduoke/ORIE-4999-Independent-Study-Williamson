using LinearAlgebra


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
    induced_subgraph(matrix)

returns the vertex-induced subgraph in adjacency matrix form of the
graph represented by `adj_matrix`.
The vertices by which to be induced are `V_prime`.
"""
function induced_subgraph(adj_matrix, V_prime)
    n = length(adj_lists)
    induced_subgraph = zeros(n,n)
    [induced_subgraph[i,j] = adj_matrix[i,j] for i ∈ V_prime for j ∈ V_prime]
    return induced_subgraph
end

"""
    adj_list(adj_matrix, vertex)

returns the list of neighboring nodes of `vertex` in the graph
`adj_matrix`
"""
function adj_list(adj_matrix, vertex)
    relevant_row = adj_matrix[vertex, :]
    return filter(x -> x != 0, relevant_row)
end


"""
    cut_value(adj_matrix, A)

    returns the cut value of the cut from the graph `adj_matrix`
    where A is all vertices one side of the cut.
"""
function cut_value(adj_matrix, A)
    return length(A)>0 ? sum([sum(setdiff(adj_list(adj_matrix, vertex), A)) for vertex in A]) : 0 # need the ternary operator because reduce doesn't work on empty lists
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
    while !isposdef(matrix)
        matrix = orig_matrix + I * k
        k *= 10
    end
    return matrix
    print(eigvals(matrix))
end