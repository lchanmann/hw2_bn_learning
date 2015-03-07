% Bayesian Networks No.1
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('             Programming Assignment #2                 ');
display('               Bayesian Networks No.1                  ');
display('_______________________________________________________');
display(' ');
%% Load the data set...
Pd = dataset1001(:, 5);
%% Get the discretize
if (x==1)
   Xb = discretize(dataset1001(:, 1));
   Xh = discretize(dataset1001(:, 2));
   Xt = discretize(dataset1001(:, 3));
elseif (x==2)   
   Xb = discretize(dataset1004(:, 1));
   Xh = discretize(dataset1004(:, 2));
   Xt = discretize(dataset1004(:, 3));
end
%% Generate probabilities
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = BN1.CPT(Xb, Pd);
P_Xh_given_Pd = BN1.CPT(Xh, Pd);
P_Xt_given_Pd = BN1.CPT(Xt, Pd);

%% Predict P(Pd|Xb, Xh, Xt)...
   model = BN1.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);

%% P(pd = 1|Xb = M, Xh = M, Xt = M)...
  display('Compute the P(pd = 1|Xb = M, Xh = M, Xt = M) :');
  model.predict(1, ['M' 'M' 'M'])

%% P(pd = 1) without any evidences
  display('Compute the P(pd = 1) without any evidences : ');
  model.predict(1, ['-' '-' '-'])

%% P(pd = 1|Xh = M)
  display('Compute the P(pd = 1|Xh = M) : ');
  model.predict(1, ['-' 'M' '-'])
  display('Press Enter to continue ... ');
  pause;