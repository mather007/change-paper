function newpop=Cross(pop,pcross)
% ��������ɽ������
[popsize,len]=size(pop);
for i=1:popsize
    index=randsample(1:popsize,2); % ���ѡ������Ⱦɫ��
    if rand>pcross,continue;end % ����0-pcross��Χ���н���
    pos=randsample(1:len,2); % ���ѡ�񽻲�λ��
    if pos(1)>pos(2)
        k=pos(1);
        pos(1)=pos(2);
        pos(2)=k;
        % ��pos�е�����������С����˳���
    end
    % ���濪ʼ
    x1=pop(index(1),:);
    x2=pop(index(2),:);
    
    x1(pos(1):pos(2)) = pop(index(2),pos(2):-1:pos(1));
    x2(pos(1):pos(2)) = pop(index(1),pos(2):-1:pos(1));
    
    pop(index(1),:)=x1;
    pop(index(2),:)=x2;
end
newpop=pop;