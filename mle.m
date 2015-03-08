function [ params ] = mle( x, Pd )
% MLE - Maximum likelihood estimator
%   Learn parameters (mean and variance) for a 1-D Gaussian dataset
%
% Input:
%   x - 1-D Gaussian data sample of the random variable
%   Pd - evidence variable 'drink'
%
% Output:
%   params - parameters of the distritution over x|pd
%            eg.
%                    Params
%            Pd | Mean | Variance |
%             1 |      |          |
%             0 |      |          |
%
    x_given_Pd_is_1 = x(Pd == 1);
    x_given_Pd_is_0 = x(Pd == 0);
    
    % empirical mean and variance of x
    %   mean = sum(x) / length(x);
    %   var = sum((x - mean) .^ 2) / length(x)
    params = [
        mean(x_given_Pd_is_1) var(x_given_Pd_is_1, 1)
        mean(x_given_Pd_is_0) var(x_given_Pd_is_0, 1)
    ];
    % normalize lack of data samples
    params(isnan(params)) = 0;
end

