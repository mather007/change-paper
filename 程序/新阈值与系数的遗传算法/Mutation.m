function newpop=Mutation(pop,pmutation)
% 本函数完成变异操作
[popsize,n]=size(pop);
newpop=pop;
for i=1:popsize
    if rand>pmutation
        continue;
    end
    %找一些位置进行变异
    pos_num = randi(n);
    pos = randnorepeat(pos_num,n);
    newpop(i,pos) = ~pop(i,pos);
end