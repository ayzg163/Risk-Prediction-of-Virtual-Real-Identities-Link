function [AVFM,AVM] = getAVFM(dataset)
%Get the Attribute Value Frequency Matrix of a given dataset
%   
    [n,m]=size(dataset);
    for j=1:m
        table=tabulate(dataset(:,j));
        AVFPos=find(table(:,2)~=0);
        AVC=length(AVFPos);
        AVFM(1:AVC,j)=table(AVFPos,2);
        AVM(1:AVC,j)=table(AVFPos,1);
    end
end

