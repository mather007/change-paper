function [new_C]=new_func_2(C,pos_L1,pos_L2,thr1)
%-------------------------------------------------------------------------
%   ���ؾ������ĸ���ϵ��
%   pos_L1��pos_L2�Ǹ���ϵ����C�е�����
%   thr1�Ǹ�����ֵ
%-------------------------------------------------------------------------
new_C = C;
level_num = length(thr1);%�ҳ����ֽ��˼���
for i= 1:level_num
    new_C(pos_L1(end-i+1):pos_L2(end-i+1))=(sign(C(pos_L1(end-i+1):pos_L2(end-i+1))).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))-(thr1(i)/2)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))>=thr1(i)))+((C(pos_L1(end-i+1):pos_L2(end-i+1)).^3)./(2*(thr1(i).^2)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))<thr1(i)));
end
end




