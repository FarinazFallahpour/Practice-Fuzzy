%% GA
%% Initialization
clc;
close all
%% GA Setup
npop=20; % Number of Population
nvar=147; %Var Num
pc=0.8;% CrossOver Rate
nc=2*round(pc*npop/2);
mu=0.2;%Mutation Rate
nmu=round(mu*npop);
pop=randint(npop,nvar);
maxit=10;%GA Iteration 
bestpop=zeros(maxit,nvar);
bestcosts=zeros(maxit,1);
%% GA Loop
for it=1:maxit
% Calculation Cost
costs=Cost(pop);
% Sorting The Population According To The CostValue
[costs ind]=sort(costs);
pop=pop(ind(1:npop),:);       
costs=costs(1:npop);
% Updare Best Population And BestCost
bestpop(it,:)=pop(1,:);
bestcosts(it)=costs(1);
% Display Results
disp(['Iteration ' num2str(it) ':   Best Cost = ' num2str(bestcosts(it))]);
if it==maxit
  break;
end
%Fitness calculation
 f=exp(-costs);
% Selection -----------** p? ehtemale selection
p=f/sum(f);
% Crossover
ii=zeros(nc/2,2);
  for k=1:nc
    ii(k)=Select(p);
  end
pop2=zeros(nc,nvar);
  for k=1:nc/2
  p1=pop(ii(k,1),:);
  p2=pop(ii(k,2),:);
  c=randint(1,1,[1 nvar-1]);
  ch1=[p1(1:c) p2(c+1:end)];
  ch2=[p2(1:c) p1(c+1:end)];
  pop2(2*k-1,:)=ch1;
  pop2(2*k,:)=ch2;
  end
% Mutation
pop3=zeros(nmu,nvar);
i=randint(nmu,1,[1 npop]);  % Which Chromosome
j=randint(nmu,1,[1 nvar]);  % Which Gene
 for k=1:nmu
  pop3(k,:)=pop(i(k),:);
  pop3(k,j(k))=1-pop3(k,j(k));
  end
 % Merging Population
pop=[pop; pop2; pop3];
end
%% Plot BestCost on GA
plot(bestcosts);
F=Cost(pop);
%%
[s,id]=min(F);
Ans=pop(id,:);
x=Ans;
x1=reshape(x',3,49)';
x1=bin2dec(num2str(x1));
x1(x1==0)=7;
load data;
Rule=[rulebase x1 ones(length(x1),1) ones(length(x1),1)];
load myfis;
fis=addrule(fis,Rule);
disp('calculated rules are :')
showrule(fis) %Display Fuzzy Inference Systeules
yp1=evalfis([X11' X21'],fis);
MSE1=mse(Y1'-yp1);
disp(['train data mse=' num2str(MSE1)]);
figure;
plot(Y1,'.')
hold on
plot(yp1,'r.')
title('train data performance')
legend('actual','fuzzy predict')
yp2=evalfis([X12' X22'],fis);
MSE2=mse(Y2'-yp2);
disp(['test data mse=' num2str(MSE2)]);
figure;
plot(Y2,'.')
hold on
plot(yp2,'r.')
title('test data performanace')
legend('actual','fuzzy predict')
