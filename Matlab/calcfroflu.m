function [malha, resul] = calcfroflu (malha, resul, mt, FSBF, FNOF, FCOF, c, ...
    porttemp, portemter)

quantflux = size(FSBF,1);
if FSBF(1,1) ~= 0
    for vf = 1:quantflux
        
        transf = FCOF(vf,3)*(FCOF(vf,1) - resul{FSBF(vf,1),FSBF(vf,2)}(FNOF(vf,3),FNOF(vf,4),c, porttemp)) ...
            + FCOF(vf,4)*(FCOF(vf,1)^4 - resul{FSBF(vf,1),FSBF(vf,2)}(FNOF(vf,3),FNOF(vf,4),c ,porttemp)^4);
        
        
        malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,1 + portemter) = ...
            malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,1 + portemter) + transf;
        
        malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,2 + portemter) = ...
            malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,2 + portemter) + transf;
        
        malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,3 + portemter) = ...
            malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,3 + portemter) + transf;
        
        malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,4 + portemter) = ...
            malha{FSBF(vf,1),FSBF(vf,2)}{FNOF(vf,3),FNOF(vf,4)}(mt,4 + portemter) + transf;
        
        resul{FSBF(vf,1),FSBF(vf,2)}(FNOF(vf,3),FNOF(vf,4),c,porttemp) = ...
            resul{FSBF(vf,1),FSBF(vf,2)}(FNOF(vf,3),FNOF(vf,4),c,porttemp) + transf;


    end
end