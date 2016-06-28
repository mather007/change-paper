function [c3] = hard_func( a,b )
c=a';
thr1=b;
y1=length(c);
c3=zeros(size(c));
for i = 1:1:y1
    if(abs(c(i,1))>=thr1) 
        c3(i,1)=c(i,1);
    elseif(abs(c(i,1))<thr1)
        c3(i,1)=0;
    end
end
c3=c3';

end

