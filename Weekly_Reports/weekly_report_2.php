function Recursive-Spectral-Cut(V,E,δ){
  
  y = 2-Thresholds Spectral Cut with δ;
  
  M = number of weighted number of edges (i,j) such that at least one of y_i and y_j is not 0 (i.e. weighted number of edges in S⊆V);
  
  C = the weighted number of cut edges (i,j) such that y_i and y_j are both not 0 and have opposite signs (i.e. weighted number of edges such that one vertex is in L and the other in R);
  
  X = weighted number of cross edges (i,j) such that exactly one of y_i and y_j is 0 (i.e. weighted number of edges such that one vertex is in S and one vertex is not)
  
  if (C+X/2 <= M/2){
    use a greedy algorithm to find a partition of V that cuts at least |E|/2 edges, and return it
  }
  else {
    L = {i such that y_i == -1};
    R = {i such that y_i == +1};
    V_prime = {i such that y_i == 0};
    
    G_prime(V_prime, E_prime) = induced subgraph of V_prime;
    (V_1, V_2) = Recursive-Spectral-Cut(V_prime, E_prime, δ);
    
    return bigger_cut((V_1 ∪ L, V_2 ∪ R), (V_1 ∪ R, V_2 ∪ L));
  }
}
  
