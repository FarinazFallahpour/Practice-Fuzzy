function y=eval_fuzzy(rule,outrule,In,w)
% clc
% clear
% 
% load data
% In=in;
y=zeros(size(In,1),1);
M(:,:,1)=evalmf(In,[-1 0 1],'trimf');
M(:,:,2)=evalmf(In,[0 1 2],'trimf');
MM=[];
for i=1:size(In,1)
    in=In(i,:);
    Mio=zeros(size(rule,1),1);
    for j=1:size(rule,1)
        mio=1;MM=[];
        for k=1:length(in)
            mio=mio*M(i,k,rule(j,k));
            MM=[MM M(i,k,rule(j,k))];
        end

        

        Mio(j)=mio;
    end
    [ss,idbest]=max(Mio.*w);
    for r=1:length(unique(outrule))
        id(r).rule=find(outrule==r);
        miorule(r).rule=outrule(id(r).rule);
    end
    y(i)=outrule(idbest);
end

        
    
    