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
    
    m = [mean(x_given_Pd_is_1) mean(x_given_Pd_is_0)]';
    v = [var(x_given_Pd_is_1, 1) var(x_given_Pd_is_0, 1)]';
    params = [m v];
end

