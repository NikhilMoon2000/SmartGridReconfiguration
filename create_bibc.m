
function bibc= my_bibc(new_branch,~,loop)
% n=length(load);
 %m=length(new_branch);
 bibc(1:32,1:33)=-1;
 bibc(:,1)=0;
 while(check_bibc(bibc))
     
         
         for i=1: length(new_branch)
         
             s=new_branch(i,2);
             d=new_branch(i,3);
             if(bibc(1,s)==-1 && bibc(1,d)==-1)
             
                 continue;
             end
             
             if(bibc(1,s)==-1 && bibc(1,d)~=-1)
                 
                     bibc(:,s)=bibc(:,d);
                     bibc(i,s)=1;
             end
                  
              if(bibc(1,d)==-1 && bibc(1,s)~=-1)
                 
                     bibc(:,d)=bibc(:,s);
                     bibc(i,d)=1;
              end
         end
 end
 
 
 
    if(exist('loop', 'var'))
%         branch_no = length(new_branch) + 1;
%         c= n + 1;
%         for i = 1: length(loop)
%             from_branch = loop(i, 1);
%             to_branch = loop(i, 2);
%             bibc(:,c) = bibc(:, from_branch) - bibc(:, to_branch);
%             bibc(branch_no, c) = 1;
%             branch_no = branch_no + 1;
%             c = c + 1;                         
%         end
            r=33;
            c=34;
            
            for i=1:length(loop)
                bibc(r,c)=1;
                s=loop(i,1);
                d=loop(i,2);
                bibc(:,c)=bibc(:,s)-bibc(:,d);
                bibc(r,c)=1;
                r=r+1;
                c=c+1;
            end

%         disp(bibc);
%         disp(size(bibc));
    end
 % disp("the bibc succc");
end
              
             
             
              
                 
                 
                     
         
 
