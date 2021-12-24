function MSE=Cost(X)
for k=1:size(X,1)
    x=X(k,:);
% clc
% clear
% x=[[1,0,0,0,0,1,0,1,1,1,1,0,0,1,1,0,1,0,1,0,0,0,0,1,0,1,1,0,1,0,0,0,1,0,1,0,0,0,1,1,0,0,0,1,0,0,0,1,0,1,0,0,1,1,0,1,1,0,1,0,0,1,1,1,0,0,0,1,0,1,0,0,1,1,0,0,1,1,0,0,1,0,1,0,0,1,0,0,0,1,0,1,1,0,1,1,0,1,1,0,0,1,1,0,0,1,0,0,0,0,1,0,0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0,0,0,0,1,0,1,1,0,0,1,0,1,0,0,0,1,0,1,0;]];
x1=reshape(x',3,49)';
x1=bin2dec(num2str(x1));
x1(x1==0)=7;
load data
Rule=[rulebase x1 ones(length(x1),1) ones(length(x1),1)];
load myfis
fis=addrule(fis,Rule);%rul hayi ke ga midahad be fuzzy khorande mishavad
yp=evalfis([X11' X21'],fis);%khorjooi dadehaye tran ra pish bini mikonim
MSE(k)=mse(Y1'-yp);%mse dadeh haye train mohasebe mishavad
end