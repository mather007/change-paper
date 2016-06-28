function [thr] = a_normal_yuzhi(a,j)
%NORMAL_YUZHI Summary of this function goes here
%   Detailed explanation goes here
m=a;
m_l=length(a);
%a的均值
ave=sum(a)/m_l;
%求出方差
m_var=sum((a-ave).^2)/m_l;
%求出阈值
thr=(m_var*sqrt(2*log(m_l)))

end

