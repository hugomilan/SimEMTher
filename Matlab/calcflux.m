function [malha, resul] = calcflux (malha, mt, resul, c, MFSB, ...
    MFNO, MFCON, porttemp, portemter)

quantflux = size(MFSB,1);
if MFSB(1,1) ~= 0
    for x = 1:quantflux
        
%         MFNO(x,1)
        trans1 = (resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp) - ...
            resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp))*MFCON(x,1)...
            + (resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp)^4 - ...
            resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp)^4)*MFCON(x,2);
        
        trans2 = (resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp) - ...
            resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp))*MFCON(x,3)...
            + (resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp)^4 - ...
            resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp)^4)*MFCON(x,4);
        
        malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,1 + portemter) = ...
            malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,1 + portemter) + trans1;
        
        malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,2) = ...
            malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,2 + portemter) + trans1;
        
        malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,3) = ...
            malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,3 + portemter) + trans1;
        
        malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,4) = ...
            malha{MFSB(x,1),MFSB(x,2)}{MFNO(x,1),MFNO(x,2)}(mt,4 + portemter) + trans1;
        
        resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp) = ...
            resul{MFSB(x,1),MFSB(x,2)}(MFNO(x,1),MFNO(x,2),c,porttemp) + trans1;
        
        
        malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,1 + portemter) = ...
            malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,1 + portemter) + trans2;
        
        malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,2) = ...
            malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,2 + portemter) + trans2;
        
        malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,3) = ...
            malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,3 + portemter) + trans2;
        
        malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,4) = ...
            malha{MFSB(x,3),MFSB(x,4)}{MFNO(x,3),MFNO(x,4)}(mt,4 + portemter) + trans2;
        
        resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp) = ...
            resul{MFSB(x,3),MFSB(x,4)}(MFNO(x,3),MFNO(x,4),c,porttemp) + trans2;
    end
end