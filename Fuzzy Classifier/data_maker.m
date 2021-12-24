clc
clear
name='iris1'
load(name)
R=randperm(size(in,1));
in=in(R,:);
save(name,'in');

