close all;
clear;
clc;
 [x,FS,NBITS]=wavread('hello_6.wav');%��ȡ�����ļ��������
% length_x=size(x)
%  x=awgn(x1,50);%���50db�ĸ�˹������
%    wavwrite(x,FS,'hello_add_noise_x.wav');
   x=x(:,1)+x(:,2);
%    save('hello6_0412_snr15.mat','x');
%  wavwrite(x,FS,'hello_2-1_x.wav');
%  load('hello6_0324_snr25.mat') ;
%  x=x;
%     s=awgn(x,15);
% % %  length_s=size(s)
%    save('s_hello6_0412_snr15.mat','s');
   load('s_hello6_0412_snr15.mat') ;
  s=s;
%  wavwrite(s,FS,'hello_6add_noise_s_15.wav');
%   noise=0.1.*rand(1,l_x);
%   s=x+noise';
%   save('s_add_rand_noise0.1.mat','s');
%  load('s_add_rand_noise0.1.mat') ;
%  s=s;
%   wavwrite(s,FS,'hello_add_noise.wav');
% ��ֽ����Ϊk,С����Ϊdb
% load noisbloc;
% s=noisbloc;
%  [x]=wnoise(1,10);
k=5;
db='db4';
level_num = k;

maxgen=100; %��������
popsize=50; %��Ⱥ��ģ
pcross=0.6; %�������
pmutation=0.05; %�������

for i = 1:1
    [best_thr,best_fit,new_sig]=GA_wave(s,s,level_num,db,maxgen,popsize,pcross,pmutation);
    save(['data_wave_i=',num2str(i),'.mat'],'best_thr','best_fit','new_sig')
end
 wavwrite(new_sig,FS,'hello6_new_0412_snr15_test5.wav');
save('hello6_new_0412_snr15_test5.mat','new_sig');
%   save('lesson_x_add.mat','x');
%    save('lesson_s_add.mat','s');
figure(1);
subplot(3,1,1);
plot(x);
title('��ʼ�ź�');
subplot(3,1,2);
plot(s);
title('�����ź�');
subplot(3,1,3);
plot(new_sig);
title('����ֵ����ȥ���ź�');