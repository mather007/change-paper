function [new_C]=new_func_3(C,pos_L1,pos_L2,thr1)
%-------------------------------------------------------------------------
%   返回经软处理后的各层系数
%   pos_L1和pos_L2是各层系数在C中的坐标
%   thr1是各层阈值，thr1最后一个放的是系数
%-------------------------------------------------------------------------
new_C = C;
level_num = length(thr1)-1;%找出共分解了几层
alfa_xishu = thr1(end);
for i= 1:level_num
    %new_C(pos_L1(end-i+1):pos_L2(end-i+1))=(sign(C(pos_L1(end-i+1):pos_L2(end-i+1))).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))-(thr1(i)/2)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))>=thr1(i)))+((C(pos_L1(end-i+1):pos_L2(end-i+1)).^3)./(2*(thr1(i).^2)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))<thr1(i)));
    new_C(pos_L1(end-i+1):pos_L2(end-i+1))=(sign(C(pos_L1(end-i+1):pos_L2(end-i+1))).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))-(thr1(i)*alfa_xishu)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))>=thr1(i)))+((C(pos_L1(end-i+1):pos_L2(end-i+1)).^3)./(2*(thr1(i).^2)).*(abs(C(pos_L1(end-i+1):pos_L2(end-i+1)))<thr1(i)));
end
end




