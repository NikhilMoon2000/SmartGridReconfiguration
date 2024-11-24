%/////////////////original 33 bus system plot///////////////
clear;
clc;

 h=load("linedata33bus.m");
l=load("loaddata33bus.m");
% old_branch=NaN(32,7);
% co=1;
% for oi=1: length(h)
%     if(h(oi,6)==1)
%         old_branch(co,:)=h(oi,:);
%         co=co+1;
%    
%         
%     end
%     
% end
% [vko,plosso]=load_flow(old_branch,l);
% disp(real(plosso));
% disp("+");
% disp(imag(plosso));


%//////end of the old  33 bus system  //////////////////


% 
%///////////////new reconfigured system  start//////////////////

for hg=1: length(h)
    h(hg,6)=1;
    if(h(hg,2)==7 && h(hg,3)==8)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        h(hg,6)=0;
    end
    if(h(hg,2)==9 && h(hg,3)==10)
        h(hg,6)=0;
    end
    if(h(hg,2)==14 && h(hg,3)==15)
        h(hg,6)=0;
    end
    if(h(hg,2)==32 && h(hg,3)==33)
        h(hg,6)=0;
    end
    if(h(hg,2)==25&&h(hg,3)==29)
        h(hg,6)=0;
    end
end

m=NaN(32,1);
n=NaN(32,1);
c=1;
for i=1: length(h)
    if(h(i,6)==1)
        m(c,1)=h(i,2);
        n(c,1)=h(i,3);
        c=c+1;
    end
    
end
disp("check good")
new_branch=NaN(32,7);
cout=1;
loop=NaN(5,4);
lu=1;
for i=1: length(h)
    if(h(i,6)==1)
        new_branch(cout,:)=h(i,:);
        cout=cout+1;
    else
        r=h(i,4);
        x=h(i,5);
        
        inf=1e20;
        loop(lu,:)=[h(i,2) h(i,3) inf inf];
        lu=lu+1;
        
    end
    
end
[vk,ploss]=load_flow(new_branch,l,loop);
disp(real(ploss));
new=graph(m,n);

    

plot(new);
 

