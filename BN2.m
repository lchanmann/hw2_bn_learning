% Bayesian Networks No.2
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #2              ');
fprintf('                      Dataset No: %d\n', d);
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.2                ');
display('_______________________________________________________');
display(' ');

%% Load the data and discretize
Pd = dataset(:, 5);
Xa = dataset(:, 4);
Xb = discretize(dataset(:, 1));
Xh = discretize(dataset(:, 2));
Xt = discretize(dataset(:, 3));

%% Learn parameters of the CPDs
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xa = [sum(Xa == 1)/length(Xa); sum(Xa == 2)/length(Xa); sum(Xa == 3)/length(Xa)];
P_Xb_given_Pd_and_Xa = BN2.CPT(Xb, Pd, Xa);
P_Xh_given_Pd_and_Xa = BN2.CPT(Xh, Pd, Xa);
P_Xt_given_Pd_and_Xa = BN2.CPT(Xt, Pd, Xa);

display('--------------------- Parameters learned ---------------------');
display(P_Xb_given_Pd_and_Xa);
display(P_Xh_given_Pd_and_Xa);
display(P_Xt_given_Pd_and_Xa);

%% Confusion matrix
evidence = [Xb Xh Xt Xa];
data_size = size(evidence, 1);
prediction = zeros(data_size, 1);

% prediction
model = BN2.model(P_Pd, P_Xa, P_Xb_given_Pd_and_Xa, P_Xh_given_Pd_and_Xa, P_Xt_given_Pd_and_Xa);
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
display('Press Enter to continue ... ');
pause;