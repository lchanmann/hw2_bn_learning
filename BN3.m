% Bayesian Networks No.3...
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