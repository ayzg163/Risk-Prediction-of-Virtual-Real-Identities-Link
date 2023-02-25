function [AVFM,lambda1] = genAVFM(N,d,lambda)
%generating random attribute value frequency matrix based on parameters N,d and lambda
% for testing 
% N=1e6;
% d=round(rand()*9+2);
% lambda=0.01;

avgAVC=ceil((N/lambda)^(1/d));%The average number of the attribute value categories
while true 
    L=randi([2,2*avgAVC],[d,1]);%The range of the number of the attribute value categories is from 2 to 2*avgAVC
    if abs(lambda-N/prod(L))/lambda<=0.01
        break;
    end
end
AVFM=zeros(max(L),d);
lambda1=N/prod(L);
for j=1:d     
    a=randfixedsum(L(j),1,N,1,max(ceil(1.2*N/L(j)),round(0.4*N)));%generating random numbers with fixed sum
    a=round(a);
    [m,p]=max(a);
    a(p)=m+N-sum(a);
    AVFM(1:L(j),j)=a;
end
[Ld,IX]=sort(L,'descend');
AVFM=AVFM(:,IX);

end

