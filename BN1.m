% Bayesian Networks No.1
%%
display('_______________________________________________________');
display('                                                       ');
display('             Programming Assignment #2                 ');
display('               Bayesian Networks No.1                  ');
display('_______________________________________________________');
display(' ');

%% Load the data and discretize
Pd = dataset(:, 5);
Xb = discretize(dataset(:, 1));
Xh = discretize(dataset(:, 2));
Xt = discretize(dataset(:, 3));

%% Learn parameters of the CPDs
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = BN1.CPT(Xb, Pd);
P_Xh_given_Pd = BN1.CPT(Xh, Pd);
P_Xt_given_Pd = BN1.CPT(Xt, Pd);

display('--------------------- Parameters learned ---------------------');
display(P_Xb_given_Pd);
display(P_Xh_given_Pd);
display(P_Xt_given_Pd);

%% Predict P(Pd|Xb, Xh, Xt)
model = BN1.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);

display('--------------------- Prediction ---------------------');
% P(pd = 1|Xb = M, Xh = M, Xt = M)
display([ 'P(pd = 1|Xb = M, Xh = M, Xt = M) = ' ...
    num2str(model.predict(1, ['M' 'M' 'M'])) ]);

% P(pd = 1) without any evidences
display([ 'P(pd = 1) without any evidences = ' ...
    num2str(model.predict(1, ['-' '-' '-'])) ]);

% P(pd = 1|Xh = M)
display([ 'P(pd = 1|Xh = M) = ' ...
    num2str(model.predict(1, ['-' 'M' '-'])) ]);

%% Confusion matrix
evidence = [Xb Xh Xt];
data_size = size(evidence, 1);
prediction = zeros(data_size, 1);

for i = 1:data_size
    prediction(i, 1) = model.predict(1, evidence(i, :));
end
% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd, predicted_Pd);

display(' ');
display('--------------------- Confusion matrix ---------------------');
display(C);

%%
pause;