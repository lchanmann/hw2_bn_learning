function [ cpt ] = CPT ( x , Pd )
% CPT - construct CPT for a random variable in BN 1
%   learn CPT parameters using Maximum Likelihood estimator
%
% Input:
%   x - discrete random variable. Domain = {H, M, L}
%   Pd - evidence variable 'drink'
%
% Output:
%   cpt - conditional probability table of the random variable given the
%         evidence drink.
%        eg.
%                Xb
%        Pd | H | M | L |
%         1 |   |   |   |
%         0 |   |   |   |
% Note:
%   The elements/rows of e must correspond to x's
%
    domain = ['H', 'M', 'L'];
    cpt = zeros(2, length(domain));
    
    Pd_is_1 = sum(Pd == 1);
    Pd_is_0 = sum(Pd == 0);
    
    for i = 1:length(domain)
        x_i = Pd(x == domain(i));
        cpt(1, i) = sum(x_i == 1) / Pd_is_1;
        cpt(2, i) = sum(x_i == 0) / Pd_is_0;
    end
end
