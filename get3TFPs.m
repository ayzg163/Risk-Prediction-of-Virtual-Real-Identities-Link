%preprocessing
L=sum(AVFM>0);%the max number of attribute values
ntuple=prod(L);%number of all possible tuples in the random dataset
maxfrequency=300;%If maxfrequency is less than the max frequency of 
%experience distribution, then overflow may occur
tuplelist=zeros(ntuple,d);%list of all tuples of the random dataset
[TF,TFP0,TFP1,TFP2]=deal(zeros(ntuple,maxfrequency+1));%frequencies of all tuples in the datasets;experience distribution;RH distribution;binomial distribution

%listing all possible tuples
for i=0:ntuple-1
    quotient=i;
    for j=d:-1:1
        remainder=mod(quotient,L(j));
        quotient=fix(quotient/L(j));        
        tuplelist(i+1,j)=remainder+1;      
    end
end

%empirical distribution
tic
stdset=genstdset(AVFM); %generating standard dataset based on AVFM
for j=1:nround
uppos(ntest/nround).C=[];%the updating elements' positions of the TF matrix in each experiment of the given round
for i=1:ntest/nround
    dataset=gendataset(stdset); %generating random dataset based on standard dataset
    [lia locb]=ismember(dataset,tuplelist,'rows');
    tbl=tabulate(locb);
    ntbl=size(tbl,1);
    uppos(i).C=tbl(:,2).*ntuple+[1:ntbl]'; %the updating positions one-dimensional array 
end
for i=1:ntest/nround
    TF(uppos(i).C)=TF(uppos(i).C)+1;%the number of datasets containing given tuples with the given frequencies +1
    L=size(uppos(i).C,1);%tabulate function only counts the frequencies of the first to Lth tuples
    if L<ntuple
        TF(L+1:end,1)=TF(L+1:end,1)+1;%the number of datasets that the (L+1)th to the end tuples appear 0 times +1
    end
end
end
toc

%RH distribution
tic
TFP0=TF/ntest;%TP  tuple proportion
TAVFs=AVFM(tuplelist+(0:d-1)*size(AVFM,1));% tuples' attribute value frequencies
for i=1:ntuple
    TAVF=TAVFs(i,:);
    [TFP] = getTFP(N,d,TAVF);%get probability distribution of tuple frequencies
    TFP1(i,1:min(maxfrequency+1,length(TFP)))=double(TFP(1:min(maxfrequency+1,length(TFP))));%reduce precision for storage
    preTAVF=TAVF;   
end
toc

%binomial distribution
tic
TAVFs=AVFM(tuplelist+(0:d-1)*size(AVFM,1));% tuples' attribute value frequencies
TAVFs_1=sort(TAVFs,2,'descend');
for i=1:ntuple
    TAVF=TAVFs_1(i,:);%attribute value frequencies of the tuple
    TFP=binopdf(0:maxfrequency,TAVF(d),sym(prod(TAVF(1:d-1))/N^(d-1)));%using function sym() for high precision calculation
    TFP2(i,1:min(maxfrequency+1,length(TFP)))=double(TFP(1:min(maxfrequency+1,length(TFP))));%reduce precision for storage
end
toc

