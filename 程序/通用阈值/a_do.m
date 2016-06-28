close all;
clear;
clc;
% [x,FS,NBITS]=wavread('hello_6.wav');%��ȡ�����ļ��������
%  x=x(:,1)+x(:,2);
% s=awgn(x,25);%���50db�ĸ�˹������
load('hello6_0412_snr15.mat');
x=x;
s=awgn(x,15);%���50db�ĸ�˹������
%  load('s_hello6_0412_snr15.mat');
%  s=s;
% load noisbloc;
% s=noisbloc;
% [x]=wnoise(1,10);
% s=awgn(x,15);%���15db�ĸ�˹������

% load leleccum;
% s=leleccum;
%��ֽ����Ϊk,С����Ϊdb
k=5;
db='db4';
%����С���ֽ⺯��
%��ʼ�ֽ�
[C,L]=wavedec(s,k,db);
%��L�õ�����ϵ����C�е���ʼ�������ֹ����
L_plus = [1,L']
pos_L1 = cumsum(L_plus);
pos_L2 = cumsum(L');
pos_L1 = pos_L1(1:k+1);%ֻ�в���+1λ��֮ǰ�������õ�
pos_L2 = pos_L2(1:k+1);%ֻ�в���+1λ��֮ǰ�������õ�

%���������ֵm
for i=1:k
    m(i)=a_normal_yuzhi(C(pos_L1(i+1):pos_L2(i+1)),i)%�����ֵ
end
new_C=a_soft_func(C,m,k,pos_L1,pos_L2);%����ֵ����ȥ��
new_C_h=a_hard_func(C,m,k,pos_L1,pos_L2);%Ӳ��ֵ����ȥ��
new_C_new=a_new_func(C,m,k,pos_L1,pos_L2);%Ӳ��ֵ����ȥ��


%�ع��ź�
new_s=waverec(new_C,L,db);%�ع�����ֵϵ���ź�
new_s_h=waverec(new_C_h,L,db);%�ع�Ӳ��ֵϵ���ź�
new_s_new=waverec(new_C_new,L,db);%�ع�����ֵϵ���ź�
% fangcha=var(new_s-s)
%������Ⱥ;������
[soft_u,soft_d]=a_snr(x,new_s)%��
[hard_u,hard_d]=a_snr(x,new_s_h)%Ӳ
[new_u,new_d]=a_snr(x,new_s_new)%��

%��ͼ

figure(1);
%����ԭͼ��
subplot(3,2,1);
plot(x);
title('��ʼ�ź�');
%��������ͼ��
subplot(3,2,2);
plot(s);
title('�����ź�');
%����ȥ���ͼ��
subplot(3,2,3);
plot(new_s);
title('����ֵ����ȥ����ź�');
subplot(3,2,4);
plot(new_s_h);
title('Ӳ��ֵ����ȥ����ź�');
subplot(3,2,5);
plot(new_s_new);
title('����ֵ����ȥ����ź�');