%% Car
clc, clear, close all
%% Define Size
a=1;
b=2*a;
L=3*b;
%% Design trajectory
figure('doublebuffer','on')
set(gca,'XLim',[0 115],'YLim',[0 115])
grid on
line([0 0  50 50 90 90 112 112],[0 82 82 92 92 82 82 0],'Color','k','LineWidth',2)
line([6 6 56 56 86 86 106 106],[6 76 76 86 86 76 76 6],'Color','k','LineWidth',2)
line([6 106],[6 6],'Color','k','LineWidth',2)
line([0 112],[0 0],'Color','k','LineWidth',2)
axis equal
hold on
%% Read FIS
myfis=readfis('MyFuzzy.fis');
%% First point-------------> Random
 x=[1.5 2.5 2.5 1.5];
 y=[19 19 21 21];
rec=patch(x,y,'r');
 %%
while(1)
     %% get 
    xdata=get(rec,'Xdata');
    ydata=get(rec,'Ydata');
    center=[mean(xdata) mean(ydata)];
    xc=center(1);
    yc=center(2);

     %Region 1
   if(xc>0 && xc<6 && yc<76&& yc>6)

        input(1)=abs(6-xc);
        input(2)=xc;
        input(3)=yc;
        Theta = evalfis(input,myfis); %[x2 x3 x1]
        ydata=ydata-0.5;
       rotate(rec,[1,0,0],Theta,[xc yc 0 ] )
  
     % Region 2
  elseif(xc>0 && xc<6 && yc>0&& yc<6)
         ydata=ydata-0.2;
        xdata=xdata+0.2; %% ??? maybe?
        input(1)=abs(112-xc);
        input(2)=xc;
        input(3)=yc;
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[1,1,0],Theta,[xc yc 0 ] );
     
   % Region   3
  elseif(xc>6 && xc<106 && yc>0&& yc<6)
         xdata=xdata+0.2;
        input(1)=abs(6-yc);
        input(2)=yc;
        input(3)=abs(112-xc);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[0,1,0],Theta,[xc yc 0 ] );
     
   % Region 4
   elseif(xc>106 && xc<112 && yc>0&& yc<6)
         ydata=ydata+0.2;
         xdata=xdata+0.2;
        input(1)=abs(yc-6);
        input(2)=yc;
        input(3)=abs(112-xc);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[1,1,0],Theta,[xc yc 0 ] );
       
     % Region 5
   elseif(xc>106 && xc<112 && yc<76&& yc>6)
        input(1)=abs(106-xc);
        input(2)=abs(112-xc);
        input(3)=abs(82-yc);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
        ydata=ydata+0.5;
       rotate(rec,[1,0,0],Theta,[xc yc 0 ] );
  % Region 6
   elseif(xc>106 && xc<112 && yc>76 && yc<82 )
         ydata=ydata-0.2;
         xdata=xdata+0.2;
        input(1)=abs(xc-76);
        input(2)=abs(xc-86);
        input(3)=abs(82-yc);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[1,1,0],Theta,[xc yc 0 ]);
   
   %Region 7
    elseif(xc>86 && xc<90 && yc>76&& yc<82)
         xdata=xdata-0.2;
        input(1)=abs(82-yc);
        input(2)=abs(76-yc);
        input(3)=abs(86-xc);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[0,1,0],Theta,[xc yc 0 ] );
   %Region 8
      elseif(xc>86 && xc<90 && yc>76 && yc<82 )
         ydata=ydata+0.2;
         xdata=xdata-0.2;
        input(1)=abs(yc-82);
        input(2)=abs(yc-76);
        input(3)=abs(xc-86);
        Theta = evalfis(input,myfis); %[x2 x3 x1]
       rotate(rec,[1,1,0],Theta,[xc yc 0 ] );
   end
   disp(input);
   disp(Theta);
       pause(0.1);
    
   
 end