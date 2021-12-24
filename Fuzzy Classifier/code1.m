clc
clear
data='iris';
Ratio=0.3;
%bem goft w ra taghir bedi raveshaye mokhtalef mishe w=1,2,3,4
consider_w=1;
load(data);
out=in(:,end); %label
in(:,end)=[]; % in alan shamele instance hamon bedone lable
n_in=size(in,2); % feature#
n_out=length(unique(out)); % tedad class ha
max_in=max(in); %max har feature
min_in=min(in); %min har feature
in=(in-repmat(min_in,size(in,1),1))./(repmat(max_in,size(in,1),1)-repmat(min_in,size(in,1),1));
% (har instance- min)/(max-min)
R=1:(size(in,1));
num=floor(size(in,1)*Ratio);
idtest=R(1:num);
idtrain=R(num+1:end);
intest=in(idtest,:);outtest=out(idtest);
intrain=in(idtrain,:);outtrain=out(idtrain);
in=intrain;out=outtrain;
mf1=[-1 0 1];
mf2=[0 1 2];
t=0:.01:1;
y1=evalmf(t,mf1,'trimf');
y2=evalmf(t,mf2,'trimf');
figure(1)
plot(t,y1,'k',t,y2,'r')
axis([0 1 0 1.2])
title('Membership Function')
rule=rule_maker(n_in);
M(:,:,1)=evalmf(in,mf1,'trimf');
M(:,:,2)=evalmf(in,mf2,'trimf');
    for k=1:n_out
        class(k).id=find(out==k);
    end
    Conf=zeros(size(rule,1),n_out);
for i=1:size(rule,1)
        R=rule(i,:);
        mio=zeros(size(in,1),size(in,2));
    for j=1:length(R)
        mio(:,j)=M(:,j,R(j));
%         w(j)
    end
        Mio=prod(mio,2);
        confsum=sum(Mio);
    for k=1:n_out
        conff(k)=sum(Mio(class(k).id));
    end
        conff=conff/confsum;
        Conf(i,:)=conff;
end
MM=Conf;
        [wmax,idw]=max(MM');
        MM2=MM;
        for j=1:size(MM2,1)
            MM2(j,idw(j))=-inf;
        end
        switch consider_w
            case 0
                w=ones(size(Conf,1),1);
            case 1
                w=wmax';
            case 2
                
                [w2th,idw]=max(MM2');
                w=wmax'-w2th';
                w(w<0)=0;
            case 3
                wmean=mean(MM');
                w=wmax'-wmean';
                w(w<0)=0;
            case 4
                wsum=sum(MM');
                w=2*wmax'-wsum';
                w(w<0)=0;
        end
[s,winner]=max(Conf');
outrule=winner';
yptrain=eval_fuzzy(rule,outrule,intrain,w);
yptest=eval_fuzzy(rule,outrule,intest,w);
compartest=[yptest-outtest];
compartrain=[yptrain-outtrain];
f1=find(compartest==0);
f2=find(compartrain==0);
sehattest=length(f1)/length(compartest);
sehattrain=length(f2)/length(compartrain);
disp(['Train Data Performance =' num2str(sehattrain) '%'])
disp(['Test Data Performance =' num2str(sehattest) '%'])
figure(2)
y1=out_changer(yptest,n_out);y2=out_changer(outtest,n_out);
plotconfusion(y1',y2')
title('Test Data Performance')
figure(3)
y1=out_changer(yptrain,n_out);y2=out_changer(outtrain,n_out);
plotconfusion(y1',y2')
title('Train Data Performance')







    

