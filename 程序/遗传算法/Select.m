function [newpop,newpopfit]=Select(pop,popfit,popsize)
% ������ѡ�����������������Ⱥ���Խ��к����
% ����ͱ���
sumfit=sum(popfit);
format long
prob=popfit/sumfit;
index=randsample(1:popsize,popsize,true,prob);
newpop=pop(index,:);
newpopfit=popfit(index);