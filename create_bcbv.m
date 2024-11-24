function bcbv=my_bcbv(new_branch,~,loop)
%m=length(new_branch);
%n=length(load);
bcbv(1:33,1:32)=-1;
bcbv(1,:)=0;
while(check_bcbv(bcbv))
    [~,col]=size(bcbv);
    for i=1: col
        s=new_branch(i,2);
        d=new_branch(i,3);
        r=new_branch(i,4);
        x=new_branch(i,5);
        if(bcbv(s,1)==-1 && bcbv(d,1)==-1)
            continue;
        end
        if(bcbv(s,1)==-1 && bcbv(d,1)~=-1)
            bcbv(s,:)=bcbv(d,:);
            bcbv(s,i)=r+1i*x;
        end
        if(bcbv(d,1)==-1 && bcbv(s,1)~=-1)
            bcbv(d,:)=bcbv(s,:);
            bcbv(d,i)=r+1i*x;
        end
    end
end


if(exist('loop', 'var'))
    ro=34;
    c=33;
    
    for i=1:length(loop)
        bcbv(ro,c)=0;
        s=loop(i,1);
        d=loop(i,2);
        r=loop(i,3);
        x=loop(i,4);
        
        bcbv(ro,:)=bcbv(s,:)-bcbv(d,:);
        bcbv(ro,c)=r+1j*x;
        ro=ro+1;
        c=c+1;
    end
    
    %          disp(bcbv);
    %          disp(size(bcbv));
end
%disp("the bcbv succ");
end
        
        