function [thr] = a_normal_yuzhi(a,j)
%NORMAL_YUZHI Summary of this function goes here
%   Detailed explanation goes here
m=a;
m_l=length(a);
%a�ľ�ֵ
ave=sum(a)/m_l;
%�������
m_var=sum((a-ave).^2)/m_l;
%�����ֵ
thr=(m_var*sqrt(2*log(m_l)))

end

