function [best_thr,best_fit,new_sig]=GA_wave(s,xi,level_num,db,maxgen,popsize,pcross,pmutation)
%-------------------------------------------------------------------------
%   ʹ���Ŵ��㷨��������ֵ
%-------------------------------------------------------------------------
% maxgen=100; %��������
% popsize=50; %��Ⱥ��ģ
% pcross=0.6; %�������
% pmutation=0.2; %�������
% level_num �ֽ����
% dbС����
%�ȶ��źŽ��зֽ�
N = length(xi);%������ĸ���
[C,L] = wavedec(xi,level_num,db);
%��L�õ�����ϵ����C�е���ʼ�������ֹ����
[lx,ly] = size(L);
if(lx>ly)
    L_plus = [1,L'];
    pos_L2 = cumsum(L');
else
    L_plus = [1,L];
    pos_L2 = cumsum(L);
end

pos_L1 = cumsum(L_plus);
pos_L1 = pos_L1(1:level_num+1);%ֻ�в���+1λ��֮ǰ�������õ�
pos_L2 = pos_L2(1:level_num+1);%ֻ�в���+1λ��֮ǰ�������õ�
c_max_min = zeros(level_num,2);
for i = 1:level_num%ȡ��ÿ��ĸ�Ƶ���ֵľ���ֵ���ֵ����Сֵ
    %����ȡ������
    c_max_min(i,1) = max(abs(C(pos_L1(end-i+1):pos_L2(end-i+1))));
    c_max_min(i,2) = min(abs(C(pos_L1(end-i+1):pos_L2(end-i+1))));
end
c_max_min=[c_max_min;1,0.001];%����Ҫ����1��0��ָϵ�������ֵ����Сֵ

every_thr_len = wave_decode(c_max_min);%���ÿ����ֵ����ϵ���ı���ĸ���
n = sum(every_thr_len);%ÿ��Ⱦɫ����ܳ���

 fitfun=@(x)1/((sum(s-x)/N).^2);%������ƽ��ֵ����0
% fitfun=@(x)1/(sqrt((1/N)*(sum((x_original-x).^2)))); %��Ӧ�Ⱥ��� ����MSE�ĵ���
%  fitfun=@(x)10*log((sum((x).^2))/(sum((xi-x).^2)))     ; %��Ӧ�Ⱥ��� ����MSE�ĵ���
% ��ʼ����Ⱥ
pop=round(rand(popsize,n));
popfit=zeros(popsize,1);

xx = zeros(popsize,N);%
real_yuzhi = wave_encode(c_max_min,every_thr_len,pop);%���ظ���Ⱦɫ��ʵ�ʶ�Ӧ��ֵ
for i=1:popsize
    thr1=real_yuzhi(i,:);%�ó�ÿһ��ʵ����ֵ
    %��ʵ����ֵ�е�ÿһ��ʵ�ʵ���ֵ�����Ƶ���ֵ�ϵ��
    [new_C]=new_func_3(C,pos_L1,pos_L2,thr1);
%     length_new_C=size(new_C)
    %�ع��ź�
    new_x = waverec(new_C,L,db);
%     length_new_x=size(new_x)
    %���ع��õ��źŴ�����Ӧ�Ⱥ�������Ӧ��
    popfit(i) = fitfun(new_x);
    
    %��¼���ع����ź�
    xx(i,:) = new_x;
end

%����õ�Ⱦɫ��

[bestfit,index]=max(popfit);
bestchrom=pop(index,:);
% ������ʼ
for i=1:maxgen
    % ѡ����������������������������ú�����
    [pop,popfit]=Select(pop,popfit,popsize);%ѡ��
    pop=Cross(pop,pcross);%����
    pop=Mutation(pop,pmutation);%����
    %���¼�����Ӧ�ȣ����������Ӧ�Ⱥ����Ⱦɫ��
    real_yuzhi = wave_encode(c_max_min,every_thr_len,pop);%���ظ���Ⱦɫ��ʵ�ʶ�Ӧ��ֵ
    for j=1:popsize
        thr1=real_yuzhi(j,:);%�ó�ÿһ��ʵ����ֵ
        %��ʵ����ֵ�е�ÿһ��ʵ�ʵ���ֵ�����Ƶ���ֵ�ϵ��
        [new_C]=new_func_3(C,pos_L1,pos_L2,thr1);
        %�ع��ź�
        new_x = waverec(new_C,L,db);
        %���ع��õ��źŴ�����Ӧ�Ⱥ�������Ӧ��
        popfit(j) = fitfun(new_x);
        
        %��¼���ع����ź�
        xx(j,:) = new_x;
    end
    p=bestfit;
    q=max(popfit);
    if q>p
        [bestfit,index]=max(popfit);
        bestchrom=pop(index,:);
    end
end
best_thr = wave_encode(c_max_min,every_thr_len,bestchrom);
best_fit = 1/bestfit;
% ������ʾ���
new_sig = xx(index,:);
disp(['���Ⱦɫ�壺',num2str(bestchrom)])
disp(['�����ֵ�ǣ�',num2str(best_thr)])
disp(['���MSE��ֵ�ǣ�',num2str(1/bestfit)])
disp(['�ع�����źţ�',num2str(xx(index,:))])