% Bayesian Networks No.3
%%
display('_______________________________________________________');
display('                                                       ');
display('             Programming Assignment #2                 ');
display('               Bayesian Networks No.3                  ');
display('_______________________________________________________');
display(' ');
%% Get data and discretize...
    Pd = dataset1001(:, 5);
    Xb = dataset1001(:, 1);
    Xh = dataset1001(:, 2);
    Xt = dataset1001(:, 3);

%% Maximum likelihood estimation...
    P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
    % mle Maximum likelihood estimator
    P_Xb_given_Pd = mle(Xb, Pd);
    P_Xh_given_Pd = mle(Xh, Pd);
    P_Xt_given_Pd = mle(Xt, Pd);

%% Predict P(Pd|Xb, Xh, Xt)
    model = BN3.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);

% P(pd = 1|Xb = 9)
  display('Compute the P(pd = 1|Xb = 9) :'); 
  model.predict(1, [9 0 0])

% P(pd = 1|Xb = 9.3, Xh = 78.4, Xt = 36.3)
  display('Compute the P(pd = 1|Xb = 9.3, Xh = 78.4, Xt = 36.3) :'); 
  model.predict(1, [9.3 78.4 36.3])
%% Load the data
Pd = dataset(:, 5);
Xb = dataset(:, 1);
Xh = dataset(:, 2);
Xt = dataset(:, 3);

%% Learn parameters of the CPDs
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = mle(Xb, Pd);
P_Xh_given_Pd = mle(Xh, Pd);
P_Xt_given_Pd = mle(Xt, Pd);

display('--------------------- Parameters learned ---------------------');
display(P_Xb_given_Pd);
display(P_Xh_given_Pd);
display(P_Xt_given_Pd);

%% Confusion matrix
evidence = [Xb Xh Xt];
data_size = size(evidence, 1);
prediction = zeros(data_size, 1);

model = BN3.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);
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
