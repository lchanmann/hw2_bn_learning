%
% CS8750 Spring 2015
% Artificial Intelligence II
% University of Missouri-Columbia
%
% Programming Assignment 2
%
clc; clear; close all;

dataset1001 = load('1001testingdata.csv');
dataset1004 = load('1004testingdata.csv');

%
% BN 1
%
Pd = dataset1001(:, 5);
Xb = discretize(dataset1001(:, 1));
Xh = discretize(dataset1001(:, 2));
Xt = discretize(dataset1001(:, 3));

P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = BN1_CPT(Xb, Pd);
P_Xh_given_Pd = BN1_CPT(Xh, Pd);
P_Xt_given_Pd = BN1_CPT(Xt, Pd);

