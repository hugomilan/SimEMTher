function [resul] = criares(nsdy, nsdx, nnosy, nnosx, Ty, Tx, nkres)
resul = cell(nsdy,nsdx); %Variavel que irá conter os resul1tados
global quantcampo saltosimu
nkres = floor(nkres/saltosimu);

for b = 1:nsdx
    for a = 1:nsdy
        if a == nsdy && b == nsdx
            
            resul{a,b} = zeros(Ty-nnosy*(nsdy-1), Tx-nnosx*(nsdx-1), nkres, quantcampo);
            
        elseif b == nsdx
            
            resul{a,b} = zeros(nnosy, Tx-nnosx*(nsdx-1), nkres, quantcampo);
            
        elseif a == nsdy
            
            resul{a,b} = zeros(Ty-nnosy*(nsdy-1), nnosx, nkres, quantcampo);
            
        else
            
            resul{a,b} = zeros(nnosy, nnosx, nkres, quantcampo);
            
        end
    end
end

end