function [c] = wave_encode( c_max_min,every_thr_len,num_seqs)
%-------------------------------------------------------------------------
%   WAVE_ENCODE ���صľ��Ǹ���Ⱦɫ���Ӧ��ʵ����ֵ
%-------------------------------------------------------------------------
%�Ƚ��������ַ���������ÿ����ֵ��ռ�ĸ����ָȻ��ת��Ϊʮ����,
%���շ��صľ��Ǹ���Ⱦɫ���Ӧ��ʵ����ֵ

len = length(every_thr_len);%��һ��Ⱦɫ��Ҫ�ֳɼ�����,���м�����ֵ,Ҳ���Ǽ���ֽ�,��Ҫ����һ��ϵ��
[m,~] = size(num_seqs);%����Ⱦɫ��ĸ����ͱ�����ܸ���
pos_2 = cumsum(every_thr_len);%�ۼ���ڶ�λ��
pos_1 = [1,pos_2(1:len-1)+1];%���һλ��
pos = zeros(len,2);
for i = 1:len
    pos(i,:) = [pos_1(i),pos_2(i)];
end
c = zeros(m,len);%��󷵻�����[c1,c2,c3;c1',c2',c3';....]�����ľ���
to_be_c = c;
for i = 1:m%һ��һ����ȡ��Ⱦɫ������
    will_be_c = num_seqs(i,:);
    for j = 1:len 
        str = num2str(will_be_c(pos(j,1):pos(j,2)));
        to_be_c(i,j) = bin2dec(str);
        c(i,j) = to_be_c(i,j)*((c_max_min(j,1)-c_max_min(j,2))/(2^(every_thr_len(j))-1))+c_max_min(j,2);
    end
    %���շ��صľ��Ǹ���Ⱦɫ���Ӧ��ʵ����ֵ
end
end

