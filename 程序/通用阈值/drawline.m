  clear;clc;close all;
  x=-10:0.01:10;
  
  b=5;
  a=b/2;
  f=(sign(x).*(abs(x)-b)).*(abs(x)>=b)+0.*(abs(x)<b);
  g=(x).*(abs(x)>=b)+0.*(abs(x)<b);
  h=((a./b.^3).*x.^3).*(abs(x)<b)+(sign(x).*(abs(x)-(b-a))).*(abs(x)>=b);
  figure(1);
  plot(x,f,'k');

  hold on;
  plot(x,g,'.');  
  hold on;
  plot(x,h,'r--')
  title('��ֵ����ͼ��');
   legend('����ֵ����','Ӳ��ֵ����','����ֵ����','Location','NorthWest')
%   grid on;