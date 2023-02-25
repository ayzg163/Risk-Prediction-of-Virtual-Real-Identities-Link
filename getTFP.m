function [TFP,TFPE] = getTFP(N,d,TAVF)
%TFP: PMF of tuple frequency 
%TAVF: frequencies of attribute values in a tuple
%N: number of records in a dataset

TAVF=sort(TAVF,'ascend');
TFPE=zeros(TAVF(1)+1,d);%PMFs of frequencies of sub-tuples with length 1 to d 
TFPE(TAVF(1)+1,1)=1;

for j=2:d
    NZpos=find(TFPE(:,j-1)>0); %The positions of the positive elements in the (j-1)th column of TFPE
    n_j=TAVF(j);
    for x=max(n_j+min(NZpos)-1-N,0):n_j % k:the frequency of the sub-tuple with length j
        gexpos=NZpos(find(NZpos>x));% the positions of elements in TFPE greater than or equal to x
        TFPE(x+1,j)=sum(TFPE(gexpos,j-1).*hygepdf(x,N,gexpos-1,n_j));                                      
    end
end    
    TFP=vpa(TFPE(:,d),20);%PMF of tuple frequency (keeping 20 significant digits)
end