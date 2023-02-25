% clear
N=1000;%用户数量
ndifans=[5 5];%不同答案的个数
lambdas=N./ndifans;
d=2;
f=0.2
p=0
q=1
% dataset=zeros(N,d);
% for k=1:d
% flag=1;   
% while flag
% [AVFM,lambda1] = genAVFM(N,1,lambdas(k));
%     if size(AVFM,1)==ndifans(k);
%         flag=0;
%     end
% end
% stdcolumn=genstdset(AVFM);
% dataset(:,k)=gendataset(stdcolumn); %dataset 每一列由从1开始的连续自然数组成。数i代表第i属性值。
% end  

real_response3D=zeros(max(ndifans),N,d);% respons user timepoint
permute_response3D=real_response3D;
for k=1:d
    [real_response] = getvec(dataset(:,k));
    [real_response3D(:,:,k),permute_response3D(:,:,k)] = basicrappor(real_response,f,p,q);
end

pp=0.5*f*(p+q)+(1-f)*p;
qq=0.5*f*(p+q)+(1-f)*q;
real_freqs=sum(real_response3D,2);%单列频次
esti_freqs=(sum(permute_response3D,2)-pp*N)/(qq-pp);

realTF= getTFbyRes(real_response3D);% 序号 频次;%count the tuple frequency only by response
permuteTF=getTFbyRes(permute_response3D);
estiTF=zeros(size(permuteTF,1),1);



for i=1:size(estiTF,1)
    n1=esti_freqs(permuteTF(i,1),1,1);
    n2=esti_freqs(permuteTF(i,2),1,2);  

    estiTF(i)=(permuteTF(i,end)-(n1+n2)*qq*pp-(N-n1-n2)*pp^2)/(qq-pp)^2;
end


a=sort([realTF(:,end) permuteTF(:,end) estiTF],[1],'descend');
sum(a)

[B1 I1]=sort(real_freqs,'descend');
[B2 I2]=sort(esti_freqs,'descend');
compare=[I1 B1/N I2 B2/N];