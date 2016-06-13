function [ppon] = respostas (Tbs, pon, res, nsdy, nsdx, k, ...
    Tx, Ty, Amp, SARval, nnosy, nnosx, x, y, freq, ...
    k2, nres, modo, campo, camposimu, dl, dimenmalha)
global saltosimu dtTLM TEM
if TEM == 1
    modo = 1;
elseif TEM == 2
    modo = 2;
end

campot = campo; %Definindo a msg de amostra
if camposimu == 14 && campo == 3        %Hx e Ez
    campo = 2;
    
elseif camposimu == 22 && campo == 4    %Hx e SAR
    campo = 2;
    
elseif camposimu == 26 && campo == 5    %Hx e T
    campo = 2;
    
elseif camposimu == 66 && campo == 4    %Hx, Hy e SAR
    campo = 3;
    
elseif camposimu == 78 && campo == 5    %Hx, Hy e T
    campo = 3;
    
elseif camposimu == 154 && campo ~= 1   %Hx, Ez e SAR
    campo = campo - 1;
    
elseif camposimu == 182 && campo ~= 1   %Hx, Ez e T
    campo = campo - 1;
    if campo == 4
        campo = 3;
    end
    
elseif camposimu == 286 && campo ~= 1   %Hx, SAR e T
    campo = campo - 2;
    
elseif camposimu == 546 && campo == 5   %Hx, Hy, Ez e T
    campo = 4;
elseif camposimu == 2002 && campo ~= 1  %Hx, Ez, SAR e T
    campo = campo - 1;
    
elseif camposimu == 858 && campo > 2    %Hx, Hy, SAR e T
    campo = campo - 1;
    
elseif camposimu == 3                   %Hy
    campo = campo - 1;
    
elseif camposimu == 21                  %Hy e Ez
    campo = campo - 1;
    
elseif camposimu == 33                  %Hy e SAR
    campo = campo - 1;
    if campo == 3
        campo = campo - 1;
    end
    
elseif camposimu == 39                  %Hy e T
    campo = campo - 1;
    if campo == 4
        campo = 2;
    end
    
elseif camposimu == 231                 %Hy, Ez e SAR
    campo = campo - 1;
    
elseif camposimu == 273                 %Hy, Ez e T
    campo = campo - 1;
    if campo == 4
        campo = 3;
    end
    
elseif camposimu == 429                 %Hy, SAR e T
    campo = campo - 2;
    if campo == 0;
        campo = 1;
    end
    
elseif camposimu == 3003                %Hy, Ez, SAR e T
    campo = campo - 1;
    
elseif camposimu == 7   %Ez
    campo = campo - 2;
    
elseif camposimu == 77  %Ez e SAR
    campo = campo - 2;
    
elseif camposimu == 91 %Ez e T
    campo = campo - 2;
    if campo == 3
        campo = 2;
    end
    
elseif camposimu == 1001    %Ez, SAR e T
    campo = campo - 2;
    
elseif camposimu == 11  %SAR
    campo = campo - 3;
    
elseif camposimu == 143         %SAR e T
    campo = campo - 3;
    
elseif camposimu == 13  %Térmico
    campo = campo - 4;
    
end

%obtendo os resultados
%para empMaG
disp ' '
disp 'Processando Resultados'

nkres = ceil(k/nres);

if dimenmalha == 1
    %% Uni - x fixo
    if res == 7
        if modo == 1
            
            if campot == 1
                titulo = 'Campo Hx distribuido ao longo da malha no método TLM';
            elseif campot == 2
                titulo = 'Campo Hy distribuido ao longo da malha no método TLM';
            elseif campot == 3
                titulo = 'Campo Ez distribuido ao longo da malha no método TLM';
            elseif campot == 4
                titulo = 'SAR distribuida ao longo da malha no método TLM';
            elseif campot == 5
                titulo = 'Temperatura distribuida ao longo da malha no método TLM';
            end
        end
        
        py = zeros(1,Tx);
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            for c = 1:size(resul.(bres){1},2)
                
                for b = 1:nsdx
                    py1 = zeros(1,size(Tbs{b},2));
                    for b1 = 1:size(Tbs{b},2)
                        py1(b1) = resul.(bres){b}(b1,c,campo);
                    end
                    
                    if b == nsdx
                        py((1 + (b-1)*(size(Tbs{1,b-1},2))):Tx) = py1(:);
                    else
                        py((1 + (b-1)*(size(Tbs{1,b},2))):b*size(Tbs{1,b},2)) = py1(:);
                    end
                end
                
                plot((1:Tx)*dl,py);grid
                xlim([dl Tx*dl])
                title(titulo)
                xlabel('Posição x da malha (m)')
                ylabel('Nível do Campo')
                pause(0.001)
            end
            clear resul
        end
        clear resul
        ppon = py;
        %% Uni - observar a intensidade com tempo e y fixo
    elseif res == 4
        
        if modo == 1
            if campot == 1
                titulo = ['Campo Hx distribuido ao longo da malha com c = ',...
                    num2str(k2*dtTLM), ' s no método TLM'];
            elseif campot == 2
                titulo = ['Campo Hy distribuido ao longo da malha com c = ',...
                    num2str(k2*dtTLM), ' s no método TLM'];
            elseif campot == 3
                titulo = ['Campo Ez distribuido ao longo da malha com c = ',...
                    num2str(k2*dtTLM), ' s no método TLM'];
            elseif campot == 4
                titulo = ['SAR distribuida  ao longo da malha com c = ',...
                    num2str(k2*dtTLM), ' s no método TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida  ao longo da malha com c = ',...
                    num2str(k2*dtTLM), ' s no método TLM'];
            end
        end
        
        for ares = 1:nres
            if k2 <= ares*nkres
                break
            end
        end
        
        bres = ['r',num2str(ares)];
        load(['resul',num2str(ares),'.mat'])
        nr = (ares - 1)*nkres;
        
        for b = 1:nsdx
            py1 = size(Tbs{b},2);
            for b1 = 1:size(Tbs{b},2)
                py1(b1) = resul.(bres){b}(b1,ceil((k2-nr-1)/saltosimu)+1,campo);
            end
            
            if b == nsdx
                py((1 + (b-1)*(size(Tbs{b-1},2))):Tx) = py1(:);
            else
                py((1 + (b-1)*(size(Tbs{b},2))):b*size(Tbs{b},2)) = py1(:);
            end
            
        end
        
        ppon = py;
        plot((1:Tx)*dl,py);grid
        xlim([dl Tx*dl])
        title(titulo)
        xlabel('Posição x da malha (m)')
        ylabel('Nível do Campo')
        %% Uni - plotando um ponto de saída
    elseif res == 3
        if modo == 1
            if campot == 1
                titulo2 = ['Campo Hx em x = ',num2str(pon(1)*dl), ' m no método TLM'];
            elseif campot == 2
                titulo2 = ['Campo Hy em x = ',num2str(pon(1)*dl), ' m no método TLM'];
            elseif campot == 3
                titulo2 = ['Campo Ez em x = ',num2str(pon(1)*dl), ' m no método TLM'];
            elseif campot == 4
                titulo2 = ['SAR em x = ',num2str(pon(1)*dl), ' m no método TLM'];
            elseif campot == 5
                titulo2 = ['Temperatura em x = ',num2str(pon(1)*dl), ' m no método TLM'];
            end
        end
        
        %Nó de saída
        pPindk = ceil(pon(1)/nnosx); %x
        pPinfon = round((pon(1)/nnosx - pPindk + 1)*nnosx); %x
        ksimu = 0;
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            nr = ksimu;
            ksimu = ksimu + size(resul.(bres){1},2);
            
            
            for c = 1:size(resul.(bres){1},2)
                ppon(c+nr) = resul.(bres){pPindk}(pPinfon,c, campo);
            end
            clear resul
        end
        ppon(end)
        plot((1:ksimu)*dtTLM*saltosimu,ppon);grid
        xlim([dtTLM ksimu*dtTLM*saltosimu])
        title(titulo2)
        xlabel('Tempo (s)')
        ylabel('Intensidade do Campo')
        
        %% Análise de Fourier 1D
    elseif res == 11
        
        msgfreq1 = [num2str(freq(1,1)), ' Hz'];
        if freq(1,1) > 1e12
            msgfreq1 = [num2str(freq(1,1)/1e12), ' THz'];
        elseif freq(1,1) > 1e9
            msgfreq1 = [num2str(freq(1,1)/1e9), ' GHz'];
        elseif freq(1,1) > 1e6
            msgfreq1 = [num2str((freq(1,1)/1e6)), ' MHz'];
        elseif freq(1,1) > 1e3
            msgfreq1 = [num2str((freq(1,1)/1e3)), ' kHz'];
        end
        
        msgfreq3 = [num2str(freq(1,end)), ' Hz'];
        if freq(1,end) > 1e12
            msgfreq3 = [num2str(freq(1,end)/1e12), ' THz'];
        elseif freq(1,end) > 1e9
            msgfreq3 = [num2str(freq(1,end)/1e9), ' GHz'];
        elseif freq(1,end) > 1e6
            msgfreq3 = [num2str((freq(1,end)/1e6)), ' MHz'];
        elseif freq(1,end) > 1e3
            msgfreq3 = [num2str((freq(1,end)/1e3)), ' kHz'];
        end
        
        if modo == 1
            if campot == 1
                titulo = ['Fourier: Hx  em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 2
                titulo = ['Fourier: Hy em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 3
                titulo = ['Fourier: Ez em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 4
                titulo = ['Fourier: SAR em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 5
                titulo = ['Fourier: Temperatura em (',...
                    num2str(x*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            end
        else
            if campot == 1
                titulo = ['Fourier: Ex em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 2
                titulo = ['Fourier: Ey em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 3
                titulo = ['Fourier: Hz em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 4
                titulo = ['Fourier: SAR em (',...
                    num2str(x*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 5
                titulo = ['Fourier: Temperatura em (',...
                    num2str(x*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            end
        end
        
        ppon = zeros(2,size(freq,2)); %real em 1 e imag em 2
        modulo = zeros(1,size(freq,2));
        
        b = ceil(x/nnosx);
        b1 = round((x/nnosx - b + 1)*nnosx);
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            for c = 1:size(resul.(bres){1},3)
                for d1 = 1:size(freq,2)
                    ppon(1,d1) = resul.(bres){b}(b1,c,campo)*...
                        cos(2*pi*freq(1,d1)*c*dtTLM*saltosimu) + ppon(1,d1);
                    ppon(2,d1) = -resul.(bres){b}(b1,c,campo)*...
                        sin(2*pi*freq(1,d1)*c*dtTLM*saltosimu) + ppon(2,d1);
                end
            end
        end
        for d1 = 1:size(freq,2)
            modulo(d1) = 20*log(sqrt(ppon(1,d1)^2 + ppon(2,d1)^2));
        end
        semilogx(freq,modulo);grid
        xlim([freq(1,1) freq(1,3)])
        title(titulo)
        xlabel('Frequência')
        ylabel('dB')
        
    end
elseif dimenmalha == 2
    %% plotando o mesh
    if res == 2
        
        ppon = 0;
        if modo == 1
            if campot == 1
                titulo = 'Propagação do Campo Hx no método TLM 2D-Shunt';
            elseif campot == 2
                titulo = 'Propagação do Campo Hy no método TLM 2D-Shunt';
            elseif campot == 3
                titulo = 'Propagação do Campo Ez no método TLM 2D-Shunt';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        else
            if campot == 1
                titulo = 'Propagação do Campo Ex no método TLM 2D-Série';
            elseif campot == 2
                titulo = 'Propagação do Campo Ey no método TLM 2D-Série';
            elseif campot == 3
                titulo = 'Propagação do Campo Hz no método TLM 2D-Série';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        end
        %         fr = 1;
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            for c = 1:size(resul.(bres){1},3)
                for b = 1:nsdx
                    for a = 1:nsdy
                        empMaG1 = zeros(size(Tbs{a,b},1),size(Tbs{a,b},2));
                        for b1 = 1:size(Tbs{a,b},2)
                            for a1 = 1:size(Tbs{a,b},1)
                                empMaG1(a1,b1) = resul.(bres){a,b}(a1,b1,c, campo);
                            end
                        end
                        
                        if a == nsdy && b == nsdx
                            
                            empMaG((1 + (a-1)*(size(Tbs{a-1,b-1},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b-1},2))):Tx) ...
                                = empMaG1(:,:);
                            
                        elseif a == nsdy
                            
                            empMaG((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG1(:,:);
                            
                        elseif b == nsdx
                            
                            empMaG((1 + (a-1)*(size(Tbs{a,b-1},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) ...
                                = empMaG1(:,:);
                            
                        else
                            
                            empMaG((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG1(:,:);
                            
                        end
                    end
                end
                
                mesh(empMaG,'FaceColor','interp')
                xlim([1 Tx])
                ylim([1 Ty])
                xlabel({'Posição em x (m)'});
                ylabel({'Posição em y (m)'});
                zlabel({'Intensidade do Campo'});
                %                 zlim([0 0.01])
                %Ez = 5 e -5
                title(titulo);
                pause(0.1)
                %                 movie1(fr) = getframe;
                %                 fr = fr + 1;
            end
            
            clear resul
        end
        %         save('sar.mat','movie1')
        %% plotando um ponto de saída
    elseif res == 3
        if modo == 1
            if campot == 1
                titulo2 = ['Campo Hx em(',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Shunt'];
            elseif campot == 2
                titulo2 = ['Campo Hy em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Shunt'];
            elseif campot == 3
                titulo2 = ['Campo Ez em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Shunt'];
            elseif campot == 4
                titulo2 = ['SAR em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método do TLM'];
            elseif campot == 5
                titulo2 = ['Temperatura em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM'];
            end
        else
            if campot == 1
                titulo2 = ['Campo Ex em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Série'];
            elseif campot == 2
                titulo2 = ['Campo Ey em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Série'];
            elseif campot == 3
                titulo2 = ['Campo Hz em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM 2D-Série'];
            elseif campot == 4
                titulo2 = ['SAR em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método do TLM'];
            elseif campot == 5
                titulo2 = ['Temperatura em (',num2str(pon(2)*dl),',',...
                    num2str(pon(1)*dl),') no método TLM'];
            end
        end
        
        %Nó de saída
        pPindk(1) = ceil(pon(2)/nnosy); %y
        pPindk(2) = ceil(pon(1)/nnosx); %x
        pPinfon(1) = round((pon(2)/nnosy - pPindk(1) + 1)*nnosy); %y
        pPinfon(2) = round((pon(1)/nnosx - pPindk(2) + 1)*nnosx); %x
        ksimu = 0;
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            nr = ksimu;
            ksimu = ksimu + size(resul.(bres){1},3);
            
            for c = 1:size(resul.(bres){1},3)
                ppon(c+nr) = resul.(bres){pPindk(1),pPindk(2)}(pPinfon(1),pPinfon(2),c, campo);
            end
            clear resul
        end
        
        plot((1:ksimu)*dtTLM*saltosimu,ppon);grid
        xlim([dtTLM ksimu*dtTLM*saltosimu])
        title(titulo2)
        xlabel('Tempo (s)')
        ylabel('Intensidade do Campo')
        
        %% observar a intensidade com tempo e y fixo
    elseif res == 4
        
        if modo == 1
            if campot == 1
                titulo = ['Campo Hx distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Shunt'];
            elseif campot == 2
                titulo = ['Campo Hy distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Shunt'];
            elseif campot == 3
                titulo = ['Campo Ez distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Shunt'];
            elseif campot == 4
                titulo = ['SAR distribuida  ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método do TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida  ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM'];
            end
        else
            
            if campot == 1
                titulo = ['Campo Ex distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 2
                titulo = ['Campo Ey distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 3
                titulo = ['Campo Hz distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 4
                titulo = ['SAR distribuida  ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método do TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida  ao longo da malha com y = '...
                    ,num2str(y*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM'];
            end
        end
        
        a = ceil(y/nnosy);
        a1 = round((y/nnosy - a + 1)*nnosy);
        
        for ares = 1:nres
            if k2 <= ares*nkres
                break
            end
        end
        
        bres = ['r',num2str(ares)];
        load(['resul',num2str(ares),'.mat'])
        nr = (ares - 1)*nkres;
        
        for b = 1:nsdx
            py1 = size(Tbs{a,b},2);
            for b1 = 1:size(Tbs{a,b},2)
                py1(b1) = resul.(bres){a,b}(a1,b1,ceil((k2-nr-1)/saltosimu)+1,campo);
            end
            
            if b == nsdx
                py((1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) = py1(:);
            else
                py((1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) = py1(:);
            end
            
        end
        
        ppon = py;
        plot((1:Tx)*dl,py);grid
        xlim([dl Tx*dl])
        title(titulo)
        xlabel('Posição x da malha')
        ylabel('Nível do Campo')
        
        %% observar a intensidade com tempo e x fixo
    elseif res == 5
        if modo == 1
            
            if campot == 1
                titulo = ['Campo Hx distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), 's no método TLM 2D-Shunt'];
            elseif campot == 2
                titulo = ['Campo Hy distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), 's no método TLM 2D-Shunt'];
            elseif campot == 3
                titulo = ['Campo Ez distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), 's no método TLM 2D-Shunt'];
            elseif campot == 4
                titulo = ['SAR distribuida  ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), 's no método do TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida  ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), 's no método TLM'];
            end
        else
            
            if campot == 1
                titulo = ['Campo Ex distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 2
                titulo = ['Campo Ey distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 3
                titulo = ['Campo Hz distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM 2D-Série'];
            elseif campot == 4
                titulo = ['SAR distribuida  ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método do TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida  ao longo da malha com x = '...
                    ,num2str(x*dl), ' m e c = ',num2str(k2*dtTLM), ' s no método TLM'];
            end
        end
        b = ceil(x/nnosx);
        b1 = round((x/nnosx - b + 1)*nnosx);
        
        for ares = 1:nres
            if k2 <= ares*nkres
                break
            end
        end
        
        bres = ['r',num2str(ares)];
        load(['resul',num2str(ares),'.mat'])
        nr = (ares - 1)*nkres;
        
        for a = 1:nsdy
            px1 = size(Tbs{a,b},1);
            for a1 = 1:size(Tbs{a,b},1)
                px1(a1) = resul.(bres){a,b}(a1,b1,ceil((k2-nr-1)/saltosimu)+1, campo);
            end
            
            if a == nsdy
                px((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty) = px1(:);
            else
                px((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1)) = px1(:);
            end
            
        end
        
        ppon = px;
        plot((1:Ty)*dl,px);grid
        xlim([dl Ty*dl])
        title(titulo)
        xlabel('Posição y da malha (m)')
        ylabel('Intensidade do Campo')
        %% Vetores do Campo
    elseif res == 6
        
        ppon = 0;
        if modo == 1
            titulo = 'Vetores de Propagação do Campo Hx e Hy no método TLM 2D-Shunt';
        else
            titulo = 'Vetores de Propagação do Campo Ex e Ey no método TLM 2D-Série';
        end
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            for c = 1:size(resul.(bres){1},3)
                for b = 1:nsdx
                    for a = 1:nsdy
                        empMaG11 = zeros(size(Tbs{a,b},1),size(Tbs{a,b},2));
                        empMaG12 = zeros(size(Tbs{a,b},1),size(Tbs{a,b},2));
                        for b1 = 1:size(Tbs{a,b},2)
                            for a1 = 1:size(Tbs{a,b},1)
                                empMaG11(a1,b1) = resul.(bres){a,b}(a1,b1,c, 1);
                                empMaG12(a1,b1) = resul.(bres){a,b}(a1,b1,c, 2);
                            end
                        end
                        
                        if a == nsdy && b == nsdx
                            
                            empMaG21((1 + (a-1)*(size(Tbs{a-1,b-1},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b-1},2))):Tx) ...
                                = empMaG11(:,:);
                            
                            empMaG22((1 + (a-1)*(size(Tbs{a-1,b-1},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b-1},2))):Tx) ...
                                = empMaG12(:,:);
                            
                        elseif a == nsdy
                            
                            empMaG21((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG11(:,:);
                            
                            empMaG22((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG12(:,:);
                            
                        elseif b == nsdx
                            
                            empMaG21((1 + (a-1)*(size(Tbs{a,b-1},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) ...
                                = empMaG11(:,:);
                            
                            empMaG22((1 + (a-1)*(size(Tbs{a,b-1},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) ...
                                = empMaG12(:,:);
                            
                            
                        else
                            
                            empMaG21((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG11(:,:);
                            
                            empMaG22((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG12(:,:);
                            
                        end
                    end
                end
                
                quiver(empMaG21,empMaG22)
                xlim([1 Tx])
                ylim([1 Ty])
                xlabel({'Posição em x'});
                ylabel({'Posição em y'});
                zlabel({'Intensidade do Campo'});
                title(titulo);
                pause(0.01)
            end
            clear resul
        end
        
        %% observar a intensidade com y fixo
    elseif res == 7
        
        if modo == 1
            
            if campot == 1
                titulo = ['Campo Hx distribuido ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM 2D-Shunt'];
            elseif campot == 2
                titulo = ['Campo Hy distribuido ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM 2D-Shunt'];
            elseif campot == 3
                titulo = ['Campo Ez distribuido ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM 2D-Shunt'];
            elseif campot == 4
                titulo = ['SAR distribuida ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM'];
            end
        else
            if campot == 1
                titulo = ['Campo Ex distribuido ao longo da malha com y = '...
                    ,num2str(y*dl) ' no método TLM 2D-Série'];
            elseif campot == 2
                titulo = ['Campo Ey distribuido ao longo da malha com y = '...
                    ,num2str(y*dl),' no método TLM 2D-Série'];
            elseif campot == 3
                titulo = ['Campo Hz distribuido ao longo da malha com y = '...
                    ,num2str(y*dl), ' no método TLM 2D-Série'];
            elseif campot == 4
                titulo = ['SAR distribuida ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida ao longo da malha com y = '...
                    ,num2str(y*dl),  ' no método TLM'];
            end
        end
        %         fr = 1;
        a = ceil(y/nnosy); %subdomínio
        a1 = round((y/nnosy - a + 1)*nnosy); %ponto
        py = zeros(1,Tx);
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            for c = 1:size(resul.(bres){1},3)
                
                for b = 1:nsdx
                    py1 = zeros(1,size(Tbs{a,b},2));
                    for b1 = 1:size(Tbs{a,b},2)
                        py1(b1) = resul.(bres){a,b}(a1,b1,c,campo);
                    end
                    
                    if b == nsdx
                        py((1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) = py1(:);
                    else
                        py((1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) = py1(:);
                    end
                end
                
                plot((1:Tx)*dl,py);grid
                xlim([dl Tx*dl])
                title(titulo)
                xlabel('Posição x da malha (m)')
                ylabel('Nível do Campo')
                %                 ylim([0 0.0005]);
                %                 movie1(fr) = getframe;
                %                 fr = fr + 1;
                pause(0.1)
            end
            clear resul
        end
        %         save('saryfix.mat','movie1')
        ppon = py;
        
        %% observar a intensidade com x fixo
    elseif res == 8
        if modo == 1
            if campot == 3
                titulo = ['Campo Ez distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Shunt'];
            elseif campot == 1
                titulo = ['Campo Hx distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Shunt'];
            elseif campot == 2
                titulo = ['Campo Hy distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Shunt'];
            elseif campot == 4
                titulo = ['SAR distribuida ao longo da malha com x = '...
                    ,num2str(x*dl),  ' no método TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida ao longo da malha com x = '...
                    ,num2str(x*dl),  ' no método TLM'];
            end
        else
            if campot == 1
                titulo = ['Campo Ex distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Série'];
            elseif campot == 2
                titulo = ['Campo Ey distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Série'];
            elseif campot == 3
                titulo = ['Campo Hz distribuido ao longo da malha com x = '...
                    ,num2str(x*dl), ' no método TLM 2D-Série'];
            elseif campot == 4
                titulo = ['SAR distribuida ao longo da malha com x = '...
                    ,num2str(x*dl),  ' no método TLM'];
            elseif campot == 5
                titulo = ['Temperatura distribuida ao longo da malha com x = '...
                    ,num2str(x*dl),  ' no método TLM'];
            end
        end
        b = ceil(x/nnosx);
        b1 = round((x/nnosx - b + 1)*nnosx);
        
        px = zeros(1,Ty);
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            
            for c = 1:size(resul.(bres){1},3)
                
                for a = 1:nsdy
                    px1 = zeros(1,size(Tbs{a,b},1));
                    for a1 = 1:size(Tbs{a,b},1)
                        px1(a1) = resul.(bres){a,b}(a1,b1,c,campo);
                    end
                    
                    if a == nsdy
                        px((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty) = px1(:);
                    else
                        px((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1)) = px1(:);
                    end
                end
                
                plot((1:Ty)*dl,px);grid
                xlim([dl Ty*dl])
                title(titulo)
                xlabel('Posição y da malha')
                ylabel('Nível do Campo')
                pause(0.1)
            end
            clear resul
        end
        ppon = px;
        
        %% Contorno Dinâmico
    elseif res == 9
        
        ppon = 0;
        if modo == 1
            if campot == 1
                titulo = 'Propagação do Campo Hx no método TLM 2D-Shunt';
            elseif campot == 2
                titulo = 'Propagação do Campo Hy no método TLM 2D-Shunt';
            elseif campot == 3
                titulo = 'Propagação do Campo Ez no método TLM 2D-Shunt';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        else
            if campot == 1
                titulo = 'Propagação do Campo Ex no método TLM 2D-Série';
            elseif campot == 2
                titulo = 'Propagação do Campo Ey no método TLM 2D-Série';
            elseif campot == 3
                titulo = 'Propagação do Campo Hz no método TLM 2D-Série';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        end
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            
            for c = 1:size(resul.(bres){1},3)
                for b = 1:nsdx
                    for a = 1:nsdy
                        empMaG1 = zeros(size(Tbs{a,b},1),size(Tbs{a,b},2));
                        for b1 = 1:size(Tbs{a,b},2)
                            for a1 = 1:size(Tbs{a,b},1)
                                empMaG1(a1,b1) = resul.(bres){a,b}(a1,b1,c, campo);
                            end
                        end
                        
                        if a == nsdy && b == nsdx
                            
                            empMaG((1 + (a-1)*(size(Tbs{a-1,b-1},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b-1},2))):Tx) ...
                                = empMaG1(:,:);
                            
                        elseif a == nsdy
                            
                            empMaG((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty,...
                                (1 + (b-1)*(size(Tbs{a-1,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG1(:,:);
                            
                        elseif b == nsdx
                            
                            empMaG((1 + (a-1)*(size(Tbs{a,b-1},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) ...
                                = empMaG1(:,:);
                            
                        else
                            
                            empMaG((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1),...
                                (1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) ...
                                = empMaG1(:,:);
                            
                        end
                    end
                end
                
                contourf(empMaG)
                xlim([1 Tx])
                ylim([1 Ty])
                xlabel({'Posição em x'});
                ylabel({'Posição em y'});
                title(titulo);
                pause(0.01)
            end
            clear resul
        end
        
        %% Contorno Estático
    elseif res == 10
        
        ppon = 0;
        if modo == 1
            if campot == 1
                titulo = 'Propagação do Campo Hx no método TLM 2D-Shunt';
            elseif campot == 2
                titulo = 'Propagação do Campo Hy no método TLM 2D-Shunt';
            elseif campot == 3
                titulo = 'Propagação do Campo Ez no método TLM 2D-Shunt';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        else
            if campot == 1
                titulo = 'Propagação do Campo Ex no método TLM 2D-Série';
            elseif campot == 2
                titulo = 'Propagação do Campo Ey no método TLM 2D-Série';
            elseif campot == 3
                titulo = 'Propagação do Campo Hz no método TLM 2D-Série';
            elseif campot == 4
                titulo = 'Propagação da SAR calculada pelo método do TLM';
            elseif campot == 5
                titulo = 'Propagação da Temperatura no método TLM';
            end
        end
        
        
        
        a = ceil(y/nnosy);
        a1 = round((y/nnosy - a + 1)*nnosy);
        
        for ares = 1:nres
            if k2 <= ares*nkres
                break
            end
        end
        
        bres = ['r',num2str(ares)];
        load(['resul',num2str(ares),'.mat'])
        nr = (ares - 1)*nkres;
        for b = 1:nsdx
            for a = 1:nsdy
                empMaG1 = zeros(size(Tbs{a,b},1),size(Tbs{a,b},2));
                for b1 = 1:size(Tbs{a,b},2)
                    for a1 = 1:size(Tbs{a,b},1)
                        empMaG1(a1,b1) = resul.(bres){a,b}(a1,b1,ceil((k2-nr-1)/saltosimu)+1, campo);
                    end
                end
                
                if a == nsdy && b == nsdx
                    
                    empMaG((1 + (a-1)*(size(Tbs{a-1,b-1},1))):Ty,...
                        (1 + (b-1)*(size(Tbs{a-1,b-1},2))):Tx) ...
                        = empMaG1(:,:);
                    
                elseif a == nsdy
                    
                    empMaG((1 + (a-1)*(size(Tbs{a-1,b},1))):Ty,...
                        (1 + (b-1)*(size(Tbs{a-1,b},2))):b*size(Tbs{a,b},2)) ...
                        = empMaG1(:,:);
                    
                elseif b == nsdx
                    
                    empMaG((1 + (a-1)*(size(Tbs{a,b-1},1))):a*size(Tbs{a,b},1),...
                        (1 + (b-1)*(size(Tbs{a,b-1},2))):Tx) ...
                        = empMaG1(:,:);
                    
                else
                    
                    empMaG((1 + (a-1)*(size(Tbs{a,b},1))):a*size(Tbs{a,b},1),...
                        (1 + (b-1)*(size(Tbs{a,b},2))):b*size(Tbs{a,b},2)) ...
                        = empMaG1(:,:);
                    
                end
            end
        end
        
        contourf(empMaG)
        xlim([1 Tx])
        ylim([1 Ty])
        xlabel({'Posição em x'});
        ylabel({'Posição em y'});
        title(titulo);
        pause(0.01)
        
        
        %% Análise de Fourier 2D
    elseif res == 11
        
        msgfreq1 = [num2str(freq(1,1)), ' Hz'];
        if freq(1,1) > 1e12
            msgfreq1 = [num2str(freq(1,1)/1e12), ' THz'];
        elseif freq(1,1) > 1e9
            msgfreq1 = [num2str(freq(1,1)/1e9), ' GHz'];
        elseif freq(1,1) > 1e6
            msgfreq1 = [num2str((freq(1,1)/1e6)), ' MHz'];
        elseif freq(1,1) > 1e3
            msgfreq1 = [num2str((freq(1,1)/1e3)), ' kHz'];
        end
        
        msgfreq3 = [num2str(freq(1,end)), ' Hz'];
        if freq(1,end) > 1e12
            msgfreq3 = [num2str(freq(1,end)/1e12), ' THz'];
        elseif freq(1,end) > 1e9
            msgfreq3 = [num2str(freq(1,end)/1e9), ' GHz'];
        elseif freq(1,end) > 1e6
            msgfreq3 = [num2str((freq(1,end)/1e6)), ' MHz'];
        elseif freq(1,end) > 1e3
            msgfreq3 = [num2str((freq(1,end)/1e3)), ' kHz'];
        end
        
        if modo == 1
            if campot == 1
                titulo = ['Fourier: Hx  em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 2
                titulo = ['Fourier: Hy em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 3
                titulo = ['Fourier: Ez em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 4
                titulo = ['Fourier: SAR em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 5
                titulo = ['Fourier: Temperatura em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            end
        else
            if campot == 1
                titulo = ['Fourier: Ex em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 2
                titulo = ['Fourier: Ey em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 3
                titulo = ['Fourier: Hz em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 4
                titulo = ['Fourier: SAR em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            elseif campot == 5
                titulo = ['Fourier: Temperatura em (',...
                    num2str(x*dl),',',num2str(y*dl),') com ',...
                    msgfreq1,':',msgfreq3,'.'];
            end
        end
        
        ppon = zeros(2,size(freq,2)); %real em 1 e imag em 2
        modulo = zeros(1,size(freq,2));
        
        b = ceil(x/nnosx);
        b1 = round((x/nnosx - b + 1)*nnosx);
        a = ceil(y/nnosy);
        a1 = round((y/nnosy - a + 1)*nnosy);
        
        for ares = 1:nres; % primeiros
            bres = ['r',num2str(ares)];
            load(['resul',num2str(ares),'.mat'])
            for c = 1:size(resul.(bres){1},3)
                for d1 = 1:size(freq,2)
                    ppon(1,d1) = resul.(bres){a,b}(a1,b1,c,campo)*...
                        cos(-2*pi*freq(1,d1)*(c-1)*dtTLM*saltosimu)*dtTLM + ppon(1,d1);
                    ppon(2,d1) = resul.(bres){a,b}(a1,b1,c,campo)*...
                        sin(-2*pi*freq(1,d1)*(c-1)*dtTLM*saltosimu)*dtTLM + ppon(2,d1);
                end
            end
        end
        mf = 20*log(sqrt(ppon(1,1)^2 + ppon(2,1)^2));
        for d1 = 1:size(freq,2)
            modulo(d1) = 20*log(sqrt(ppon(1,d1)^2 + ppon(2,d1)^2));
%             modulo(d1) = (sqrt(ppon(1,d1)^2 + ppon(2,d1)^2));
            if modulo(d1) > mf
                mf = modulo(d1);
                freqenf = freq(d1);
            end
        end
        freqenf
        semilogx(freq,modulo);grid
        plot(freq,modulo);grid
        xlim([freq(1,1) freq(1,end)])
        title(titulo)
        xlabel('Frequência')
        ylabel('dB')
    end
end
disp ' '
disp 'Fim do Processamento dos Resultados'

end