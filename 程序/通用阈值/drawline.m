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
  title('阈值函数图像');
   legend('软阈值函数','硬阈值函数','新阈值函数','Location','NorthWest')
%   grid on;