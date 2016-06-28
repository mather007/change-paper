function newpop=Cross(pop,pcross)
% 本函数完成交叉操作
[popsize,len]=size(pop);
for i=1:popsize
    index=randsample(1:popsize,2); % 随机选择两个染色体
    if rand>pcross,continue;end % 即在0-pcross范围进行交叉
    pos=randsample(1:len,2); % 随机选择交叉位置
    if pos(1)>pos(2)
        k=pos(1);
        pos(1)=pos(2);
        pos(2)=k;
        % 将pos中的两个数按从小到大顺序放
    end
    % 交叉开始
    x1=pop(index(1),:);
    x2=pop(index(2),:);
    
    x1(pos(1):pos(2)) = pop(index(2),pos(2):-1:pos(1));
    x2(pos(1):pos(2)) = pop(index(1),pos(2):-1:pos(1));
    
    pop(index(1),:)=x1;
    pop(index(2),:)=x2;
end
newpop=pop;