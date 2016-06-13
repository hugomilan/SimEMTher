function [malha, resul] = cunifroflu( malha, resul, mt, FSBF, FNOF, FCOF, c, campo)
global gravidade Pressao VV TRM
aa = size(FSBF,1);
for vf = 1:aa
    
    %Esquerdo
    if FSBF(vf,1) == 1
        
%         T1 = resul{FSBF(vf,2)}(FNOF(vf,2),c,campo);
%         T2 = FCOF(vf,1);
%         peesp = 3481.9648*Pressao/(T1 + T2)*2; %g/m3
%         calesp = 1.0052 + 0.0004577*exp((T1 + T2 - 546.30)/(2*32.07733)); %J/(gºC)
%         kterconv = peesp*calesp*(1.888e-5 + 1.324e-7*(T1 + T2 - 546.30)/2);
%         visco = 1.3291e-5 + 9e-8*(T1 + T2 - 546.30)/2;
%         Pra = peesp*calesp*visco/kterconv;
%         Gra = gravidade*FCOF(vf,2)^3*(T1 - T2)/(T2*visco^2);
%         Re = FCOF(vf,2)*VV/visco;
%         
%         GraRe = Gra/Re^2;
%         
%         if GraRe <= 0.08
%             %forçada
%             if FCOF(vf,5) == 1 %cil. hor. para.
%                 Nu = 0.0296*Re^(4/5)*Pra^(1/3);
%             elseif FCOF(vf,5) == 2 %cil. hor. perp.
%                 Nu = 0.3 + 0.62*Re^(1/2)*Pra^(1/3)/(1 + (0.4/Pra)^(2/3))^(1/4)*...
%                     (1 + (Re/282000)^(5/8))^(4/5);
%             else
%                 Nu = 0;
%                
%             end
%         elseif GraRe > 0.08 && GraRe <= 3
%             %Combinada
%             if FCOF(vf,5) == 1 %cil. hor. para.
%                 Nufor = 0.0296*Re^(4/5)*Pra^(1/3);
%             elseif FCOF(vf,5) == 2 %cil. hor. perp.
%                 Nufor = 0.3 + 0.62*Re^(1/2)*Pra^(1/3)/(1 + (0.4/Pra)^(2/3))^(1/4)*...
%                     (1 + (Re/282000)^(5/8))^(4/5);
%             end
%             Nunat = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
%             
%             Nu = (Nufor^(3.5) + Nunat^(3.5))^(1/(3.5));
% 
%         elseif GraRe > 3
%             %Natural
%             Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
%             
%         else
%             
%             Nu = 0;
%         end
%         
%         transf = FCOF(vf,3)*kterconv*Nu*(FCOF(vf,1) - resul{FSBF(vf,2)}(FNOF(vf,2),c,campo)) ... %convecção
%             + FCOF(vf,4)*(FCOF(vf,1)^4 - resul{FSBF(vf,2)}(FNOF(vf,2),c,campo)^4); %radiação
% 
%         malha{1}{1}(mt,1) = malha{1}{1}(mt,1) + transf;
%         malha{1}{1}(mt,2) = malha{1}{1}(mt,2) + transf;
%         resul{1}(1,c,1) = resul{1}(1,c,campo) + transf;
        %Direito
    elseif FSBF(vf,1) == 2
        
        T1 = resul{end}(end,c,campo);
        T2 = FCOF(vf,1);
        
        peesp = 3481.9648*Pressao/((T1 + T2)/2+273.15); %g/m3 - oC
        
%         peesp = 3481.9648*Pressao/((T1 + T2)/2+273.15); %g/m3 - oC
%         peesp = 3481.9648*Pressao/((T1 + T2)/2); %g/m3 - K

        calesp = 1.0052 + 0.0004577*exp((T1 + T2)/(2*32.07733)); %J/(gºC) - oC
        
%         calesp = 1.0052 + 0.0004577*exp((T1 + T2)/(2*32.07733)); %J/(gºC) - oC
%         calesp = 1.0052 + 0.0004577*exp((T1 + T2 - 546.30)/(2*32.07733)); %J/(gºC) - K

        kterconv = peesp*calesp*(1.888e-5 + 1.324e-7*(T1 + T2)/2); % oC
        
        
%         kterconv = peesp*calesp*(1.888e-5 + 1.324e-7*(T1 + T2)/2); % oC
%         kterconv = peesp*calesp*(1.888e-5 + 1.324e-7*(T1 + T2 - 546.30)/2); % K

        visco = 1.3291e-5 + 9e-8*(T1 + T2)/2; % oC
        
%         visco = 1.3291e-5 + 9e-8*(T1 + T2)/2; % oC
%         visco = 1.3291e-5 + 9e-8*(T1 + T2 - 546.30)/2; % K
        Pra = peesp*calesp*visco/kterconv;
        
        Gra = gravidade*FCOF(vf,2)^3*(T1 - T2)/((T2+273.15)*visco^2); % oC
        
%         Gra = gravidade*FCOF(vf,2)^3*(T1 - T2)/((T2+273.15)*visco^2); % oC
%         Gra = gravidade*FCOF(vf,2)^3*(T1 - T2)/(T2*visco^2); % K
        Re = FCOF(vf,2)*VV/visco;
        
        GraRe = Gra/Re^2;

        if GraRe <= 0.08
            %forçada
            if FCOF(vf,5) == 1 %cil. hor. para.
                Nu = 0.0296*Re^(4/5)*Pra^(1/3);
            elseif FCOF(vf,5) == 2 %cil. hor. perp.
                Nu = 0.3 + 0.62*Re^(1/2)*Pra^(1/3)/(1 + (0.4/Pra)^(2/3))^(1/4)*...
                    (1 + (Re/282000)^(5/8))^(4/5);
            else
                Nu = 0;
            end
        elseif GraRe > 0.08 && GraRe <= 3
            %Combinada
            if FCOF(vf,5) == 1 %cil. hor. para.
                Nufor = 0.0296*Re^(4/5)*Pra^(1/3);
            elseif FCOF(vf,5) == 2 %cil. hor. perp.
                Nufor = 0.3 + 0.62*Re^(1/2)*Pra^(1/3)/(1 + (0.4/Pra)^(2/3))^(1/4)*...
                    (1 + (Re/282000)^(5/8))^(4/5);
            end
            Nunat = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
            
            Nu = (Nufor^(3.5) + Nunat^(3.5))^(1/(3.5));

        elseif GraRe > 3
            %Natural
            Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
        end
%         TRM = 32.6195; kterconv = 0.024618; Nu = 18.6779;% parametros alex
%         To = 29.7285; h = 9.9443;
%           transf = (FCOF(vf,3)*9.9443)*(29.7285 - T1);

          %           transf = (FCOF(vf,3)*9.9443)*(29.7285 - resul{end}(end,c,campo));
        transf = (FCOF(vf,3)*kterconv*Nu)*(FCOF(vf,1) - T1) ... %convecção
            + FCOF(vf,4)*((TRM+273.15)^4 - (T1+273.15)^4); %radiação - oC
   
%         + FCOF(vf,4)*((TRM+273.15)^4 - (resul{end}(end,c,campo)+273.15)^4); %radiação - oC
%         + FCOF(vf,4)*(TRM^4 - resul{end}(end,c,campo)^4); %radiação - K
        
        % parâmetros do alex: 36.6614; meus parâmetros: 36.6707;
%         medida: 35.63; TRM = Ta = 35.1768;  TRM = TG = 36.0886;
%         TRM = (TG+Ta)/2 (26.985) = 35.6273; Analitico = 35.92
%         Utilizando Z/(ZG +2) (inserção de W/m3) = 36.4720; VV = 0 = 36.0819
%         Resultado Anterior: 36.08. Utilizando Kelvin = 36.6707
%         VV = 0 = 36.5287; VV = 5 = 35.41; VV = 1 = 36.29;
%         dt = 0.05 = 36.5287; dt = 0.005 = 36.5287;
%         Usando To e h: 36.6589; Resultado da saida: 36.1204
%         Malha utilizando a 1 camada de pg com dx = 0.25 mm: 36.5287
%         Usando o Rb (Amri et al 2012) = 1/h = 36.6594
%         sem diferenca significativa no Xu_II_01 usando 2*malha{end}{end}(mt,2)
%         mas encontrei 36.0821
        
%         malha{end}{end}(mt,1) = malha{end}{end}(mt,1) + transf;
%         malha{end}{end}(mt,2) = malha{end}{end}(mt,2) + transf*1.45; %muito próximo do real
        malha{end}{end}(mt,2) = malha{end}{end}(mt,2) + transf;
%         malha{end}{end}(mt,2) = -0.999939665748245*malha{end}{end}(mt,2) + 29.7276031765984;
%         malha{end}{end}(mt,2) = 0.715650882201981*malha{end}{end}(mt,2) + 4.22663637422921;
%         resul{end}(end,c,1) = resul{end}(end,c,campo) + transf;
        
    end
end