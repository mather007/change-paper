function [u,d] = a_snr( s,new_s)
%A_SNR Summary of this function goes here
%   Detailed explanation goes here
N=length(s);
u=10*log10((sum(s.^2))/sum((new_s-s).^2));
d=sqrt((1/N)*sum((new_s-s).^2));


end

