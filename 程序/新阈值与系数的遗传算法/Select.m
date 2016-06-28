function [newpop,newpopfit]=Select(pop,popfit,popsize)
% 本函数选择优良个体组成新种群，以进行后面的
% 交叉和变异
sumfit=sum(popfit);
format long
prob=popfit/sumfit;
index=randsample(1:popsize,popsize,true,prob);
newpop=pop(index,:);
newpopfit=popfit(index);