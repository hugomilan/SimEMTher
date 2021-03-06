%Copyright © 2010 to 2016. Hugo Fernando Maia Milan.

function [malha, resul] = advecflux (malha, mt, resul, c, ADSB, ...
    ADNO, ADCON, campo, portemter)
quantflux = size(ADSB,1);
for x = 1:quantflux

    transf = (ADCON(x,3) - ...
         resul{ADSB(x,1),ADSB(x,2)}(ADNO(x,1),ADNO(x,2),c,campo))*ADCON(x,1);%... %convecção
        + ((ADCON(x,3))^4 - ...
        resul{ADSB(x,1),ADSB(x,2)}(ADNO(x,1),ADNO(x,2),c,campo)^4)*ADCON(x,2);% %radiação
    
    
malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,1 + portemter) = ...
    malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,1 + portemter) + transf;

malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,2 + portemter) = ...
    malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,2 + portemter) + transf;

malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,3 + portemter) = ...
    malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,3 + portemter) + transf;

malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,4 + portemter) = ...
    malha{ADSB(x,1),ADSB(x,2)}{ADNO(x,1),ADNO(x,2)}(mt,4 + portemter) + transf;

resul{ADSB(x,1),ADSB(x,2)}(ADNO(x,1),ADNO(x,2),c,campo) = ...
    resul{ADSB(x,1),ADSB(x,2)}(ADNO(x,1),ADNO(x,2),c,campo) + transf;
end
