% Bayesian Networks No.2
%%
display('_______________________________________________________');
display('                                                       ');
display('             Programming Assignment #2                 ');
display('               Bayesian Networks No.2                  ');
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
P_Xb_given_Pd_and_Xa = BN2.CPT(Xb, Pd, Xa);
P_Xh_given_Pd_and_Xa = BN2.CPT(Xh, Pd, Xa);
P_Xt_given_Pd_and_Xa = BN2.CPT(Xt, Pd, Xa);

display('--------------------- Parameters learned ---------------------');
display(P_Xb_given_Pd_and_Xa);
display(P_Xh_given_Pd_and_Xa);
display(P_Xt_given_Pd_and_Xa);

%%
pause;