%Copyright © 2010 to 2016. Hugo Fernando Maia Milan (hugofernando@gmail.com).

function [malha, resul] = advecuniflux (malha, mt, resul, c, ADSB, ...
    ADNO, ADCON, campo)
global calesp diaanimal gravidade Pressao
quantflux = size(ADSB,1);
for x = 1:quantflux
    
    T1 = ADCON(x,3);
    T2 = ADCON(x,3)-1;
    meio = ADCON(x,4);
    
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
    
    transf = (T1 - T2)*ADCON(x,1)*Nu*5e6... %convecção
        + (T1^4 - T2^4)*ADCON(x,2)*5e6; %radiação
    
    malha{ADSB(x)}{ADNO(x)}(mt,1) = malha{ADSB(x)}{ADNO(x)}(mt,1) + transf;
    malha{ADSB(x)}{ADNO(x)}(mt,2) = malha{ADSB(x)}{ADNO(x)}(mt,2) + transf;
    resul{ADSB(x)}(ADNO(x),c,campo) = resul{ADSB(x)}(ADNO(x),c,campo) + transf;
    
    
end
