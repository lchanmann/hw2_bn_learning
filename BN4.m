% Bayesian Networks No.4
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #2              ');
fprintf('                      Dataset No: %d\n', d);
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.4                ');
display('_______________________________________________________');
display(' ');

%% Load the data
Pd = dataset(:, 5);
Xa = dataset(:, 4);
Xb = dataset(:, 1);
Xh = dataset(:, 2);
Xt = dataset(:, 3);

%% Learn parameters of the CPDs
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xa = [sum(Xa == 1)/length(Xa); sum(Xa == 2)/length(Xa); sum(Xa == 3)/length(Xa)];
P_Xb_given_Pd_and_Xa = BN4.CPD(Xb, Pd, Xa);
P_Xh_given_Pd_and_Xa = BN4.CPD(Xh, Pd, Xa);
P_Xt_given_Pd_and_Xa = BN4.CPD(Xt, Pd, Xa);
%
display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Xa);
display(P_Xb_given_Pd_and_Xa);
display(P_Xh_given_Pd_and_Xa);
display(P_Xt_given_Pd_and_Xa);

%% Confusion matrix
evidence = [Xb Xh Xt Xa];
data_size = size(evidence, 1);
prediction = zeros(data_size, 1);

% prediction
model = BN4.model(P_Pd, P_Xa, P_Xb_given_Pd_and_Xa, P_Xh_given_Pd_and_Xa, P_Xt_given_Pd_and_Xa);
for i = 1:data_size
    prediction(i, 1) = model.predict(1, evidence(i, :));
end
% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));

display(' ');
display('--------------------- Confusion matrix ---------------------');
display(C);
display(accuracy);
display('Press Enter to continue ... ');
pause;