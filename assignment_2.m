%==========================================================================
% CS 8750 - Artificial Intelligence II...
% Programming Assignment #2 ...
% Adil Al-Azzawi ... ECE
% Chanmann Lim   ... CS
% Fernando Torre ... CS
%==========================================================================
%%
clc;clear;
t=0;
while (t ~= 1)
    clc;
    display('_______________________________________________________');
    display(' ');
    display('             Choose Your Data set                      ');
    display('_______________________________________________________');
    display('             1: For Data set 1001                      ');
    display('             2: For Data set 1004                      ');
    display('_______________________________________________________');
    display(' ');
    x = input(' Select the Baysian Network that you want to implement : ');
    if (x==1)||(x==2)
        dataset1001 = load('1001testingdata.csv');
        dataset1004 = load('1004testingdata.csv');
        t=1;
    else    
        msgbox('Invalid Data_set No...', 'Error','error');
        pause;
        t=0;
    end
end
%% using BN#1...
BN1

%% using BN#3...
BN3