function newpop=Mutation(pop,pmutation)
% ��������ɱ������
[popsize,n]=size(pop);
newpop=pop;
for i=1:popsize
    if rand>pmutation
        continue;
    end
    %��һЩλ�ý��б���
    pos_num = randi(n);
    pos = randnorepeat(pos_num,n);
    newpop(i,pos) = ~pop(i,pos);
end