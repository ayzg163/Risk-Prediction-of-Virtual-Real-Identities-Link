function [stdset] = genstdset(AVFM)
%Generating standard matrix based on a given Attribute Value Frequency Matrix
%AVFM=3*ones(3,3);%Only for testing

[~,nAttrib]=size(AVFM);
nRecord=sum(AVFM(:,1));
stdset=zeros(nRecord,nAttrib);
for j=1:nAttrib
    AVF=AVFM(:,j);
    AVF=AVF(find(AVF~=0));
    nAttribvalue=length(AVF);
    Column=zeros(1,nRecord);
    begin=1;
    for k=1:nAttribvalue
        Column(begin:begin+AVF(k)-1)=k;
        begin=begin+AVF(k);
    end      
    stdset(:,j)=Column;
end
end

