
fig = [0 35 255 198 66 172 201 91 123 155 218 192 110 122];
for a = 1:260
    for b = 1:260
        for c = 1:size(fig,2) 
            if cabcn(a,b) == fig(c)
                cabcn(a,b) = c;
            end
        end
    end
end

