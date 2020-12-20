using LinearAlgebra


"""
    num_vertices(adj_matrix)

returns the number of vertices in the graph `adj_matrix`
"""
function num_vertices(adj_matrix)
    return Int(sqrt(length(adj_matrix)))
end


"""
    adj_matrix_to_degree_matrix(adj_matrix)

given an adjacency matrix `adj_matrix`, return its corresponding
degree matrix
"""
function adj_matrix_to_degree_matrix(adj_matrix)
    n = num_vertices(adj_matrix)
    deg_matrix = zeros(n,n)
    [deg_matrix[i,i] = sum(adj_matrix[i, :]) for i ∈ 1:n]
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
    induced_subgraph(matrix)

returns the vertex-induced subgraph in adjacency matrix form of the
graph represented by `adj_matrix`.
The vertices by which to be induced are `V_prime`.
"""
function induced_subgraph(adj_matrix, V_prime)
    n = num_vertices(adj_matrix)
    induced_subgraph = zeros(n,n)
    [induced_subgraph[i,j] = adj_matrix[i,j] for i ∈ V_prime for j ∈ V_prime]
    return induced_subgraph
end

"""
    adj_list_cut_val(adj_matrix, vertex, A)

returns the total weight of the edges between `vertex` and each of its 
neighboring vertices from graph `adj_matrix` that aren't in the vertex 
subset `A`
"""
function adj_list_cut_val(adj_matrix, vertex, A)
    n = num_vertices(adj_matrix)
    relevant_row = adj_matrix[vertex, :]
    sum([relevant_row[i] for i ∈ filter(i -> relevant_row[i] != 0 && !(i in A), 1:n)])
end


"""
    cut_value(adj_matrix, A)

    returns the cut value of the cut from the graph `adj_matrix`
    where A is all vertices one side of the cut.
"""
function cut_value(adj_matrix, A)
    length(A)>0 ? sum([adj_list_cut_val(adj_matrix, vertex, A) for vertex in A]) : 0 # need the ternary operator because reduce doesn't work on empty lists
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