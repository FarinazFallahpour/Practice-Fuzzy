%% *********** Function approximation by fuzzy inference system
%% Make Data
clc;
clear;
%% Train and Test Data
n_train=50;
n_test=30;
x1=-7:0.2:7;
x2=-7:0.2:7; 
%% Generate Training And Test Pattern
R11=randperm(length(x1));
R12=randperm(length(x1));
R21=randperm(length(x2));
R22=randperm(length(x2));

X11=x1(R11(1:n_train));
X21=x2(R21(1:n_train));
X12=x1(R12(1:n_test));
X22=x1(R22(1:n_test));
%% 
Y1=(sin(X11).*sin(X21))./(X11.*X21);
Y2=(sin(X12).*sin(X22))./(X12.*X22);
%% Create 49 rule
i=0;
for r1=1:7
    for r2=1:7
        i=i+1;
        rulebase(i,:)=[r1 r2];
    end
end
%% Make data.mat
save data X11 X12 X21 X22 Y1 Y2 rulebase