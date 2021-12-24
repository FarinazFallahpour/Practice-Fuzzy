function y=out_changer(x,num)
x=[4;3;6;2;1]
num=3;
x1=size(x,1)
y=zeros(x1,num);
y
yyy=size(y,1);
for i=1:yyy
    xi=x(i);
    y(i,xi)=1;
end
y
end

