function dlf = g_dlf(branches, buses, loop)
    
  %  bibc = zeros(0);
   % bcbv = zeros(0);
    %dlf = zeros(0);
    
    n = length(buses);
    %m = length(branches);
    
    if(exist('loop', 'var'))
%         disp('NON RADIAL');
        %l = length(loop);
        bibc = my_bibc(branches, buses, loop);
        bcbv = my_bcbv(branches, buses, loop);
        
        x = mtimes(bcbv,bibc);
        % disp(size(x));
        % disp(x);
        %disp("gu");
        [row,col]=size(x);
       
       
        
        A = x(1 : n, 1 : n);
        B = x(1 : n, n + 1:col);
        C = x(n + 1:row, 1 : n);
        D = x(n + 1:row, n + 1:col);
        
        dlf = A - B *(D\C) ;
        
       % dlf = padarray(dlf, [1 1], 0, 'pre');
    else
%         disp('RADIAL');
       % bibc = g_bibc(branches, buses);
        %bibc1=bibc;
        bibc=my_bibc(branches,buses);
        
     % bcbv = g_bcbv(branches, buses);
%        bcbv1=bcbv;
        bcbv=my_bcbv(branches,buses);
        
        dlf = mtimes(bcbv,bibc);
    end
    
%     disp(dlf);
end