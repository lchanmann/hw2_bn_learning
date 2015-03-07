function [ cpd ] = CPD ( x , Pd, Xa )
% BN4.CPT - construct CPT for a random variable in BN 4
%   learn CPT parameters using Maximum Likelihood estimator
%
% Input:
%   x - discrete random variable. Domain = {H, M, L}
%   Pd - evidence variable 'drink'. Domain = {1 0}
%   Xa - evidence variable 'Ambulation status'. Domain = {1 2 3}
%
% Output:
%   cpd - conditional probability distribution of the random variable given the
%         evidence drink and ambulation status.
%        eg.
%           
%                           Xb
%           |Stationary |   Slow    |   Fast    |
%        Pd -------------------------------------
%         1 | m1 | var1 | .. |  ..  | .. |  ..  |
%         0 | m2 | var2 | .. |  ..  | .. |  ..  |
% Note:
%   The elements/rows of evidences must correspond to x's
%
    xa_domain = [1 2 3];
    xa_domain_size = length(xa_domain);
    cpd = zeros(2, 2 * xa_domain_size);
    
    for k = 1:xa_domain_size
        xa_is_k = Xa == k;
        col = [1 2] + (k - 1) * 2;
        cpd(:, col) = mle( x(xa_is_k), Pd(xa_is_k) );
    end
end
