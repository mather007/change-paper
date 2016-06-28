function [c] = wave_encode( c_max_min,every_thr_len,num_seqs)
%-------------------------------------------------------------------------
%   WAVE_ENCODE 返回的就是各个染色体对应的实际阈值
%-------------------------------------------------------------------------
%先将二进制字符数串按照每个阈值所占的个数分割，然后转化为十进制,
%最终返回的就是各个染色体对应的实际阈值

len = length(every_thr_len);%这一条染色体要分成几部分,即有几个阈值,也就是几层分解,还要加上一个系数
[m,~] = size(num_seqs);%这是染色体的个数和编码的总个数
pos_2 = cumsum(every_thr_len);%累加求第二位置
pos_1 = [1,pos_2(1:len-1)+1];%求第一位置
pos = zeros(len,2);
for i = 1:len
    pos(i,:) = [pos_1(i),pos_2(i)];
end
c = zeros(m,len);%最后返回类似[c1,c2,c3;c1',c2',c3';....]这样的矩阵
to_be_c = c;
for i = 1:m%一条一条的取出染色体数串
    will_be_c = num_seqs(i,:);
    for j = 1:len 
        str = num2str(will_be_c(pos(j,1):pos(j,2)));
        to_be_c(i,j) = bin2dec(str);
        c(i,j) = to_be_c(i,j)*((c_max_min(j,1)-c_max_min(j,2))/(2^(every_thr_len(j))-1))+c_max_min(j,2);
    end
    %最终返回的就是各个染色体对应的实际阈值
end
end

