function bool= check_bcbv(bcbv)
bool=0;
for i=2 : length(bcbv)
    if(bcbv(i,1)==-1 && (i~=1))
        bool=1;
        break;
    end
end
end