function [nnosy, nnosx, S, Ty, Tx, SARval, fonemter, foninter, ...
    Ster, Zter, Rter, Gter, Zterx, Ztery, Z2c, Rterx, Rtery, Zfatx, Zfaty, ...
    IF, fatex, fatey, fathzx, fathzy, Zc, ZLTx, ZLTy, Gx, Gy, Zs, Rs, ...
    Tempinmatriz, reflintn, rfemag, YLTx, YLTy, Yc, Ys, ...
    Gs, Ysf, YLTxf, YLTyf, MFSB, MFNO, MFCON, ZG2n] = ...
    prepro(ent, dl, e, u, sigma, ro, fig, nsdy, nsdx, camposimu, calesp,...
    Kter, wsan, qmsan, emis, Tempin, dtTLM, simu, TE, TM)

global rosan cpsan valflux tsan dimenmalha gravidade Latitude Altitude ...
    Pressao Ta Dgn Tgn VV TRM ktergn

[Ty Tx] = size(ent); %Tamanho da malha

%% implementação da diakopticas
nnosy = ceil(Ty/nsdy); %nº de nós y em um subdomínio
nnosx = ceil(Tx/nsdx); %nº de nós x em um subdomínio

csb = 5.6697e-8;           %Constante de Steffan-Boltzman

%% Cálculos Pré-Processamentao
%formulas pós dados iniciais

gravidade = 9.78013 + 8.18e-5*Latitude + 1.168e-5*Latitude^2 - 3.1e-6*Altitude; %m/s2

Pressao = 101.325*exp(-gravidade*Altitude/(287*(Ta+273.15))); % oC

% Pressao = 101.325*exp(-gravidade*Altitude/(287*(Ta+273.15))); % oC
% Pressao = 101.325*exp(-gravidade*Altitude/(287*Ta)); % K

% Ajustando os parâmetros para simulação térmica
if (~rem(camposimu,13))
    emgn = 0.95;
    
    rogn = 3481.9648*Pressao/(Ta+273.15); % g/m3 - oC
    
%     rogn = 3481.9648*Pressao/(Ta+273.15); % g/m3 - oC
%     rogn = 3481.9648*Pressao/Ta; % g/m3 - K

    cegn = 1.0052 + 0.0004577*exp(Ta/32.07733); %J/(g.ºC) - oC
    
%     cegn = 1.0052 + 0.0004577*exp(Ta/32.07733); %J/(g.ºC) - oC
%     cegn = 1.0052 + 0.0004577*exp((Ta-273.15)/32.07733); %J/(g.ºC) - K

    ktergn = rogn*cegn*(1.888e-5 + 1.324e-7*Ta); %W/(m.ºC) - oC
    
%     ktergn = rogn*cegn*(1.888e-5 + 1.324e-7*Ta); %W/(m.ºC) - oC
%     ktergn = rogn*cegn*(1.888e-5 + 1.324e-7*(Ta-273.15)); %W/(m.ºC) - K

    VCgn = 1.3291e-5 + 9e-8*Ta; % oC
    
%     VCgn = 1.3291e-5 + 9e-8*Ta; % oC
%     VCgn = 1.3291e-5 + 9e-8*(Ta-273.15); % K

    PRgl = rogn*cegn*VCgn/ktergn;
    
    GRgl = gravidade*Dgn^3*(Tgn - Ta)/(VCgn^2*(Ta+273.15)); % oC
    
%     GRgl = gravidade*Dgn^3*(Tgn - Ta)/(VCgn^2*(Ta+273.15)); % oC
%     GRgl = gravidade*Dgn^3*(Tgn - Ta)/(VCgn^2*Ta); % K

    REgl = VV*Dgn/VCgn;
    GRREgl = GRgl/REgl^2;
    if GRREgl <= 0.08
        %forçada
        if REgl <= 100
            Nu = 2 + 0.605*REgl^(0.5)*PRgl^(0.37);
        elseif REgl > 100
            Nu = 0.38*REgl^(0.6)*PRgl^(0.33);
        end
    elseif GRREgl > 0.08 && GRREgl <= 3
        %Combinada
        if REgl <= 100
            Nufor = 2 + 0.605*REgl^(0.5)*PRgl^(0.37);
        elseif REgl > 100
            Nufor = 0.38*REgl^(0.6)*PRgl^(0.33);
            
        end
        Nunat = 2 + 0.43*GRgl^(0.25)*PRgl^(0.25);
        
        Nu = (Nufor^4 + Nunat^4)^(1/4);
        
    elseif GRREgl > 3
        %Natural
        Nu = 2 + 0.43*GRgl^(0.25)*PRgl^(0.25);
    end
        HCG = ktergn*Nu/Dgn;
        
        TRM = ((HCG*(Tgn - Ta) + emgn*csb*(Tgn+273.15)^4)/(emgn*csb))^(1/4) - 273.15; % oC
        
%         TRM = ((HCG*(Tgn - Ta) + emgn*csb*(Tgn+273.15)^4)/(emgn*csb))^(1/4) - 273.15; % oC
%         TRM = ((HCG*(Tgn - Ta) + emgn*csb*Tgn^4)/(emgn*csb))^(1/4); % K
        
    if dimenmalha == 1
        dl = dl*[50 25 5 1];

%         dl = dl*[2 1 1];
        Zter = dtTLM./(ro.*calesp.*dl);    % Impedância da Linha
        Rter = dl./(2*Kter);              % Resistência do modelo
        %É R, entretanto, coloca-se R/2 para não precisar modificar todo o programa
        Gter = wsan.*cpsan*rosan.*dl;      % Condutância do modelo
        IF = (qmsan + wsan.*cpsan*rosan*tsan).*dl;
        
        %Temperatura inicial na malha
        Tempinmatriz = (Tempin.*(2 - Zter.*Gter) + Zter.*IF)./4;
        
        foninter = IF.*Zter./(Zter.*Gter + 2);     %Gerações de calor interna
        
        Ster = cell(1,size(fig,2));                 % Matriz de espalhamento
        fonemter = sigma.*dl.*Zter./(Zter.*Gter + 2); % Ligação entre a excitação EM para fonte térmica (SAR)
        ZG2n = 2./(Zter.*Gter + 2);              % Multiplica para encontrar o valor de T
        
        Ater = -(Zter.*Gter)./(Zter.*Gter + 2);
        Bter = 2./(Zter.*Gter + 2);
        
        
        
        for aa = 1:size(fig,2)
            Ster{1,aa} = [Ater(aa) Bter(aa); ...
                          Bter(aa) Ater(aa)];
        end
        
        
        
        %preparando reflint
        %1 - Esquerda
        %2 - Direita
        reflintn = cell(1,Tx);
        rb = 1;
        reflintn{rb} = zeros(2,2);
        reflintn{rb}(1,:) = [0 1];
        reflintn{rb}(2,:) = [rcrefbheuni(ent,rb,Zter,Rter,2) tcrefbheuni(ent,rb,Zter,Rter,2)];
        
        rb = Tx;
        reflintn{rb} = zeros(2,2);
        reflintn{rb}(1,:) = [rcrefbheuni(ent,rb,Zter,Rter,1) tcrefbheuni(ent,rb,Zter,Rter,1)];
        reflintn{rb}(2,:) = [0 1];
        
        
        for rb = 2:(Tx-1)
            reflintn{rb} = zeros(2,2);
            reflintn{rb}(1,:) = [rcrefbheuni(ent,rb,Zter,Rter,1) tcrefbheuni(ent,rb,Zter,Rter,1)];
            reflintn{rb}(2,:) = [rcrefbheuni(ent,rb,Zter,Rter,2) tcrefbheuni(ent,rb,Zter,Rter,2)];
        end
        
        
        MFSB = zeros(1,2);   % Posição no subdomínio dos meios
        MFNO = zeros(1,2);   % Posição dos nós dos meios
        MFCON = zeros(1,2);  % Constantes para conveccção (1,3) e radiação (2,4)
        ax = 1;
        for a = 2:size(valflux,1)
            %3 - material fluxo; 2 - material que recebe o fluxo
            %os 1 referem-se ao material que está recebendo o fluxo
            %e o 2 ao fluxo
            %o valflux(a,3) é o fluxo e o valflux(a,2) o material
            if valflux(a,4) == 2 && valflux(a,1) ~=0 %Fluxo de material a esquerda
                for x = 2:(Tx-1)
                    if valflux(a,2) == ent(1,x) && valflux(a,3) == ent(1,x-1)
                        MFSB(ax,:) = [ceil(x/nnosx)  ceil((x-1)/nnosx)];
                        MFNO(ax,:) = [(x - (MFSB(ax,1)-1)*nnosx) (x-1 - (MFSB(ax,2)-1)*nnosx)];
                        if valflux(a,1) == 1 || valflux(a,1) == 3
                            peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                            
                            MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,2))...
                                *Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);

                        end
                        if valflux(a,1) == 2 || valflux(a,1) == 3
                            MFCON(ax,2) = emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                emis(valflux(a,2))*emis(valflux(a,3)))...
                                *Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        end
                        MFCON(ax,3) = MFCON(ax,1)*Zter(valflux(a,3))/(Zter(valflux(a,3))*Gter(valflux(a,3)) + 2)...
                            /Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        
                        MFCON(ax,4) = MFCON(ax,2)*Zter(valflux(a,3))/(Zter(valflux(a,3))*Gter(valflux(a,3)) + 2)...
                            /Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        ax = ax+1;
                    end
                end
                
                
            elseif valflux(a,4) == 4 && valflux(a,1) ~=0 %Fluxo de material a direita
                for x = 2:(Tx-1)
                    if valflux(a,2) == ent(1,x) && valflux(a,3) == ent(1,x+1)
                        MFSB(ax,:) = [ceil(x/nnosx) ceil((x+1)/nnosx)];
                        MFNO(ax,:) = [(x - (MFSB(ax,1)-1)*nnosx) (x+1 - (MFSB(ax,2)-1)*nnosx)];
                        if valflux(a,1) == 1 || valflux(a,1) == 3
                            peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                            MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,2))...
                                *Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                            
                        end
                        if valflux(a,1) == 2 || valflux(a,1) == 3
                            MFCON(ax,2) = emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                emis(valflux(a,2))*emis(valflux(a,3)))...
                                *Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        end
                        MFCON(ax,3) = MFCON(ax,1)*Zter(valflux(a,3))/(Zter(valflux(a,3))*Gter(valflux(a,3)) + 2)...
                            /Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        
                        MFCON(ax,4) = MFCON(ax,2)*Zter(valflux(a,3))/(Zter(valflux(a,3))*Gter(valflux(a,3)) + 2)...
                            /Zter(valflux(a,2))/(Zter(valflux(a,2))*Gter(valflux(a,2)) + 2);
                        
                        ax = ax+1;
                    end
                end
            end
        end
        
        %variavies para duas dimensões não utilizadas
        Zterx = 0;
        Ztery = 0;
        Rterx = 0;
        Rtery = 0;
        Zfatx = 0;
        Zfaty = 0;
        Z2c = 0;
    elseif dimenmalha == 2
        
        Zterx = 4*dtTLM./(ro.*calesp*dl);    % Impedância da Linha
        Ztery = 4*dtTLM./(ro.*calesp*dl);    % Impedância da Linha
        Rterx = dl./(2*Kter);              % Resistência do modelo
        Rtery = dl./(2*Kter);              % Resistência do modelo
        Gter = wsan.*cpsan*rosan*dl;      % Condutância do modelo
        IF = (qmsan + wsan.*cpsan*rosan*tsan)*dl;       %Fonte de energia
        Z2c = Zterx + Ztery + Gter/2.*Zterx.*Ztery;
        Zfatx = Zterx./Z2c;
        Zfaty = Ztery./Z2c;
        %Temperatura inicial na malha
        Tempinmatriz = (Tempin.*(2*Z2c - 2.*Gter.*Zterx.*Ztery) + Zterx.*Ztery.*IF)./(4*Zterx + 4*Ztery);
        
        foninter = IF.*Zterx.*Ztery./(2*Z2c);     %Gerações de calor interna
        
        Ster = cell(1,size(fig,2));                 % Matriz de espalhamento
        fonemter = sigma*dl.*Zterx.*Ztery./(2*Z2c);                         % Ligação entre a excitação EM para fonte térmica (SAR)
        
        
        for aa = 1:size(fig,2)
            Ster{1,aa} = 1/Z2c(aa)*...
                [(Zterx(aa) - Z2c(aa))      Ztery(aa)            Zterx(aa)                 Ztery(aa);...
                Zterx(aa)      (Ztery(aa) - Z2c(aa))       Zterx(aa)                 Ztery(aa);...
                Zterx(aa)             Ztery(aa)       (Zterx(aa) - Z2c(aa))          Ztery(aa);...
                Zterx(aa)             Ztery(aa)            Zterx(aa)          (Ztery(aa) - Z2c(aa))];
            
        end
        
        %preparando reflint
        reflintn = cell(Ty,Tx);
        for ra = 1:Ty
            for rb = 1:Tx
                reflintn{ra,rb} = zeros(4,2);
                if ra == 1 && rb == 1 %primeira linha primeira coluna
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [0 1]; % 0 - Para evitar a influência da tensão refletida no resultado
                    reflintn{ra,rb}(3,:) = [0 1]; % 1 - Porque o resultado vem de uma manipulação algébrica
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                    
                elseif ra == 1 && rb == Tx %primeira linha ultima coluna
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [0 1];
                    reflintn{ra,rb}(4,:) = [0 1];
                    
                elseif ra == 1 %primeira linha
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [0 1];
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                    
                elseif ra == Ty && rb == 1 %ultima linha primeira coluna
                    reflintn{ra,rb}(1,:) = [0 1];
                    reflintn{ra,rb}(2,:) = [0 1];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                    
                elseif ra == Ty && rb == Tx %ultima linha ultima coluna
                    reflintn{ra,rb}(1,:) = [0 1];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [0 1];
                    
                elseif ra == Ty %ultima linha
                    reflintn{ra,rb}(1,:) = [0 1];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                    
                elseif rb == 1 %primeira coluna
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [0 1];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                    
                elseif rb == Tx %ultima coluna
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [0 1];
                    
                else %qualquer outro no
                    reflintn{ra,rb}(1,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,1)];
                    reflintn{ra,rb}(2,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,2)];
                    reflintn{ra,rb}(3,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,3)];
                    reflintn{ra,rb}(4,:) = [rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4) tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,4)];
                end
            end
        end
        
        
        % Ajustando os fluxos de calor
        
        MFSB = zeros(1,4);   % Posição no subdomínio dos meios
        MFNO = zeros(1,4);   % Posição dos nós dos meios
        MFCON = zeros(1,4);  % Constantes para conveccção (1,3) e radiação (2,4)
        ax = 1;
        
        
        for a = 2:size(valflux,1)
            
            if valflux(a,4) == 1 && valflux(a,1) ~=0
                for x = 2:(Tx-1)
                    for y = 2:(Ty-1)
                        if valflux(a,2) == ent(y,x) && valflux(a,3) == ent(y+1,x)
                            MFSB(ax,:) = [ceil(y/nnosy) ceil(x/nnosx) ceil((y+1)/nnosy) ceil(x/nnosx)];
                            MFNO(ax,:) = [(y - (MFSB(ax,1)-1)*nnosy) (x - (MFSB(ax,2)-1)*nnosx) (y+1 - (MFSB(ax,3)-1)*nnosy) (x - (MFSB(ax,4)-1)*nnosx)];
                            if valflux(a,1) == 1 || valflux(a,1) == 3
                                peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                                MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,3))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));

                            end
                            if valflux(a,1) == 2 || valflux(a,1) == 3
                                MFCON(ax,2) = emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                    (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                    emis(valflux(a,2))*emis(valflux(a,3)))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            MFCON(ax,3) = MFCON(ax,1)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                        
                            MFCON(ax,4) = MFCON(ax,2)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            ax = ax+1;
                        end
                    end
                end
                
            elseif valflux(a,4) == 2 && valflux(a,1) ~=0
                for x = 2:(Tx-1)
                    for y = 2:(Ty-1)
                        if valflux(a,2) == ent(y,x) && valflux(a,3) == ent(y,x-1)
                            MFSB(ax,:) = [ceil(y/nnosy) ceil(x/nnosx) ceil(y/nnosy) ceil((x-1)/nnosx)];
                            MFNO(ax,:) = [(y - (MFSB(ax,1)-1)*nnosy) (x - (MFSB(ax,2)-1)*nnosx) (y - (MFSB(ax,3)-1)*nnosy) (x-1 - (MFSB(ax,4)-1)*nnosx)];
                            if valflux(a,1) == 1 || valflux(a,1) == 3
                                
                                peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                                MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,3))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            if valflux(a,1) == 2 || valflux(a,1) == 3
                                MFCON(ax,2) = emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                    (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                    emis(valflux(a,2))*emis(valflux(a,3)))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            MFCON(ax,3) = MFCON(ax,1)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                        
                            MFCON(ax,4) = MFCON(ax,2)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            ax = ax+1;
                        end
                    end
                end
                
            elseif valflux(a,4) == 3 && valflux(a,1) ~=0
                for x = 2:(Tx-1)
                    for y = 2:(Ty-1)
                        if valflux(a,2) == ent(y,x) && valflux(a,3) == ent(y-1,x)
                            MFSB(ax,:) = [ceil(y/nnosy) ceil(x/nnosx) ceil((y-1)/nnosy) ceil(x/nnosx)];
                            MFNO(ax,:) = [(y - (MFSB(ax,1)-1)*nnosy) (x - (MFSB(ax,2)-1)*nnosx) (y-1 - (MFSB(ax,3)-1)*nnosy) (x - (MFSB(ax,4)-1)*nnosx)];
                            if valflux(a,1) == 1 || valflux(a,1) == 3
                                peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                                MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,3))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            if valflux(a,1) == 2 || valflux(a,1) == 3
                                MFCON(ax,2) = emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                    (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                    emis(valflux(a,2))*emis(valflux(a,3)))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            MFCON(ax,3) = MFCON(ax,1)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                        
                            MFCON(ax,4) = MFCON(ax,2)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            ax = ax+1;
                        end
                    end
                end
                
            elseif valflux(a,4) == 4 && valflux(a,1) ~=0
                for x = 2:(Tx-1)
                    for y = 2:(Ty-1)
                        if valflux(a,2) == ent(y,x) && valflux(a,3) == ent(y,x+1)
                            MFSB(ax,:) = [ceil(y/nnosy) ceil(x/nnosx) ceil(y/nnosy) ceil((x+1)/nnosx)];
                            MFNO(ax,:) = [(y - (MFSB(ax,1)-1)*nnosy) (x - (MFSB(ax,2)-1)*nnosx) (y - (MFSB(ax,3)-1)*nnosy) (x+1 - (MFSB(ax,4)-1)*nnosx)];
                            if valflux(a,1) == 1 || valflux(a,1) == 3
                                peesp = 2*3481.9648*Pressao/(Tempin(valflux(a,2)) + Tempin(valflux(a,3)));
                            kterconv = calesp(valflux(a,2))*peesp*(1.888e-5 + 1.324e-7*...
                                (Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2);
                            visco = 1.3291e-5 + 9e-8*(Tempin(valflux(a,2)) + Tempin(valflux(a,3)) - 546)/2;
                           Pra = peesp*calesp(valflux(a,2))*visco/kterconv;
                           Gra = gravidade*diaanimal(valflux(a,2))^3*...
                               (Tempin(valflux(a,2)) - Tempin(valflux(a,3)))/Tempin(valflux(a,3));
                           Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;
                           
                                MFCON(ax,1) = Kter(valflux(a,3))*Nu/diaanimal(valflux(a,3))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            if valflux(a,1) == 2 || valflux(a,1) == 3
                                MFCON(ax,2) = dtTLM*emis(valflux(a,2))*emis(valflux(a,3))*csb/...
                                    (emis(valflux(a,2)) + emis(valflux(a,3)) - ...
                                    emis(valflux(a,2))*emis(valflux(a,3)))...
                                    *(Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            end
                            MFCON(ax,3) = MFCON(ax,1)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                        
                            MFCON(ax,4) = MFCON(ax,2)*(Ztery(valflux(a,3))*Zterx(valflux(a,3))/(2*Z2c(valflux(a,3))))/ ...
                            (Ztery(valflux(a,2))*Zterx(valflux(a,2))/(2*Z2c(valflux(a,2))));
                            ax = ax+1;
                        end
                    end
                end
            end
        end
        Zter = 0;
        Rter = 0;
        ZG2n = 0;
    end
    
else
    Gter = 0;
    Zter = 0;
    Rter = 0;
    Z2c = 0;
    Zterx = 0;
    Ztery = 0;
    Rterx = 0;
    Rtery = 0;
    Zfatx = 0;
    Zfaty = 0;
    Ster = 0;
    ZG2n = 0;
    IF = 0;
    Tempinmatriz = 0;
    reflintn = 0;
    fonemter = 0;
    foninter = 0;
    MFSB = 0; MFNO = 0; MFCON = 0;
end

% Ajustandos os parâmetros para a simulação do campos EM
%% Nó TM 2D
if  simu ~= 3 && TM == 1
    %matriz de espalhamentao
    
    e0 = 8.854e-12;
    u0 = 4*pi*1e-7;
    YLTx = dtTLM./(u.*u0*dl);
    YLTy = dtTLM./(u.*u0*dl);
    Ys = 2*(e.*e0*dl - dtTLM^2./(u.*u0*dl)*2)./dtTLM;
    Gs = sigma*dl;
    Yc = 2*(YLTx + YLTy) + Ys + Gs;
    S = cell(1,size(fig,2));
    SARval = sigma./ro;
    
    for aa = 1:size(fig,2)
        S{1,aa} = 1/Yc(aa)*...
            [-(2*YLTx(aa) + Ys(aa) + Gs(aa))  2*YLTx(aa)                   2*YLTy(aa)                  2*YLTx(aa)               2*Ys(aa);...
            2*YLTy(aa)             -(2*YLTy(aa) + Ys(aa) + Gs(aa))         2*YLTy(aa)                  2*YLTx(aa)               2*Ys(aa);...
            2*YLTy(aa)                        2*YLTx(aa)        -(2*YLTx(aa) + Ys(aa) + Gs(aa))        2*YLTx(aa)               2*Ys(aa);...
            2*YLTy(aa)                        2*YLTx(aa)                   2*YLTy(aa)       -(2*YLTy(aa) + Ys(aa) + Gs(aa))     2*Ys(aa);...
            2*YLTy(aa)                        2*YLTx(aa)                   2*YLTy(aa)                  2*YLTx(aa)      (Ys(aa) - 2*(YLTx(aa) + YLTy(aa)) - Gs(aa))];
    end
    % Para calcularem os novos valores
    Ysf = Ys/dl;
    YLTxf = YLTx/dl;
    YLTyf = YLTy/dl;
    
    
    %conexão na malha
    rfemag = cell(Ty,Tx);
    for ra = 1:Ty
        for rb = 1:Tx
            rfemag{ra,rb} = zeros(4,2);
            if ra == 1 && rb == 1 %primeira linha primeira coluna
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [0 1]; % 0 - Para evitar a influência da tensão refletida no resultado
                rfemag{ra,rb}(3,:) = [0 1]; % 1 - Porque o resultado vem de uma manipulação algébrica
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
                
            elseif ra == 1 && rb == Tx %primeira linha ultima coluna
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [0 1];
                rfemag{ra,rb}(4,:) = [0 1];
                
            elseif ra == 1 %primeira linha
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [0 1];
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
                
            elseif ra == Ty && rb == 1 %ultima linha primeira coluna
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [0 1];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
                
            elseif ra == Ty && rb == Tx %ultima linha ultima coluna
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [0 1];
                
            elseif ra == Ty %ultima linha
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
                
            elseif rb == 1 %primeira coluna
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [0 1];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
                
            elseif rb == Tx %ultima coluna
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [0 1];
                
            else %qualquer outro no
                rfemag{ra,rb}(1,:) = [refleemag(ent,ra,rb,YLTx,YLTy,1) transfeemag(ent,ra,rb,YLTx,YLTy,1)];
                rfemag{ra,rb}(2,:) = [refleemag(ent,ra,rb,YLTx,YLTy,2) transfeemag(ent,ra,rb,YLTx,YLTy,2)];
                rfemag{ra,rb}(3,:) = [refleemag(ent,ra,rb,YLTx,YLTy,3) transfeemag(ent,ra,rb,YLTx,YLTy,3)];
                rfemag{ra,rb}(4,:) = [refleemag(ent,ra,rb,YLTx,YLTy,4) transfeemag(ent,ra,rb,YLTx,YLTy,4)];
            end
        end
    end
    
    %variaveis do TE
    Zc = 0;
    ZLTx = 0;
    ZLTy = 0;
    Gx = 0;
    Gy = 0;
    Zs = 0;
    Rs = 0;
    fatex = 0;
    fatey = 0;
    fathzx = 0;
    fathzy = 0;
    
    %% Nó TE 2D
elseif simu ~= 3 && TE == 1
    e0 = 8.854e-12;
    u0 = 4*pi*1e-7;
    ZLTx = dtTLM./(e.*e0*dl);
    ZLTy = dtTLM./(e.*e0*dl);
    Gx = sigma*dl;
    Gy = sigma*dl;
    Zs = 2*(u.*u0*dl - dtTLM^2./(e.*e0*dl)*2)./dtTLM;
    Rs = 0;
    SARval = sigma./ro;
    
    %variáveis auxiliares para a composição da matriz de espalhamento
    Zxeq = 2*ZLTx./(ZLTx.*Gx + 2);
    Zyeq = 2*ZLTy./(ZLTy.*Gy + 2);
    Zeq1 = Zxeq + 2*Zyeq + Rs + Zs;
    Zeq2 = 2*Zxeq + Zyeq + Rs + Zs;
    Z1 = (2 + Gx.*Zeq1).*ZLTx + 2*Zeq1;
    Z2 = (2 + Gy.*Zeq2).*ZLTy + 2*Zeq2;
    Z3 = 2*(Zxeq + Zyeq) + Rs + Zs;
    Z11 = (Z1 - 2*ZLTx.*(2 + Gx.*Zeq1))./Z1;
    Z22 = (Z2 - 2*ZLTy.*(2 + Gy.*Zeq2))./Z2;
    
    
    S = cell(1,size(fig,2));
    for aa = 1:size(fig,2)
        S{1,aa} = ...
            [Z22(aa)                4*Zyeq(aa)/Z1(aa)      4*Zyeq(aa)/Z2(aa)            -4*Zyeq(aa)/Z1(aa)          -2*Zyeq(aa)/Z3(aa);...
            4*Zxeq(aa)/Z2(aa)             Z11(aa)          -4*Zxeq(aa)/Z2(aa)           4*Zxeq(aa)/Z1(aa)           2*Zxeq(aa)/Z3(aa);...
            4*Zyeq(aa)/Z2(aa)       -4*Zyeq(aa)/Z1(aa)           Z22(aa)                4*Zyeq(aa)/Z1(aa)           2*Zyeq(aa)/Z3(aa);...
            -4*Zxeq(aa)/Z2(aa)       4*Zxeq(aa)/Z1(aa)     4*Zxeq(aa)/Z2(aa)                  Z11(aa)               -2*Zxeq(aa)/Z3(aa);...
            -4*Zs(aa)/Z2(aa)         4*Zs(aa)/Z1(aa)       4*Zs(aa)/Z2(aa)              -4*Zs(aa)/Z1(aa)             (Z3(aa) - 2*Zs(aa))/Z3(aa)];
    end
    % Para calcularem os campos
    fatex = ((2 + Gy.*ZLTy)*dl)./2;
    fatey = ((2 + Gx.*ZLTx)*dl)./2;
    fathzx = 4./(2 + Gy.*ZLTy);
    fathzy = 4./(2 + Gx.*ZLTx);
    Zc = (ZLTx.*fathzy + 2*ZLTy.*fathzx + (Zs + Rs))*dl;
    %conexão na malha
    rfemag = cell(Ty,Tx);
    for ra = 1:Ty
        for rb = 1:Tx
            rfemag{ra,rb} = zeros(4,2);
            if ra == 1 && rb == 1 %primeira linha primeira coluna
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [0 1]; % 0 - Para evitar a influência da tensão refletida no resultado
                rfemag{ra,rb}(3,:) = [0 1]; % 1 - Porque o resultado vem de uma manipulação algébrica
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
                
            elseif ra == 1 && rb == Tx %primeira linha ultima coluna
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [0 1];
                rfemag{ra,rb}(4,:) = [0 1];
                
            elseif ra == 1 %primeira linha
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [0 1];
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
                
            elseif ra == Ty && rb == 1 %ultima linha primeira coluna
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [0 1];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
                
            elseif ra == Ty && rb == Tx %ultima linha ultima coluna
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [0 1];
                
            elseif ra == Ty %ultima linha
                rfemag{ra,rb}(1,:) = [0 1];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
                
            elseif rb == 1 %primeira coluna
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [0 1];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
                
            elseif rb == Tx %ultima coluna
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [0 1];
                
            else %qualquer outro no
                rfemag{ra,rb}(1,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,1)];
                rfemag{ra,rb}(2,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,2)];
                rfemag{ra,rb}(3,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,3)];
                rfemag{ra,rb}(4,:) = [reflmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4) tranlmagte(ent,ra,rb,ZLTx,ZLTy,Gy,Gx,4)];
            end
        end
    end
    %variaveis do TM
    YLTx = 0;
    YLTy = 0;
    Ys = 0;
    Gs = 0;
    Yc = 0;
    Ysf = 0;
    YLTxf = 0;
    YLTyf = 0;
else
    YLTx = 0;
    YLTy = 0;
    Ys = 0;
    Gs = 0;
    Yc = 0;
    S = 0;
    SARval = 0;
    Ysf = 0;
    YLTxf = 0;
    YLTyf = 0;
    rfemag = 0;
    Zc = 0;
    ZLTx = 0;
    ZLTy = 0;
    Gx = 0;
    Gy = 0;
    Zs = 0;
    Rs = 0;
    fatex = 0;
    fatey = 0;
    fathzx = 0;
    fathzy = 0;
    
end
end