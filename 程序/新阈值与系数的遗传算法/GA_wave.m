function [best_thr,best_fit,new_sig]=GA_wave(s,xi,level_num,db,maxgen,popsize,pcross,pmutation)
%-------------------------------------------------------------------------
%   使用遗传算法求解最佳阈值
%-------------------------------------------------------------------------
% maxgen=100; %进化代数
% popsize=50; %种群规模
% pcross=0.6; %交叉概率
% pmutation=0.2; %变异概率
% level_num 分解层数
% db小波基
%先对信号进行分解
N = length(xi);%采样点的个数
[C,L] = wavedec(xi,level_num,db);
%由L得到各层系数在C中的起始坐标和终止坐标
[lx,ly] = size(L);
if(lx>ly)
    L_plus = [1,L'];
    pos_L2 = cumsum(L');
else
    L_plus = [1,L];
    pos_L2 = cumsum(L);
end

pos_L1 = cumsum(L_plus);
pos_L1 = pos_L1(1:level_num+1);%只有层数+1位置之前的是有用的
pos_L2 = pos_L2(1:level_num+1);%只有层数+1位置之前的是有用的
c_max_min = zeros(level_num,2);
for i = 1:level_num%取出每层的高频部分的绝对值最大值和最小值
    %倒着取出坐标
    c_max_min(i,1) = max(abs(C(pos_L1(end-i+1):pos_L2(end-i+1))));
    c_max_min(i,2) = min(abs(C(pos_L1(end-i+1):pos_L2(end-i+1))));
end
c_max_min=[c_max_min;1,0.001];%这里要加上1，0是指系数的最大值与最小值

every_thr_len = wave_decode(c_max_min);%求出每层阈值，与系数的编码的个数
n = sum(every_thr_len);%每条染色体的总长度

 fitfun=@(x)1/((sum(s-x)/N).^2);%噪声的平均值趋于0
% fitfun=@(x)1/(sqrt((1/N)*(sum((x_original-x).^2)))); %适应度函数 即：MSE的倒数
%  fitfun=@(x)10*log((sum((x).^2))/(sum((xi-x).^2)))     ; %适应度函数 即：MSE的倒数
% 初始化种群
pop=round(rand(popsize,n));
popfit=zeros(popsize,1);

xx = zeros(popsize,N);%
real_yuzhi = wave_encode(c_max_min,every_thr_len,pop);%返回各个染色体实际对应阈值
for i=1:popsize
    thr1=real_yuzhi(i,:);%拿出每一组实际阈值
    %拿实际阈值中的每一组实际的阈值软处理高频部分的系数
    [new_C]=new_func_3(C,pos_L1,pos_L2,thr1);
%     length_new_C=size(new_C)
    %重构信号
    new_x = waverec(new_C,L,db);
%     length_new_x=size(new_x)
    %将重构好的信号代入适应度函数求适应度
    popfit(i) = fitfun(new_x);
    
    %记录新重构的信号
    xx(i,:) = new_x;
end

%找最好的染色体

[bestfit,index]=max(popfit);
bestchrom=pop(index,:);
% 进化开始
for i=1:maxgen
    % 选择操作、交叉操作、变异操作（调用函数）
    [pop,popfit]=Select(pop,popfit,popsize);%选择
    pop=Cross(pop,pcross);%交叉
    pop=Mutation(pop,pmutation);%变异
    %重新计算适应度，更新最大适应度和最好染色体
    real_yuzhi = wave_encode(c_max_min,every_thr_len,pop);%返回各个染色体实际对应阈值
    for j=1:popsize
        thr1=real_yuzhi(j,:);%拿出每一组实际阈值
        %拿实际阈值中的每一组实际的阈值软处理高频部分的系数
        [new_C]=new_func_3(C,pos_L1,pos_L2,thr1);
        %重构信号
        new_x = waverec(new_C,L,db);
        %将重构好的信号代入适应度函数求适应度
        popfit(j) = fitfun(new_x);
        
        %记录新重构的信号
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
% 窗口显示结果
new_sig = xx(index,:);
disp(['最佳染色体：',num2str(bestchrom)])
disp(['最佳阈值是：',num2str(best_thr)])
disp(['最佳MSE的值是：',num2str(1/bestfit)])
disp(['重构后的信号：',num2str(xx(index,:))])