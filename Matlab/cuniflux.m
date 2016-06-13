function [malha, resul] = cuniflux (malha, mt, resul, c, MFSB, ...
    MFNO, MFCON, campo)

quantflux = size(MFSB,1);
for x = 1:quantflux
    T1 = resul{MFSB(x,1)}(MFNO(x,1),c,campo);
    T2 = resul{MFSB(x,2)}(MFNO(x,2),c,campo);
    vvento = 0.5;
        peesp = 2*3481.9648*Pressao/(T1 + T2);
        kterconv = peesp*calesp(meio)*(1.888e-5 + 1.324e-7*(T1 + T2 - 546.3)/2);
        visco = 1.3291e-5 + 9e-8*(T1 + T2 - 546.3)/2;
        Pra = peesp*calesp(meio)*visco/kterconv;
        Gra = gravidade*diaanimal(meio)^3*(T1 - T2)/(T2*visco^2);
        Re = diaanimal(meio)*vvento/visco;
        
        GraRe = Gra/Re^2;
        if GraRe <= 0.08
            %forçada
            if Re < 40 && Re >= 0
                Nu = 0.75*Re^(0.4)*Pra^(0.37);
            elseif Re < 1000 && Re >= 40
                Nu = 0.51*Re^(0.5)*Pra^(0.37);
            elseif Re <= 2e5 && Re >= 1000
                Nu = 0.26*Re^(0.6)*Pra^(0.37);
            elseif Re > 2e5
                Nu = 0.076*Re^(0.7)*Pra^(0.37);
            end
        elseif GraRe > 0.08 && GraRe <= 3
            %Combinada
            if Re < 40 && Re >= 0
                Nufor = 0.75*Re^(0.4)*Pra^(0.37);
            elseif Re < 1000 && Re >= 40
                Nufor = 0.51*Re^(0.5)*Pra^(0.37);
            elseif Re <= 2e5 && Re >= 1000
                Nufor = 0.26*Re^(0.6)*Pra^(0.37);
            elseif Re > 2e5
                Nufor = 0.076*Re^(0.7)*Pra^(0.37);
            end
            Nunat = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
            
            Nu = (Nufor^3 + Nunat^3)^(1/3);

        elseif GraRe > 3
            %Natural
            Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
        end
    
    %1 - material recebendo o fluxo;
    %2 - material que é o fluxo;
    trans1 = (resul{MFSB(x,2)}(MFNO(x,2),c,campo) - ...
        resul{MFSB(x,1)}(MFNO(x,1),c,campo))*MFCON(x,1)*Nu...
        + (resul{MFSB(x,2)}(MFNO(x,2),c,campo)^4 - ...
        resul{MFSB(x,1)}(MFNO(x,1),c,campo)^4)*MFCON(x,2);
    
    trans2 = (resul{MFSB(x,1)}(MFNO(x,1),c,campo) - ...
        resul{MFSB(x,2)}(MFNO(x,2),c,campo))*MFCON(x,3)*Nu...
        + (resul{MFSB(x,1)}(MFNO(x,1),c,campo)^4 - ...
        resul{MFSB(x,2)}(MFNO(x,2),c,campo)^4)*MFCON(x,4);
    
    malha{MFSB(x,1)}{MFNO(x,1)}(mt,1) = ...
        malha{MFSB(x,1)}{MFNO(x,1)}(mt,1) + trans1;
    
    malha{MFSB(x,1)}{MFNO(x,1)}(mt,2) = ...
        malha{MFSB(x,1)}{MFNO(x,1)}(mt,2) + trans1;
    
    resul{MFSB(x,1)}(MFNO(x,1),c,campo) = ...
        resul{MFSB(x,1)}(MFNO(x,1),c,campo) + trans1;
    
    
    malha{MFSB(x,2)}{MFNO(x,2)}(mt,1) = ...
        malha{MFSB(x,2)}{MFNO(x,2)}(mt,1) + trans2;
    
    malha{MFSB(x,2)}{MFNO(x,2)}(mt,2) = ...
        malha{MFSB(x,2)}{MFNO(x,2)}(mt,2) + trans2;   
    
    resul{MFSB(x,2)}(MFNO(x,2),c,campo) = ...
        resul{MFSB(x,2)}(MFNO(x,2),c,campo) + trans2;
   
end