function boo=check_bibc(bibc)
    boo=0;
    for i=2 : length(bibc)
        if(bibc(1,i)==-1 && (i~=1))
            boo=1;
            break;
        end
    end
end