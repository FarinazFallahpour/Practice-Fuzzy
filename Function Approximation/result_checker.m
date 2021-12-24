clc
clear
load result
x1=-7:.1:7;
x2=x1;
figure;
[X1,X2]=meshgrid(x1,x2)
for i=1:size(X1,2)
    for j=1:size(X1,1)
        Y(i,j)=evalfis([X1(i,j) X2(i,j)],fis);
    end
end
Y