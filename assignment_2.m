%==========================================================================
% CS 8750 - Artificial Intelligence II...
% Programming Assignment #2 ...
% Adil Al-Azzawi ... ECE
% Chanmann Lim   ... CS
% Fernando Torre ... CS
%==========================================================================
%%
clc; clear;
datasets = ['1001testingdata.csv'; '1004testingdata.csv'];
% loop: while (true)
t=0;t1=0;
while (t ~= 1)
    while 1
        clc;
        display('_______________________________________________________');
        display(' ');
        display('             Choose Your Dataset                      ');
        display('_______________________________________________________');
        display('             1: For Dataset 1001                      ');
        display('             2: For Dataset 1004                      ');
        display('_______________________________________________________');
        display(' ');
        d = input(' Select the Dataset that you want to use : ');
        if (d == 1) || (d == 2)
            dataset = load(datasets(d, :));
            break;
        else    
            msgbox('Invalid Dataset No...', 'Error','error');
        end
    end
    %% using BN#1...
    BN1

    %% using BN#2
    BN2

    %% using BN#3...
    BN3

    %% using BN#4...
    BN4
  clc;
      while (t1 ~= 1)
          clc;
             display('_______________________________________________________');
             display('                                                       ');
             display('                Programming Assignment #2              ');
             display('_______________________________________________________');
             display(' ');
             I= input(' Do you want to use another Dataset [Y/N] : ','s');
             if  strcmp(I,'Y') || strcmp(I,'y')
                 t=0;t1=1;
             elseif  strcmp(I,'N') || strcmp(I,'n')    
                 t=1;t1=1;
             else
                 msgbox('Invalid Dataset No...', 'Error','error');
                 t=0;t1=0;
             end
      end
end