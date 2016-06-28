function [ c1] = new_func( a,b )
c=a';
thr1=b;
y1=length(c);
c1=zeros(size(c));
for i = 1:1:y1
    if(abs(c(i,1))<(-thr1)) 
        c1(i,1)=c(i,1)+thr1;
    elseif(abs(c(i,1))>thr1)
        c1(i,1)=c(i,1)-thr1;
    else
        c1(i,1)=(c(i,1)).^3./thr1.^3;
    end
end
c1=c1';

end

