function [resul] = cunires(nsdx, nnosx, Tx, nkres)
global quantcampo saltosimu
nkres = floor(nkres/saltosimu);

b = 1;
resul{b} = zeros(nnosx,nkres,quantcampo);

b = nsdx;
resul{b} = zeros(Tx-nnosx*(nsdx-1),nkres,quantcampo);

for b = 2:(nsdx-1)
    
    resul{b} = zeros(nnosx, nkres, quantcampo);
    

end

end