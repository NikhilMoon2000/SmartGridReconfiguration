clc;
clear;
%%problem setting

hi=1e5;
buses=load("loaddata33bus.m");
inf=10e20;


lb=[1 1 1 1 1];
ub=[37 37 37 37 37];
%prob=@re;
%%alog setting
np=50; % population size is taken to be 50
t=5000; %no of iteration
w=0.07;
c1=0.1;
c2=0.1;

% w=0.09; % inertia constanst
% c1=0.003; % accelaration constant
% c2=0.003; % accelaration constant
branches=load("linedata33bus.m");
for ti=1: length(branches)
    branches(ti,6)=1;
end
b=branches;
%%********************particle swarm opt*************************
f=repmat(inf,np,1); %function value for each population point

d=length(lb); % as we have five tie switch
p=randi([1,37],np,d);% getting random values for the the popultion
v=randi([1,37],np,d);% getting random valures for the
% p(1,:)=[7 9 14 32 37];

tic;

for i=1: length(p)
    branches0=b;
    
    for j=1:5
       branches0(p(i,j),6)=0;
    end
    
    new_branches0=NaN(32,7);
    c=0;
    loop0=NaN(5,4);
    l=1;
    new_s0=zeros(32,1);
    new_d0=zeros(32,1);
    
    for m=1: length(branches0)
        if(branches0(m,6)==1)
            c=c+1;
            new_s0(c,1)=branches0(m,2);
            new_d0(c,1)=branches0(m,3);
            new_branches0(c,:)=branches0(m,:);
            
        else
            
            loop0(l,:)=[branches0(m,2) branches0(m,3) inf inf];
            l=l+1;
        end
    end
    
    
    
    
    
    new_graph0=graph(new_s0,new_d0);
    
    if(graphisspantree(adjacency(new_graph0)))
        %tic;
        disp(['time for the ' num2str(i)]);
        
        [vk ,ploss]=load_flow(new_branches0,buses,loop0);
        
        f(i,1)=real(ploss);
        %toc
    end
end
disp('time for the whole initialization loop');
%toc


pbest=p;
fpbest=f;
[fgbest,ind]=min(fpbest);
gbest=p(ind,:);
%%iterative loop
disp("gogo");



for j=1:t
    for k=1:np
        
        v(k,:)=round(w*v(k,:))+ round(c1*randi([1,37],1,5).*(pbest(k,:)- p(k,:)))+round(c2*randi([1,37],1,5).*(gbest- p(k,:)));
        
        p(k,:)=p(k,:)+v(k,:);
        
        p(k,:)=max(p(k,:),lb);
        p(k,:)=min(p(k,:),ub);
        
        branches1=b;
        
        for row=1:5
            branches1(p(k,row),6)=0;
        end
        new_branches1=NaN(32,7);
        c=1;
        loop1=NaN(5,4);
        l=1;
        
        for m=1: length(branches1)
            if(branches1(m,6)==1)
                
                new_branches1(c,:)=branches1(m,:);
                c=c+1;
                
            else
                
                loop1(l,:)=[branches1(m,2) branches1(m,3) inf inf];
                l=l+1;
            end
        end
        new_s1=zeros(length(new_branches1),1);
        new_d1=zeros(length(new_branches1),1);
        for q=1 : length(new_branches1)
            new_s1(q,1)=new_branches1(q,2);
            new_d1(q,1)=new_branches1(q,3);
        end
        new_graph1=graph(new_s1,new_d1);
        if(graphisspantree(adjacency(new_graph1)))
            
            %disp(['the time for load flow of' num2str(j) 'iteration and the population' num2str(k) ]);
            
            [vk ,ploss]=load_flow(new_branches1,buses,loop1);
            f(k,1)=real(ploss);
            
        end
        
        if f(k,1) < fpbest(k,1)
            fpbest(k,1)=f(k,1);
            pbest(k,:)=p(k,:);
            if fpbest(k,1)<fgbest
                fgbest=fpbest(k,1);
                gbest=pbest(k,:);
            end
        end
    end
    
    
    
    disp(['iteration ' num2str(j) ' globalvalue ' num2str(fgbest) ' at the position ' num2str(gbest)]);
    
end


disp(fgbest);
disp(gbest);
bestf=fgbest;
bestso=gbest;
disp("end of the algorithm");


        

    
            
    
    
    
    
    
    
    




