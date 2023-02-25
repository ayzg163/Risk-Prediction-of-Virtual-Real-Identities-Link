function [str]=mymat2str(mat,deli)
%%convert a matrix to a string with separators
if nargin==1
    deli=',';
end
array=mat(:);
str=[num2str(array(1))];
for i=2:length(array)
    str=[str,deli,num2str(array(i))]
end
