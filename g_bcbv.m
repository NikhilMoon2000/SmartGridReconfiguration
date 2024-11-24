function bcbv = g_bcbv(branches, buses, loop)
    n = length(buses);
    m = length(branches);
    bcbv = zeros(n, m);
    
%     disp(bcbv);
%     disp(size(bcbv));
    
    for i = 1: length(branches)
        branch_no = branches(i, 1);
        from_branch = branches(i, 2);
        to_branch = branches(i, 3);
        r_branch = branches(i, 4);
        x_branch = branches(i, 5);
        bcbv(to_branch, :) = bcbv(from_branch, :);
        bcbv(to_branch, branch_no) = r_branch + 1j * x_branch;
    end
    
%     disp(bcbv);
%     disp(size(bcbv));
    
     if(exist('loop', 'var'))
         r = n + 1;
         c = m + 1;
         
         for i = 1:length(loop)
            from_branch = branches(i, 1);
            to_branch = branches(i, 2);
            r_branch = branches(i, 3);
            x_branch = branches(i, 4);
            bcbv(r, :) = bcbv(from_branch, :) - bcbv(to_branch, :);
            bcbv(r, c) = r_branch + 1j * x_branch;
            r = r + 1;
            c = c + 1;
         end
         
%          disp(bcbv);
%          disp(size(bcbv));
     end
      disp(size(bcbv));
end