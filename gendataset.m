function [dataset] = gendataset(stdset)
%Generating random dataset based standard dataset
  
[nRecord,nAttrib]=size(stdset);
dataset=stdset;
for j=1:nAttrib
    Column=stdset(:,j);
    Column=Column(randperm(nRecord));
    dataset(:,j)=Column;    
end
end

