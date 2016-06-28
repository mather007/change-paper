close all;
clear;
clc;
% [x,FS,NBITS]=wavread('hello_6.wav');%读取波形文件获得数据
%  x=x(:,1)+x(:,2);
% s=awgn(x,25);%添加50db的高斯白噪声
load('hello6_0412_snr15.mat');
x=x;
s=awgn(x,15);%添加50db的高斯白噪声
%  load('s_hello6_0412_snr15.mat');
%  s=s;
% load noisbloc;
% s=noisbloc;
% [x]=wnoise(1,10);
% s=awgn(x,15);%添加15db的高斯白噪声

% load leleccum;
% s=leleccum;
%设分解层数为k,小波基为db
k=5;
db='db4';
%调用小波分解函数
%开始分解
[C,L]=wavedec(s,k,db);
%由L得到各层系数在C中的起始坐标和终止坐标
L_plus = [1,L']
pos_L1 = cumsum(L_plus);
pos_L2 = cumsum(L');
pos_L1 = pos_L1(1:k+1);%只有层数+1位置之前的是有用的
pos_L2 = pos_L2(1:k+1);%只有层数+1位置之前的是有用的

%求出各层阈值m
for i=1:k
    m(i)=a_normal_yuzhi(C(pos_L1(i+1):pos_L2(i+1)),i)%求得阈值
end
new_C=a_soft_func(C,m,k,pos_L1,pos_L2);%软阈值函数去噪
new_C_h=a_hard_func(C,m,k,pos_L1,pos_L2);%硬阈值函数去噪
new_C_new=a_new_func(C,m,k,pos_L1,pos_L2);%硬阈值函数去噪


%重构信号
new_s=waverec(new_C,L,db);%重构软阈值系数信号
new_s_h=waverec(new_C_h,L,db);%重构硬阈值系数信号
new_s_new=waverec(new_C_new,L,db);%重构新阈值系数信号
% fangcha=var(new_s-s)
%求信噪比和均方误差
[soft_u,soft_d]=a_snr(x,new_s)%软
[hard_u,hard_d]=a_snr(x,new_s_h)%硬
[new_u,new_d]=a_snr(x,new_s_new)%新

%画图

figure(1);
%画出原图像
subplot(3,2,1);
plot(x);
title('初始信号');
%画出加噪图像
subplot(3,2,2);
plot(s);
title('加噪信号');
%画出去噪后图像
subplot(3,2,3);
plot(new_s);
title('软阈值函数去噪后信号');
subplot(3,2,4);
plot(new_s_h);
title('硬阈值函数去噪后信号');
subplot(3,2,5);
plot(new_s_new);
title('新阈值函数去噪后信号');