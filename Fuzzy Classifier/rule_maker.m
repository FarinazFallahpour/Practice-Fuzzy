function rule=rule_maker(N)
num=2^N-1;
rule=zeros(num,N);
for i=0:num
    a=dec2bin(i);
    L=length(a);
    for j=N:-1:1
        try
        rule(i+1,j)=str2num(a(L));
        L=L-1;
        catch
            break
        end
    end
end
rule(rule==1)=2;
rule(rule==0)=1;
