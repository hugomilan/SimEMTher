function [malha, Tbs, Tbdk, Tbster, Tbterdk, resul, nres, reflint, rfemagdk, entdk, FSBF,...
    FNOF, FCOF] = ...
    subdominio(nsdy, nsdx, Ty, Tx, k, Tempinmatriz, camposimu, fig, enta, nnosy, nnosx,...
    ngb, reflintn, rfemag, simu, Gter, Zter, Rter, Zterx, Ztery, Rterx, Rtery, ...
    Z2c, Kter, IF, dl, emis)
global frontvertical fronthorizontal valorfronteira quantcampo dimenmalha saltosimu Ta
nres = ceil(Tx*Ty*k*8*quantcampo/(ngb*1e9));
nkres = ceil(k/nres);
nres = round(k/nkres);
nkres = floor(nkres/saltosimu);

dmat = 2*dimenmalha;
FSBF = zeros(1,2);
FNOF = zeros(1,dmat);
FCOF = zeros(1,4);
vff = 1;
if dimenmalha == 1
    %Portas do TLM: 1 - Direto; 2 - Equerdo
    malha = cell(1,nsdx); %Variável que contém as informações dos nós
    entdk = cell(1,nsdx); %Variável que contém as informações dos meios na malha
    resul.r1 = cell(1,nsdx); %Variavel que irá conter os resul1tados
    
    if simu == 1
        Tbs = zeros(nsdx,2); %Fazer a transmissão de informação dos subdomínios EM
        Tbdk = zeros(1,2); %Fronteira
        rfemagdk = cell(1,nsdx); %reflexões internas EM
        if (~rem(camposimu,13)) %Térmico
            Tbster = zeros(nsdx,2); %Fazer a transmissão de informação dos subdomínios T
            Tbterdk = zeros(2,2); %Fronteira
            reflint = cell(1,nsdx); %reflexões internas
            portassimu = 5; %Variável que diz o número de portas do nó
            inter = 4; % Para colocar as temperaturas
        else
            Tbster = 0;
            Tbterdk = 0;
            reflint = 0;
            portassimu = 3;
            inter = 1; % Para colocar as temperaturas
        end
        
    elseif simu == 2
        Tbs = zeros(nsdx,2); %Fazer a transmissão de informação dos subdomínios EM
        Tbdk = zeros(2,2); %Fronteira
        rfemagdk = cell(1,nsdx); %reflexões internas EM
        Tbster = 0;
        Tbterdk = 0;
        reflint = 0;
        portassimu = 3; %Variável que diz o número de portas do nó
        
    elseif simu == 3
        Tbs = 0;
        Tbdk = 0;
        rfemagdk = 0;
        Tbster = zeros(nsdx,2); %Fazer a transmissão de informação dos subdomínios T
        Tbterdk = zeros(2,2); %Fronteira
        reflint = cell(1,nsdx); %reflexões internas
        portassimu = 2; %Variável que diz o número de portas do nó
        inter = 1;
        
    end
    
    
    
    
    
    
    
    for b = 1:nsdx
        if b == nsdx
            %quando for o da direita
            
            malha{b} = cell(1,Tx-nnosx*(nsdx-1));
            entdk{b} = zeros(1,Tx-nnosx*(nsdx-1));
            resul.r1{b} = zeros(Tx-nnosx*(nsdx-1),nkres,quantcampo);
            
            if (~rem(camposimu,13)) %Térmico
                reflint{b} = cell(1,Tx-nnosx*(nsdx-1)); %Para calcular a Temperatura
            end
            
            if simu ~= 3
                rfemagdk{b} = cell(1,Tx-nnosx*(nsdx-1)); %Para reflexão EM
            end
            
            
            
            
            for bb = 1:(Tx-nnosx*(nsdx-1)) %varredura horizontal
                
                malha{b}{bb} = zeros(2,portassimu);
                
                entdk{b}(bb) = enta(1,(b-1)*nnosx + bb);
                
                if simu ~= 3
                    rfemagdk{b}{bb}(1,:) = rfemag{(b-1)*nnosx + bb}(1,:);
                    rfemagdk{b}{bb}(2,:) = rfemag{(b-1)*nnosx + bb}(2,:);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    
                    reflint{b}{bb}(1,:) = reflintn{(b-1)*nnosx + bb}(1,:);
                    reflint{b}{bb}(2,:) = reflintn{(b-1)*nnosx + bb}(2,:);
                    
                    for afig = 1:size(fig,2);
                        if enta(1,(b-1)*nnosx + bb) == fig(afig)
                            
                            malha{b}{bb}(2,inter:end) = [1 1]*Tempinmatriz(afig);
                            malha{b}{bb}(1,inter:end) = [1 1]*Tempinmatriz(afig);
                            break
                        end
                    end
                end
            end
            
            
            if simu ~= 3
                %lado direito
                Tbdk(2,2) = valorfronteira(1, fronthorizontal( 1, 1 ,1) ,1);
            end
            
            if (~rem(camposimu,13)) %Térmico
                %lado direito
                if valorfronteira(2, fronthorizontal( 1, 1 ,2) ,3) == 1
                    Tbterdk(2,1) =  valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1);
                    Tbterdk(2,2) =  valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2);
                    Tbterdk(2,3) = 1;%tau1B
                    Tbterdk(2,4) = 0;%tauB1
                    Tbterdk(2,5) = 0;%roB1
                    Tbterdk(2,6) = 0;%Temp. da front.
                elseif valorfronteira(2, fronthorizontal( 1, 1 ,2) ,3) == 2
                    meio = enta(1,end);
                    afr = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,4);
                    if afr > 3
                        if valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1) ~= 0
                            Tbterdk(2,1) = reflfrontuni(meio, Rter, Zter, valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1)); %ro1B
                            Tbterdk(2,2) = transfrontuni(meio,  Rter, Zter, Gter, valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1),...
                                valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2), IF); %Tensão para calc.
                            Tbterdk(2,3) = coetrafrontuni(meio, Rter, Zter, valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1));%tau1B
                            Tbterdk(2,4) = coetrafrontuni(valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1), Rter, Zter, meio);%tauB1
                            Tbterdk(2,5) = reflfrontuni(valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1), Rter, Zter, meio);%roB1
                            Tbterdk(2,6) = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2);%Temp. da front.
                        else
                            Tbterdk(2,1) = reflfrontuniar(meio, Rter, Zter, 1); %ro1B
                            Tbterdk(2,2) = transfrontuniar(meio,  Rter, Zter, valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2)); %Tensão para calc.
                            Tbterdk(2,3) = coetrafrontuniar(meio, Rter, Zter, 2);%tau1B
                            Tbterdk(2,4) = coetrafrontuniar(meio, Rter, Zter, 2);%tauB1
                            Tbterdk(2,5) = reflfrontuniar(meio, Rter, Zter, 2);%roB1
                            Tbterdk(2,6) = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2);%Temp. da front.
                        end
                    else
                        Tbterdk(2,1) =  1;
                        Tbterdk(2,2) =  0;
                        Tbterdk(2,3) = 1;%tau1B
                        Tbterdk(2,4) = 0;%tauB1
                        Tbterdk(2,5) = 0;%roB1
                        Tbterdk(2,6) = 0;%Temp. da front.
                    end
                    %1 - meio, 2 - temperatura, 3 - característica da fronteira
                    meio = enta(1,end);
                    meiofron = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,1);
                    FSBF(vff,:) = [2 nsdx]; %1 - esquerda, 2 - direita
                    FNOF(vff,:) = [2 (Tx-nnosx*(nsdx-1))]; %1 - esquerda, 2 - direita
                    %1 - coef. reflex. 2 - coef. transf
                    if meiofron ~= 0
                        FCOF(vff,1) = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2); %temperatura
                    else
                        FCOF(vff,1) = Ta;
                    end
                    convrad = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,4);
                    diaanimal = valorfronteira(2,fronthorizontal( 1, 1 ,2),5);
                    FCOF(vff,2) = diaanimal;
                    FCOF(vff,5) = valorfronteira(2,fronthorizontal( 1, 1 ,2),6);
                    if convrad == 1 || convrad == 5
                        if meiofron ~= 0
                            FCOF(vff,3) = convfrontuni(Zter, Gter, Kter, diaanimal, meio, meiofron); %convecção
                        else
                            FCOF(vff,3) = convfrontuniar(Zter, Gter, diaanimal, meio); %convecção
                        end
                        FCOF(vff,4) = 0;
                    elseif convrad == 2 || convrad == 6
                        FCOF(vff,3) = 0;
                        if meiofron ~= 0
                            FCOF(vff,4) = radfrontuni(Zter, Gter, emis, meio, meiofron); %radiação
                        else
                            FCOF(vff,4) = radfrontuniar(Zter, Gter, emis, meio); %radiação
                        end
                    elseif convrad == 3 || convrad == 7
                        if meiofron ~= 0
                            FCOF(vff,3) = convfrontuni(Zter, Gter, Kter, diaanimal, meio, meiofron); %convecção
                            FCOF(vff,4) = radfrontuni(Zter, Gter, emis, meio, meiofron); %radiação
                        else
                            FCOF(vff,3) = convfrontuniar(Zter, Gter, diaanimal, meio); %convecção
                            FCOF(vff,4) = radfrontuniar(Zter, Gter, emis, meio); %radiação
                        end
                    end
                    vff = vff + 1;
                end
            end
            
            
            
            
            
            
            
            
            
            
            
            
            
        elseif b == 1
            %o primeiro
            
            malha{b} = cell(1,nnosx);
            entdk{b} = zeros(1,nnosx);
            resul.r1{b} = zeros(nnosx,nkres,quantcampo);
            
            if (~rem(camposimu,13)) %Térmico
                reflint{b} = cell(1,nnosx);
            end
            
            if simu ~= 3
                rfemagdk{b} = cell(1,Tx-nnosx*(nsdx-1)); %Para reflexão EM
            end
            
            
            
            for bb = 1:nnosx %varredura horizontal
                malha{b}{bb} = zeros(2,portassimu);
                entdk{b}(bb) = enta(1,(b-1)*nnosx + bb);
                
                if simu ~= 3
                    rfemagdk{b}{bb}(1,:) = rfemag{(b-1)*nnosx + bb}(1,:);
                    rfemagdk{b}{bb}(2,:) = rfemag{(b-1)*nnosx + bb}(2,:);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    
                    reflint{b}{bb}(1,:) = reflintn{(b-1)*nnosx + bb}(1,:);
                    reflint{b}{bb}(2,:) = reflintn{(b-1)*nnosx + bb}(2,:);
                    
                    for afig = 1:size(fig,2)
                        if enta(1,(b-1)*nnosx + bb) == fig(afig)
                            
                            malha{b}{bb}(2,inter:end) = [1 1]*Tempinmatriz(afig);
                            malha{b}{bb}(1,inter:end) = [1 1]*Tempinmatriz(afig);
                            
                            break
                        end
                    end
                end
            end
            
            if simu ~= 3
                %lado esquerdo
                Tbdk(1,1) = valorfronteira(1, fronthorizontal( 2, 1 ,1) ,1);
            end
            
            if (~rem(camposimu,13)) %Térmico
                %lado esquerdo
                if valorfronteira(2, fronthorizontal( 2, 1 ,2) ,3) == 1
                    Tbterdk(1,1) =  valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1);
                    Tbterdk(1,2) =  valorfronteira(2, fronthorizontal( 2, 1 ,2) ,2);
                    Tbterdk(1,3) = 1;%tau1B
                    Tbterdk(1,4) = 0;%tauB1
                    Tbterdk(1,5) = 0;%roB1
                    Tbterdk(1,6) = 0;%Temp. da front.
                elseif valorfronteira(2, fronthorizontal( 2, 1 ,2) ,3) == 2
                    meio = enta(1,1);
                    afr = valorfronteira(2, fronthorizontal( 2, 1 ,2) ,4);
                    if afr > 3
                        if valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1) ~= 0
                            Tbterdk(1,1) = reflfrontuni(meio, Rter, Zter, valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1));
                            Tbterdk(1,2) = transfrontuni(meio,  Rter, Zter, Gter, valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1),...
                                valorfronteira(2, fronthorizontal( 2, 1 ,2) ,2), IF);
                            Tbterdk(1,3) = coetrafrontuni(meio, Rter, Zter, valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1));%tau1B
                            Tbterdk(1,4) = coetrafrontuni(valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1), Rter, Zter, meio);%tauB1
                            Tbterdk(1,5) = reflfrontuni(valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1), Rter, Zter, meio);%roB1
                            Tbterdk(1,6) = valorfronteira(2, fronthorizontal( 2, 1 ,2) ,2);%Temp. da front.
                        else
                            Tbterdk(1,1) = reflfrontuniar(meio, Rter, Zter, 1); %ro1B
                            Tbterdk(1,2) = transfrontuniar(meio,  Rter, Zter, valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2)); %Tensão para calc.
                            Tbterdk(1,3) = coetrafrontuniar(meio, Rter, Zter, 2);%tau1B
                            Tbterdk(1,4) = coetrafrontuniar(meio, Rter, Zter, 2);%tauB1
                            Tbterdk(1,5) = reflfrontuniar(meio, Rter, Zter, 2);%roB1
                            Tbterdk(1,6) = valorfronteira(2, fronthorizontal( 1, 1 ,2) ,2);%Temp. da front.
                        end
                    else
                        Tbterdk(1,1) =  1;
                        Tbterdk(1,2) =  0;
                        Tbterdk(1,3) = 1;%tau1B
                        Tbterdk(1,4) = 0;%tauB1
                        Tbterdk(1,5) = 0;%roB1
                        Tbterdk(1,6) = 0;%Temp. da front.
                    end
                    
                    meio = enta(1,1);
                    meiofron = valorfronteira(2, fronthorizontal( 2, 1 ,2) ,1);
                    FSBF(vff,:) = [1 1]; %pela esquerda => 1
                    FNOF(vff,:) = [1 1];
                    if meiofron ~= 0
                        FCOF(vff,1) = valorfronteira(2, fronthorizontal( 2, 1 ,2) ,2); %temperatura
                    else
                        FCOF(vff,1) = Ta;
                    end
                    convrad = valorfronteira(2, fronthorizontal( 2, 1 ,2) ,4);
                    diaanimal = valorfronteira(2,fronthorizontal( 2, 1 ,2),5);
                    FCOF(vff,2) = diaanimal;
                    FCOF(vff,5) = valorfronteira(2,fronthorizontal( 2, 1 ,2),6);
                    if convrad == 1 || convrad == 5
                        if meiofron ~= 0
                            FCOF(vff,3) = convfrontuni(Zter, Gter, Kter, diaanimal, meio, meiofron); %convecção
                        else
                            FCOF(vff,3) = convfrontuniar(Zter, Gter, diaanimal, meio); %convecção
                        end
                        FCOF(vff,4) = 0;
                    elseif convrad == 2 || convrad == 6
                        FCOF(vff,3) = 0;
                        if meiofron ~= 0
                            FCOF(vff,4) = radfrontuni(Zter, Gter, emis, meio, meiofron); %radiação
                        else
                            FCOF(vff,4) = radfrontuniar(Zter, Gter, emis, meio); %radiação
                        end
                    elseif convrad == 3 || convrad == 7
                        if meiofron ~= 0
                            FCOF(vff,3) = convfrontuni(Zter, Gter, Kter, diaanimal, meio, meiofron); %convecção
                            FCOF(vff,4) = radfrontuni(Zter, Gter, emis, meio, meiofron); %radiação
                        else
                            FCOF(vff,3) = convfrontuniar(Zter, Gter, diaanimal, meio); %convecção
                            FCOF(vff,4) = radfrontuniar(Zter, Gter, emis, meio); %radiação
                        end
                    end
                    vff = vff + 1;
                end
            end
            
            
            
            
            
            
            
            
        else
            %todos os demais casos
            
            malha{b} = cell(1,nnosx);
            entdk{b} = zeros(1,nnosx);
            resul.r1{b} = zeros(nnosx,nkres,quantcampo);
            
            
            if (~rem(camposimu,13)) %Térmico
                reflint{b} = cell(1,nnosx);
            end
            
            
            if simu ~= 3
                rfemagdk{b} = cell(1,Tx-nnosx*(nsdx-1)); %Para reflexão EM
            end
            
            
            for bb = 1:nnosx %varredura horizontal
                malha{b}{bb} = zeros(2,portassimu);
                entdk{b}(bb) = enta(1,(b-1)*nnosx + bb);
                
                if simu ~= 3
                    rfemagdk{b}{bb}(1,:) = rfemag{(b-1)*nnosx + bb}(1,:);
                    rfemagdk{b}{bb}(2,:) = rfemag{(b-1)*nnosx + bb}(2,:);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    reflint{b}{bb}(1,:) = reflintn{(b-1)*nnosx + bb}(1,:);
                    reflint{b}{bb}(2,:) = reflintn{(b-1)*nnosx + bb}(2,:);
                    
                    for afig = 1:size(fig,2)
                        if enta(1,(b-1)*nnosx + bb) == fig(afig)
                            
                            malha{b}{bb}(2,inter:end) = [1 1]*Tempinmatriz(afig);
                            malha{b}{bb}(1,inter:end) = [1 1]*Tempinmatriz(afig);
                            
                            break
                        end
                    end
                end
            end
        end
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
elseif dimenmalha == 2
    malha = cell(nsdy,nsdx); %Variável que contém as informações dos nós
    entdk = cell(nsdy,nsdx); %Variável que contém as informações dos meios na malha
    resul.r1 = cell(nsdy,nsdx); %Variavel que irá conter os resultados
    
    if simu == 1
        Tbs = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios EM
        Tbdk = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios EM
        rfemagdk = cell(nsdy,nsdx);%reflexões internas EM
        if (~rem(camposimu,13)) %Térmico
            Tbster = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios T
            Tbterdk = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios T
            reflint = cell(nsdy,nsdx); %Reflexões internas
            portassimu = 9; %Variável que diz o número de portas do nó
            inter = 6; % Para colocar as temperaturas
        else
            Tbster = 0;
            Tbterdk = 0;
            portassimu = 5;
            reflint = 0;
            inter = 6; % Para colocar as temperaturas
        end
        
    elseif simu == 2
        Tbs = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios EM
        Tbdk = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios EM
        rfemagdk = cell(nsdy,nsdx);%reflexões internas EM
        Tbster = 0;
        Tbterdk = 0;
        portassimu = 5; %Variável que diz o número de portas do nó
        reflint = 0;
        
    elseif simu == 3
        Tbs = 0;
        Tbdk = 0;
        rfemagdk = 0;
        Tbster = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios T
        Tbterdk = cell(nsdy,nsdx); %Fazer a transmissão de informação dos subdomínios T
        reflint = cell(nsdy,nsdx); %Reflexões internas
        portassimu = 4; %Variável que diz o número de portas do nó
        inter = 1;
        
    end
    
    
    
    
    for b = 1:nsdx
        for a = 1:nsdy
            if a == nsdy && b == nsdx
                %quando for o último
                malha{a,b} = cell(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1));
                entdk{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1));
                resul.r1{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1),nkres,quantcampo);
                
                
                
                
                if simu ~= 3
                    Tbs{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1));
                    Tbdk{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1));
                    rfemagdk{a,b} = cell(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1)); %Reflexão EM
                end
                
                if (~rem(camposimu,13)) %Térmico
                    Tbterdk{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1),2);
                    Tbster{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1));
                    reflint{a,b} = cell(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1)); %Para calcular a Temperatura
                end
                
                
                
                
                
                for bb = 1:(Tx-nnosx*(nsdx-1)) %varredura horizontal
                    for aa = 1:(Ty-nnosy*(nsdy-1)) %varredura vertical
                        malha{a,b}{aa,bb} = zeros(2,portassimu);
                        %criando a matriz de cada nó onde tenho na primeira
                        %linha as tensões incidentaes, na segunda as tensões refletidas
                        
                        entdk{a,b}(aa,bb) = enta((a-1)*nnosy + aa,(b-1)*nnosx + bb);
                        
                        if simu ~= 3
                            rfemagdk{a,b}{aa,bb}(1,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            rfemagdk{a,b}{aa,bb}(2,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            rfemagdk{a,b}{aa,bb}(3,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            rfemagdk{a,b}{aa,bb}(4,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                        end
                        
                        if (~rem(camposimu,13)) %Térmico
                            
                            reflint{a,b}{aa,bb}(1,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            reflint{a,b}{aa,bb}(2,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            reflint{a,b}{aa,bb}(3,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            reflint{a,b}{aa,bb}(4,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                            
                            for afig = 1:size(fig,2)
                                if enta((a-1)*nnosy + aa,(b-1)*nnosx + bb) == fig(afig)
                                    
                                    % Temperatura Inicial
                                    malha{a,b}{aa,bb}(2,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    malha{a,b}{aa,bb}(1,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    
                                    break
                                end
                            end
                        end
                    end
                end
                
                %|-|-|-|
                %|_|_|_|
                %|_|_|x|
                %inferior e direito
                %ajustando as fronteiras, somente possui lado inferior e direito
                
                for bb = 2:((Tx-nnosx*(nsdx-1)) - 1) %varredura horizontal
                    
                    if simu ~= 3
                        %ajustando o Tbs
                        %lado inferior
                        Tbdk{a,b}(end,bb) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        %lado inferior
                        if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(end,bb,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(end,bb,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                            
                        elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(end,(nsdx-1)*nnosx + bb);
                            Tbterdk{a,b}(end,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(end,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(end,(nsdx-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(end,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [size(Tbterdk{a,b},1) bb size(Tbterdk{a,b},1) bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(end,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                    
                end
                
                
                bb = 1;
                if simu ~= 3
                    %lado esquerdo inferior
                    Tbdk{a,b}(end-1,2) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                        Tbterdk{a,b}(end-1,2,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        Tbterdk{a,b}(end-1,2,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                        meio = enta(end,(nsdx-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        Tbterdk{a,b}(end-1,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                        %1 - meio, 2 - temperatura, 3 - característica da fronteira
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                        meio = enta(end,(nsdx-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        FSBF(vff,:) = [a b];
                        FNOF(vff,:) = [(size(Tbterdk{a,b},1)-1) 2 size(Tbterdk{a,b},1) bb];
                        FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                        Tbterdk{a,b}(end-1,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                        switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                            case 1
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = 0;
                            case 2
                                FCOF(vff,3) = 0;
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            case 3
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                        end
                        vff = vff + 1;
                    end
                end
                
                bb = (Tx-nnosx*(nsdx-1));
                if simu ~= 3
                    %lado direito inferior
                    Tbdk{a,b}(end-1,end-1) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    
                    if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                        Tbterdk{a,b}(end-1,end-1,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        Tbterdk{a,b}(end-1,end-1,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                        meio = enta(end,(nsdx-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        Tbterdk{a,b}(end-1,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                        %1 - meio, 2 - temperatura, 3 - característica da fronteira
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                        meio = enta(end,(nsdx-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        FSBF(vff,:) = [a b];
                        FNOF(vff,:) = [(size(Tbterdk{a,b},1)-1) (size(Tbterdk{a,b},2)-1) size(Tbterdk{a,b},1) bb];
                        FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                        Tbterdk{a,b}(end-1,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                        switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                            case 1
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = 0;
                            case 2
                                FCOF(vff,3) = 0;
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            case 3
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                        end
                        vff = vff + 1;
                    end
                end
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                for aa = 1:(Ty-nnosy*(nsdy-1)) %varredura vertical
                    if simu ~= 3
                        %lado direito
                        Tbdk{a,b}(aa,end) = valorfronteira(1, fronthorizontal( 1, (a-1)*nnosy + aa ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        %lado direito
                        
                        if valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 1
                            Tbterdk{a,b}(aa,end,1) =  valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1);
                            Tbterdk{a,b}(aa,end,2) =  valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2);
                        elseif valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 2
                            meio = enta((nsdy-1)*nnosy + aa,end);
                            Tbterdk{a,b}(aa,end,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1), 1);
                            Tbterdk{a,b}(aa,end,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1),...
                                valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2), 1);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 3
                            meio = enta((nsdy-1)*nnosy + aa,end);
                            Tbterdk{a,b}(aa,end,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1), 1);
                            meiofron = valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [aa size(Tbterdk{a,b},2) aa size(Tbterdk{a,b},2)];
                            FCOF(vff,1) = valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2); %temperatura
                            Tbterdk{a,b}(aa,end,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2), 1); %condução
                            switch valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                            end
                            vff = vff + 1;
                        end
                        
                    end
                end
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            elseif a == nsdy
                %quando for o último da linha de baixo
                malha{a,b} = cell(Ty-nnosy*(nsdy-1),nnosx);
                entdk{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx);
                resul.r1{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx,nkres,quantcampo);
                
                
                if simu ~= 3
                    Tbs{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx);
                    Tbdk{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx);
                    rfemagdk{a,b} = cell(Ty-nnosy*(nsdy-1),nnosx);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    Tbster{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx);
                    Tbterdk{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1),2);
                    reflint{a,b} = cell(Ty-nnosy*(nsdy-1),nnosx); %Para calcular a Temperatura
                end
                
                for bb = 1:nnosx %varredura horizontal
                    for aa = 1:(Ty-nnosy*(nsdy-1)) %varredura vertical
                        
                        malha{a,b}{aa,bb} = zeros(2,portassimu);
                        entdk{a,b}(aa,bb) = enta((a-1)*nnosy + aa,(b-1)*nnosx + bb);
                        
                        if simu ~= 3
                            rfemagdk{a,b}{aa,bb}(1,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            rfemagdk{a,b}{aa,bb}(2,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            rfemagdk{a,b}{aa,bb}(3,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            rfemagdk{a,b}{aa,bb}(4,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                        end
                        
                        if (~rem(camposimu,13)) %Térmico
                            
                            reflint{a,b}{aa,bb}(1,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            reflint{a,b}{aa,bb}(2,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            reflint{a,b}{aa,bb}(3,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            reflint{a,b}{aa,bb}(4,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                            
                            for afig = 1:size(fig,2)
                                if enta((a-1)*nnosy + aa,(b-1)*nnosx + bb) == fig(afig)
                                    
                                    malha{a,b}{aa,bb}(2,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    malha{a,b}{aa,bb}(1,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    
                                    break
                                end
                            end
                        end
                    end
                end
                
                
                %|-|-|-|
                %|_|_|_|
                %|_|x|_|
                %inferior
                
                %|-|-|-|
                %|_|_|_|
                %|x|_|_|
                %inferior esquerdo
                
                %ajustando as fronteiras
                for bb = 2:(nnosx - 1) %varredura horizontal
                    if simu ~= 3
                        %ajustando o Tbs
                        %lado inferior
                        Tbdk{a,b}(end,bb) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        
                        if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(end,bb,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(end,bb,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                        elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(end,(b-1)*nnosx + bb);
                            Tbterdk{a,b}(end,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(end,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(end,(b-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(end,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [size(Tbterdk{a,b},1) bb size(Tbterdk{a,b},1) bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(end,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                end
                
                bb = 1;
                if simu ~= 3
                    %lado esquerdo inferior
                    Tbdk{a,b}(end-1,2) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    
                    if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                        Tbterdk{a,b}(end-1,2,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        Tbterdk{a,b}(end-1,2,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                        
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                        meio = enta(end,(b-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        Tbterdk{a,b}(end-1,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                        %1 - meio, 2 - temperatura, 3 - característica da fronteira
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                        meio = enta(end,(b-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        FSBF(vff,:) = [a b];
                        FNOF(vff,:) = [(size(Tbterdk{a,b},1)-1) 2 size(Tbterdk{a,b},1) bb];
                        FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                        Tbterdk{a,b}(end-1,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                        switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                            case 1
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = 0;
                            case 2
                                FCOF(vff,3) = 0;
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            case 3
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                        end
                        vff = vff + 1;
                    end
                end
                
                
                bb = nnosx;
                if simu ~= 3
                    %lado direito inferior
                    Tbdk{a,b}(end-1,end-1) = valorfronteira(1, frontvertical( 2, (b-1)*nnosx + bb ,1) ,1);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    if valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 1
                        Tbterdk{a,b}(end-1,end-1,1) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        Tbterdk{a,b}(end-1,end-1,2) =  valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2);
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 2
                        meio = enta(end,(b-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        Tbterdk{a,b}(end-1,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1),...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2);
                        %1 - meio, 2 - temperatura, 3 - característica da fronteira
                    elseif valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,3) == 3
                        meio = enta(end,(b-1)*nnosx + bb);
                        Tbterdk{a,b}(end-1,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1), 2);
                        meiofron = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,1);
                        FSBF(vff,:) = [a b];
                        FNOF(vff,:) = [(size(Tbterdk{a,b},1)-1) (size(Tbterdk{a,b},2)-1) size(Tbterdk{a,b},1) bb];
                        FCOF(vff,1) = valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2); %temperatura
                        Tbterdk{a,b}(end-1,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                            valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                        switch valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,4)
                            case 1
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = 0;
                            case 2
                                FCOF(vff,3) = 0;
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            case 3
                                FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                        end
                        vff = vff + 1;
                    end
                end
                
                if b == 1
                    for aa = 1:(Ty-nnosy*(nsdy-1)) %varredura vertical
                        if simu ~= 3
                            %lado esquerdo
                            Tbdk{a,b}(aa,1) = valorfronteira(1, fronthorizontal( 2, (a-1)*nnosy + aa ,1) ,1);
                        end
                        
                        if (~rem(camposimu,13)) %Térmico
                            if valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 1
                                Tbterdk{a,b}(aa,1,1) =  valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1);
                                Tbterdk{a,b}(aa,1,2) =  valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2);
                            elseif valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 2
                                meio = enta((a-1)*nnosy + aa ,1);
                                Tbterdk{a,b}(aa,1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1), 1);
                                Tbterdk{a,b}(aa,1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1),...
                                    valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2), 1);
                                %1 - meio, 2 - temperatura, 3 - característica da fronteira
                            elseif valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 3
                                meio = enta((a-1)*nnosy + aa ,1);
                                Tbterdk{a,b}(aa,1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1), 1);
                                meiofron = valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1);
                                FSBF(vff,:) = [a b];
                                FNOF(vff,:) = [aa 1 aa 1];
                                FCOF(vff,1) = valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2); %temperatura
                                Tbterdk{a,b}(aa,1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                    valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2), 1); %condução
                                switch valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,4)
                                    case 1
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                        FCOF(vff,4) = 0;
                                    case 2
                                        FCOF(vff,3) = 0;
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                    case 3
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                end
                                vff = vff + 1;
                            end
                            
                        end
                    end
                end
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            elseif b == nsdx
                %quando for o da direita
                
                malha{a,b} = cell(nnosy,Tx-nnosx*(nsdx-1));
                entdk{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1));
                resul.r1{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1),nkres,quantcampo);
                
                if simu ~= 3
                    Tbs{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1));
                    Tbdk{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1));
                    rfemagdk{a,b} = cell(nnosy,Tx-nnosx*(nsdx-1));
                end
                
                if (~rem(camposimu,13)) %Térmico
                    Tbster{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1));
                    Tbterdk{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1),2);
                    reflint{a,b} = cell(nnosy,Tx-nnosx*(nsdx-1)); %Para calcular a Temperatura
                end
                
                
                
                
                
                for bb = 1:(Tx-nnosx*(nsdx-1)) %varredura horizontal
                    for aa = 1:nnosy %varredura vertical
                        
                        malha{a,b}{aa,bb} = zeros(2,portassimu);
                        entdk{a,b}(aa,bb) = enta((a-1)*nnosy + aa,(b-1)*nnosx + bb);
                        
                        if simu ~= 3
                            rfemagdk{a,b}{aa,bb}(1,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            rfemagdk{a,b}{aa,bb}(2,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            rfemagdk{a,b}{aa,bb}(3,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            rfemagdk{a,b}{aa,bb}(4,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                        end
                        
                        if (~rem(camposimu,13)) %Térmico
                            
                            reflint{a,b}{aa,bb}(1,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            reflint{a,b}{aa,bb}(2,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            reflint{a,b}{aa,bb}(3,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            reflint{a,b}{aa,bb}(4,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                            
                            for afig = 1:size(fig,2);
                                if enta((a-1)*nnosy + aa,(b-1)*nnosx + bb) == fig(afig)
                                    
                                    malha{a,b}{aa,bb}(2,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    malha{a,b}{aa,bb}(1,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    
                                    break
                                end
                            end
                        end
                    end
                end
                
                
                %|-|-|x|
                %|_|_|_|
                %|_|_|_|
                %superior e direito
                %|-|-|-|
                %|_|_|x|
                %|_|_|_|
                %direito
                if a == 1
                    
                    %ajustando as fronteiras
                    for bb = 2:((Tx-nnosx*(nsdx-1)) - 1) %varredura horizontal
                        if simu ~= 3
                            %ajustando o Tbs
                            %lado superior
                            Tbdk{a,b}(1,bb) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                        end
                        if (~rem(camposimu,13)) %Térmico
                            if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                                Tbterdk{a,b}(1,bb,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                                Tbterdk{a,b}(1,bb,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                            elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                                meio = enta(1,(b-1)*nnosx + bb);
                                Tbterdk{a,b}(1,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                                Tbterdk{a,b}(1,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                    valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                                %1 - meio, 2 - temperatura, 3 - característica da fronteira
                            elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                                meio = enta(1,(b-1)*nnosx + bb);
                                meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                                Tbterdk{a,b}(1,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                                FSBF(vff,:) = [a b];
                                FNOF(vff,:) = [1 bb 1 bb];
                                FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                                Tbterdk{a,b}(1,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                    valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                                switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                    case 1
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                        FCOF(vff,4) = 0;
                                    case 2
                                        FCOF(vff,3) = 0;
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                    case 3
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                end
                                vff = vff + 1;
                            end
                        end
                    end
                    
                    
                    bb = 1;
                    if simu ~= 3
                        %lado esquerdo superior
                        Tbdk{a,b}(2,2) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(2,2,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,2,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                            
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(1,(b-1)*nnosx + bb);
                            Tbterdk{a,b}(2,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(2,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(1,(b-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [2 2 1 bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(2,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                    
                    
                    bb = (Tx-nnosx*(nsdx-1));
                    if simu ~= 3
                        %lado direito superior
                        Tbdk{a,b}(2,end-1) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(2,end-1,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,end-1,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                            
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(1,(b-1)*nnosx + bb);
                            Tbterdk{a,b}(2,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(2,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(1,(b-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [2 (size(Tbterdk{a,b},2)-1) 1 bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(2,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                    
                end
                
                
                
                for aa = 1:(nnosy) %varredura vertical
                    if simu ~= 3
                        %lado direito
                        Tbdk{a,b}(aa,end) = valorfronteira(1, fronthorizontal( 1, (a-1)*nnosy + aa ,1) ,1);
                    end
                    if (~rem(camposimu,13)) %Térmico
                        if valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 1
                            Tbterdk{a,b}(aa,end,1) =  valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1);
                            Tbterdk{a,b}(aa,end,2) =  valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2);
                        elseif valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 2
                            meio = enta((a-1)*nnosy + aa,end);
                            Tbterdk{a,b}(aa,end,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1), 1);
                            Tbterdk{a,b}(aa,end,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1),...
                                valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2), 1);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,3) == 3
                            meio = enta((a-1)*nnosy + aa,end);
                            Tbterdk{a,b}(aa,end,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1), 1);
                            meiofron = valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,1);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [aa size(Tbterdk{a,b},2) aa size(Tbterdk{a,b},2)];
                            FCOF(vff,1) = valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2); %temperatura
                            Tbterdk{a,b}(aa,end,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,2), 1); %condução
                            switch valorfronteira(2, fronthorizontal( 1, (a-1)*nnosy + aa ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                end
                
                
                
                
                
                
                
                
                
                
                
                
                
                
            else
                %todos os demais casos
                
                malha{a,b} = cell(nnosy,nnosx);
                entdk{a,b} = zeros(nnosy,nnosx);
                resul.r1{a,b} = zeros(nnosy,nnosx,nkres,quantcampo);
                
                
                
                if simu ~= 3
                    Tbs{a,b} = zeros(nnosy,nnosx);
                    Tbdk{a,b} = zeros(nnosy,nnosx);
                    rfemagdk{a,b} = cell(nnosy,nnosx);
                end
                
                if (~rem(camposimu,13)) %Térmico
                    Tbster{a,b} = zeros(nnosy,nnosx);
                    Tbterdk{a,b} = zeros(nnosy,nnosx,2);
                    reflint{a,b} = cell(nnosy,nnosx);
                end
                
                
                
                
                
                for bb = 1:nnosx %varredura horizontal
                    for aa = 1:nnosy %varredura vertical
                        
                        malha{a,b}{aa,bb} = zeros(2,portassimu);
                        entdk{a,b}(aa,bb) = enta((a-1)*nnosy + aa,(b-1)*nnosx + bb);
                        
                        if simu ~= 3
                            rfemagdk{a,b}{aa,bb}(1,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            rfemagdk{a,b}{aa,bb}(2,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            rfemagdk{a,b}{aa,bb}(3,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            rfemagdk{a,b}{aa,bb}(4,:) = rfemag{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                        end
                        
                        if (~rem(camposimu,13)) %Térmico
                            reflint{a,b}{aa,bb}(1,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(1,:);
                            reflint{a,b}{aa,bb}(2,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(2,:);
                            reflint{a,b}{aa,bb}(3,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(3,:);
                            reflint{a,b}{aa,bb}(4,:) = reflintn{(a-1)*nnosy + aa,(b-1)*nnosx + bb}(4,:);
                            
                            for afig = 1:size(fig,2)
                                if enta((a-1)*nnosy + aa,(b-1)*nnosx + bb) == fig(afig)
                                    
                                    
                                    
                                    malha{a,b}{aa,bb}(2,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    malha{a,b}{aa,bb}(1,inter:end) = [1 1 1 1]*Tempinmatriz(afig);
                                    
                                    break
                                end
                            end
                        end
                    end
                end
                
                %|x|-|-|
                %|_|_|_|
                %|_|_|_|
                %superior esquerdo
                %|-|-|-|
                %|x|_|_|
                %|_|_|_|
                %esquerdo
                %|-|x|-|
                %|_|_|_|
                %|_|_|_|
                %superior
                
                if a == 1
                    %ajustando as fronteiras
                    for bb = 2:(nnosx - 1) %varredura horizontal
                        if simu ~= 3
                            %ajustando o Tbs
                            %lado cima
                            Tbdk{a,b}(1,bb) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                        end
                        if (~rem(camposimu,13)) %Térmico
                            if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                                Tbterdk{a,b}(1,bb,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                                Tbterdk{a,b}(1,bb,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                            elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                                meio = enta(1,(b-1)*nnosx + bb);
                                Tbterdk{a,b}(1,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                                Tbterdk{a,b}(1,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                    valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                                %1 - meio, 2 - temperatura, 3 - característica da fronteira
                            elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                                meio = enta(1,(b-1)*nnosx + bb);
                                meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                                Tbterdk{a,b}(1,bb,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                                FSBF(vff,:) = [a b];
                                FNOF(vff,:) = [1 bb 1 bb];
                                FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                                Tbterdk{a,b}(1,bb,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                    valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                                switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                    case 1
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                        FCOF(vff,4) = 0;
                                    case 2
                                        FCOF(vff,3) = 0;
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                    case 3
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                end
                                vff = vff + 1;
                            end
                        end
                    end
                    
                    
                    
                    bb = 1;
                    if simu ~= 3
                        %lado esquerdo superior
                        Tbdk{a,b}(2,2) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(2,2,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,2,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(1,(b-1)*nnosx + bb);
                            Tbterdk{a,b}(2,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(2,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(1,(b-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,2,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [2 2 1 bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(2,2,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                    
                    
                    bb = nnosx;
                    if simu ~= 3
                        %lado direito superior
                        Tbdk{a,b}(2,end-1) = valorfronteira(1, frontvertical( 1, (b-1)*nnosx + bb ,1) ,1);
                    end
                    
                    if (~rem(camposimu,13)) %Térmico
                        if valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 1
                            Tbterdk{a,b}(2,end-1,1) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,end-1,2) =  valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2);
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 2
                            meio = enta(end,(b-1)*nnosx + bb);
                            Tbterdk{a,b}(2,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1), 2);
                            Tbterdk{a,b}(2,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1),...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2);
                            %1 - meio, 2 - temperatura, 3 - característica da fronteira
                        elseif valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,3) == 3
                            meio = enta(1,(b-1)*nnosx + bb);
                            meiofron = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,1);
                            Tbterdk{a,b}(2,end-1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, 2);
                            FSBF(vff,:) = [a b];
                            FNOF(vff,:) = [2 (size(Tbterdk{a,b},2)-1) 1 bb];
                            FCOF(vff,1) = valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2); %temperatura
                            Tbterdk{a,b}(2,end-1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,2), 2); %condução
                            switch valorfronteira(2, frontvertical( 1, (b-1)*nnosx + bb ,2) ,4)
                                case 1
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = 0;
                                case 2
                                    FCOF(vff,3) = 0;
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                                case 3
                                    FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (b-1)*nnosx + bb ,2) ,2), meio, meiofron, 2); %convecção
                                    FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 2); %radiação
                            end
                            vff = vff + 1;
                        end
                    end
                end
                
                
                if b == 1
                    for aa = 1:(nnosy) %varredura vertical
                        if simu ~= 3
                            %lado esquerdo
                            Tbdk{a,b}(aa,1) = valorfronteira(1, fronthorizontal( 2, (a-1)*nnosy + aa ,1) ,1);
                        end
                        if (~rem(camposimu,13)) %Térmico
                            if valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 1
                                Tbterdk{a,b}(aa,1,1) =  valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1);
                                Tbterdk{a,b}(aa,1,2) =  valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2);
                            elseif valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 2
                                meio = enta((a-1)*nnosy + aa,1);
                                Tbterdk{a,b}(aa,1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1), 1);
                                Tbterdk{a,b}(aa,1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1),...
                                    valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2), 1);
                                %1 - meio, 2 - temperatura, 3 - característica da fronteira
                            elseif valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,3) == 3
                                meio = enta((a-1)*nnosy + aa ,1);
                                Tbterdk{a,b}(aa,1,1) = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1), 1);
                                meiofron = valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,1);
                                FSBF(vff,:) = [a b];
                                FNOF(vff,:) = [aa 1 aa 1];
                                FCOF(vff,1) = valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2); %temperatura
                                Tbterdk{a,b}(aa,1,2) = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron,...
                                    valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,2), 1); %condução
                                switch valorfronteira(2, fronthorizontal( 2, (a-1)*nnosy + aa ,2) ,4)
                                    case 1
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                        FCOF(vff,4) = 0;
                                    case 2
                                        FCOF(vff,3) = 0;
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                    case 3
                                        FCOF(vff,3) = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, valorfronteira(2, frontvertical( 2, (a-1)*nnosy + aa ,2) ,2), meio, meiofron, 1); %convecção
                                        FCOF(vff,4) = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, 1); %radiação
                                end
                                vff = vff + 1;
                            end
                        end
                        
                    end
                end
                
            end
        end
    end
end
end