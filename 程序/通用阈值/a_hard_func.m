function [ new_C] = a_hard_func(c,m,k,pos_L1,pos_L2)
%c��ȫ��ϵ����m�Ǹ�����ֵ,k�Ƿֽ����
C=c;
new_C=C;
for i=1:k
    new_C(pos_L1(i+1):pos_L2(i+1))=(C(pos_L1(i+1):pos_L2(i+1))).*(abs(C(pos_L1(i+1):pos_L2(i+1)))>=m(i))+0.*(abs(C(pos_L1(i+1):pos_L2(i+1)))<m(i));%��ֵ�����ϵ��
end


end







