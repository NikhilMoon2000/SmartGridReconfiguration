function bibc = g_bibc(branches, buses, loop)
    n = length(buses);
    m =length(branches);
    
    bibc = zeros(m, n);
    
%     disp(bibc); 
%     disp(size(bibc));
    
    for i = 1: length(branches)
        branch_no = branches(i, 1);
        from_branch = branches(i, 2);
        to_branch = branches(i, 3);
        bibc(:, to_branch) = bibc(:, from_branch);
        bibc(branch_no, to_branch) = 1;
    end
    
    
%     disp(bibc);
%     disp(size(bibc));
    
    if(exist('loop', 'var'))
        branch_no = length(branches) + 1;
        c= n + 1;
        for i = 1: length(loop)
            from_branch = loop(i, 1);
            to_branch = loop(i, 2);
            bibc(:,c) = bibc(:, from_branch) - bibc(:, to_branch);
            bibc(branch_no, c) = 1;
            branch_no = branch_no + 1;
            c = c + 1;                         
        end

%         disp(bibc);
%         disp(size(bibc));
    end
   %%disp(size(bibc));
end