%
% Get data and discretize
%
Pd = dataset1001(:, 5);
Xb = discretize(dataset1001(:, 1));
Xh = discretize(dataset1001(:, 2));
Xt = discretize(dataset1001(:, 3));

%
% Generate probabilities
%
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = BN1.CPT(Xb, Pd);
P_Xh_given_Pd = BN1.CPT(Xh, Pd);
P_Xt_given_Pd = BN1.CPT(Xt, Pd);

%
% Predict P(Pd|Xb, Xh, Xt)
%
model = BN1.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);

% P(pd = 1|Xb = M, Xh = M, Xt = M)
model.predict(1, ['M' 'M' 'M'])

% P(pd = 1) without any evidences
model.predict(1, ['-' '-' '-'])

% P(pd = 1|Xh = M)
model.predict(1, ['-' 'M' '-'])
