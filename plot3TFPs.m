%pre-setting
color=[44, 62, 80;39, 174, 96;41, 128, 185;142, 68, 173]/255;
lightcolor=[163 181 209;187 242 184;142 193 229 ;200 168 224]/255;
ndim=size(TFP0,1);%number of dimension
Ltha=40;%for ploting
delt=2;%for ploting

[score_KL,score_JS]=deal(zeros(ndim,1));
VL=max((TFP1>0).*(1:size(TFP1,2)),[],2);%the column number of rightmost non zero element in each row
set(0,'DefaultAxesFontsize',12);
set(0,'DefaultTextFontsize',12);
for i=1:ndim
  [score_KL(i), score_JS(i)] = KL_JS_div(TFP0(i,1:VL(i)), TFP1(i,1:VL(i)));%calculate the JS values between the experience distribution and the d-RH distribution
end 
[~,p]=max(score_JS);%get the postion of the element with the max JS value
validpoint=TFP0>0;
semilogy(0:Ltha,TFP0(p,1:Ltha+1),'LineWidth',3,'Color',color(1,:))
hold on
semilogy(0:delt:Ltha,TFP1(p,1:delt:Ltha+1),'s','Color',color(3,:),'MarkerSize',12);
semilogy(0:delt:Ltha,TFP2(p,1:delt:Ltha+1),'+','Color',color(4,:),'MarkerSize',12);
pos=tuplelist(p,:);
tvf=AVFM((0:d-1)*size(AVFM,1)+pos);%tuple value frequency
xlabel("Tuple frequency");
ylabel("Probability")
str1="Experience distribution";
str2="Recursive hypergeometric distribution";
str3="Binomial distribution";
legend(str1,str2,str3);
title_str=strcat("\Psi_0=\{",num2str(N),",",num2str(d),",",mymat2str(tvf(1:end)),"\}");
title(title_str);
set(gca, 'YGrid','on');
hold off