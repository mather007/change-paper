close all;
clear;
clc;
 [x,FS,NBITS]=wavread('die2love.wav');%读取波形文件获得数据
%  length_x1=size(x(:,1))
%  length_x2=size(x(:,2))
%  s=awgn(x,50);%添加50db的高斯白噪声
%    wavwrite(x,FS,'hello_add_noise_x.wav');
% x=x(:,1)+x(:,2);
x=x(:,1);
  length_x=size(x)
%    save('hello6_0324_snr25.mat','x');
%  wavwrite(x,FS,'hello_2-1_x.wav');
%  load('hello6_0412_snr15.mat') ;
%  x=x;
    s=awgn(x,15);
 length_s=size(s)
%    save('s_hello6_0324_snr25.mat','s');
%  load('s_hello6_0412_snr15.mat') ;
%  s=s;
  wavwrite(s,FS,'hello_add_noise_s_15.wav');
%   noise=0.1.*rand(1,l_x);
%   s=x+noise';
%   save('s_add_rand_noise0.1.mat','s');
%  load('s_add_rand_noise0.1.mat') ;
%  s=s;
%   wavwrite(s,FS,'hello_add_noise.wav');
% 设分解层数为k,小波基为db
% load noisbloc;
% s=noisbloc;
%  [x]=wnoise(1,10);
k=3;
db='db4';
level_num = k;

maxgen=5; %进化代数
popsize=3; %种群规模
pcross=0.6; %交叉概率
pmutation=0.05; %变异概率

for i = 1:1
    [best_thr,best_fit,new_sig]=GA_wave(s,x,level_num,db,maxgen,popsize,pcross,pmutation);
    save(['data_wave_i=',num2str(i),'.mat'],'best_thr','best_fit','new_sig')
end
 wavwrite(new_sig,FS,'hello6_new_0622_test3.wav');
save('hello6_denoise_new_0622_test3.mat','new_sig');
%   save('lesson_x_add.mat','x');
%    save('lesson_s_add.mat','s');
figure(1);
subplot(3,1,1);
plot(x);
title('初始信号');
subplot(3,1,2);
plot(s);
title('加噪信号');
subplot(3,1,3);
plot(new_sig);
title('软阈值函数去噪信号');