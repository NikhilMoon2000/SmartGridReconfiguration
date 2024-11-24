function [Vk, ploss] = load_flow(branches, buses, loop)
    Vs = 12660;
    error_tolerance = 1e-08;
    % Initialising DLF Matrix
    %dlf = zeros(33,33);
    if(exist('loop', 'var'))
        dlf = g_dlf(branches, buses, loop);
    else
        dlf = g_dlf(branches, buses);
    end
%     dlf = g_dlf(branches, buses);

    % Kth iteration's Node Voltages (Initialising for k = 0)
    Vk = zeros(length(buses), 1) + Vs;

    % Initialising Iteration Counter
    k = 1;

    % Running Iterations
    
    while(1)
         tmp=zeros(1,length(buses));
         
        for i = 1:length(buses)
            P = buses(i, 2)*1000;
            Q = buses(i, 3)*1000;
            tmp(1,i) = ((P + 1j * Q)  / Vk(i));
        end
         
       

        % Calculating the conjugate of Matrix I
        I = conj(tmp);

        % Transposing Matrix I
        I = transpose(I);
        
        
        %I(1, :) = [];
        
        % Calculating delV Matrix
        delV = dlf * I;

        % Calculating Vkth Matrix
        X = Vs - delV;

        % Calculating Error in Voltage
        E = abs(X - Vk);

        % Checking maximum error with the allowed tolerance value
        if(max(E) < error_tolerance)
            break;
        end
        if(k==500)
            disp(['forced  return ']);
            break;
        end

        % Updating the Vkth Matrix
        Vk = X;

        % Incrementing the iteration count
        k = k + 1;
    end
    

%     fprintf("\nReached Optimal Solution after %i iterations\n\n", k);
%     fprintf("------------------ Results ---------------- \n\n");
%     fprintf("Bus No.\t\tMagnitude (PU)\t\tPhase Angle (Degree) \n")
% 
%     for i = 1:length(Vk)
%         real_part = real(Vk(i));
%         img_part = imag(Vk(i));
%         %fprintf("Real Part = %i, Imag. Part = %i\n", real_part, img_part);
%         magnitude = abs(Vk(i)) / Vs;
%         theta = atan2(img_part, real_part) * (180 / pi);
%         fprintf("%d\t\t\t%f\t\t\t%f\n", i,magnitude * Vs / 1000, theta);
%     end

    ploss = 0;
    for i = 1:length(branches)
        from_branch = branches(i, 2);
        to_branch = branches(i, 3);
        Zb = branches(i, 4) + 1j * branches(i, 5);
        Ift = ( Vk(from_branch)-Vk(to_branch)) / (Zb);
        Itf = ( Vk(to_branch)-Vk(from_branch)  ) / (Zb);

        Sft = Vk(from_branch) * conj(Ift);
        Stf = Vk(to_branch) * conj(Itf);

        ploss = ploss + (Sft + Stf);
    end
if(exist('loop', 'var'))
    for i = 1:length(loop)
        from_branch = loop(i, 1);
        to_branch = loop(i, 2);
        Zb = loop(i, 3) + 1j * loop(i, 4);
        Ift = ( Vk(to_branch)-Vk(from_branch)) / (Zb);
        Itf = ( Vk(from_branch)-Vk(to_branch) ) / (Zb);
        
        Sft = Vk(from_branch) * conj(Ift);
        Stf = Vk(to_branch) * conj(Itf);
        
        ploss = ploss -(Sft + Stf);
    end
    
 end

    ploss = ploss / 1000;

 %   disp("Power Loss (kW) :");
  %  disp(abs(ploss));
end