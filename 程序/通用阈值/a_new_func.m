function [ new_C] = a_new_func(c,m,k,pos_L1,pos_L2)
%c是全部系数，m是各层阈值,k是分解层数
C=c;
new_C=C;
for i=1:k
    new_C(pos_L1(i+1):pos_L2(i+1))=(sign(C(pos_L1(i+1):pos_L2(i+1))).*(abs(C(pos_L1(i+1):pos_L2(i+1)))-(m(i)-0))).*(abs(C(pos_L1(i+1):pos_L2(i+1)))>=m(i))+((C(pos_L1(i+1):pos_L2(i+1)).^3./(m(i).^3)).*(0)).*(abs(C(pos_L1(i+1):pos_L2(i+1)))<m(i));%阈值化后的系数
end
end

