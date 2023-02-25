function [DT,DTF,DTAVF,IDTAV,AVFM,AVM] = getDTAVF(dataset)
%Get all Tuples in dataset(DT), Frequencies of Tuples in the dataset (DTF),
%Frequencies of the Tuples' Attribute Values in the dataset (DTAVF), Indexs
%of Values of each Attribute in the dataset (IDTAV), Attribute Value
%Frequency Matrix (AVFM), Attribute Value Matrix (AVM)
%All attribute values in the dataset are nutural numbers.

[AVFM,AVM] = getAVFM(dataset);%
[n,d]=size(dataset);%
[DT,IA,IC]=unique(dataset,'rows');
table=tabulate(IC);
DTF=table(:,2);
IDTAV=zeros(size(DT));
for j=1:d
[~,index]=ismember(DT(:,j),AVM(:,j));
IDTAV(:,j)=index;
DTAVF(:,j)=AVFM(index,j);
end
end

