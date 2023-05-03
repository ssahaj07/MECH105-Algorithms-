function [L, U, P] = luFactor(A)
%
%   Inputs:
%       A - coefficient matrix
%
%   Outputs:
%       L - lower triangular matrix, with 1's along the diagonals
%       U - upper triangular matrix
%       P - the pivot matrix

[m, n] = size(A);
if m ~= n
    error('Input matrix must be square');
end


L = eye(n);
U = A;


P = eye(n);


for k = 1:n-1
    
    [~, pivot_row] = max(abs(U(k:n, k)));
    pivot_row = pivot_row + k - 1; 
    
    
    if pivot_row ~= k
        temp = U(k,:);
        U(k,:) = U(pivot_row,:);
        U(pivot_row,:) = temp;
        
    
        temp = P(k,:);
        P(k,:) = P(pivot_row,:);
        P(pivot_row,:) = temp;
        
        if k > 1
            
            temp = L(k, 1:k-1);
            L(k, 1:k-1) = L(pivot_row, 1:k-1);
            L(pivot_row, 1:k-1) = temp;
        end
    end
    

    if abs(U(k,k)) < eps
        error('Matrix is singular');
    end
    
  
    for i = k+1:n
        multiplier = U(i,k) / U(k,k);
        L(i,k) = multiplier;
        U(i,:) = U(i,:) - multiplier * U(k,:);
    end
end
end
