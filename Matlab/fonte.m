function [funcao, tfuncao, Pin3m, Pindk, nosfon] = fonte(dt, ...
    ent, k, nnosy, nnosx, Tx, Ty, nsdy, nsdx, dl, fatex, fatey, fathzx, fathzy, Zc, Zter, Gter, YLTx, YLTy, ...
    Yc, simu, TE, TM)
global fontedk quantfonte dimenmalha
%Pin2m é a matriz do tamanho da malha que recebe 1 no ponto em que há
%uma entrada de fonte.
%Pindk é a matriz do tamanho dos subdomínios que recebe 1 no subdomínio
%em que há entrada de fonte.
%Pin3m é a matriz celular com subdomínios onde os subdomínios que
%contêm uma entrada de fonte recebem uma matriz com 1 nos pontos dos
%subdomínios que contêm a fonte.
if dimenmalha == 1
    Pindk = zeros(1,nsdx);
    Pin3m = cell(1,nsdx);
    
    %arrumando Pin3m
    if quantfonte
        tfuncao = zeros(1,quantfonte);
        funcao = cell(1,quantfonte);
        nosfon = zeros(quantfonte,3);
        for b = 1:nsdx
            if b == nsdx
                Pin3m{b} = zeros(Tx-nnosx*(nsdx-1),quantfonte);
            else
                Pin3m{b} = zeros(nnosx,quantfonte);
            end
        end
        for qf = 1:quantfonte
            for pa = 1:Ty
                for pb = 1:Tx
                    if fontedk{qf,1}(pb) == qf
                        Pin = pb;
                        if ceil(pb/nnosx) > nsdx
                            Pindk(nsdx) = 1;
                            
                            Pin3m{nsdx}(...                %x celular
                                (pb - nnosx*(nsdx - 1)),qf) = qf;   %x
                        else
                            
                            Pindk(ceil(pb/nnosx)) = 1;
                            
                            
                            Pin3m{ceil(pb/nnosx)}(...                %x celular
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = qf;   %x
                        end
                        
                    else
                        if ceil(pb/nnosx) > nsdx
                            
                            Pin3m{nsdx}(...                %x celular
                               (pb - nnosx*(nsdx - 1)),qf) = 0;   %x
                            
                        else
                            
                            Pin3m{ceil(pb/nnosx)}(...                %x celular
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = 0;   %x
                            
                        end
                    end
                end
            end
            
            fonte = fontedk{qf,3}(2);
            
            switch fontedk{qf,2}
                case 1                  %Hx ou Ez
                    if simu ~=3
                        if TM == 1
                            fcamp = dl/YLTx(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [1 0 0 0 0];
                        elseif TE == 1
                            fcamp = -0.5/fatex(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [1 0 1 0 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 2                  %Hy ou Ey
                    if simu ~= 3
                        if TM == 1
                            fcamp = dl/YLTy(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [0 0 0 1 0];
                        elseif TE == 1
                            fcamp = -0.5/fatey(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [0 1 0 1 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 3                  %Ez ou Hz
                    if simu ~= 3
                        if TM == 1
                            fcamp = -Yc(ent(Pin(2),Pin(1)))*dl/(4*(YLTy(ent(Pin(2),Pin(1))) + YLTx(ent(Pin(2),Pin(1)))));
                            nosfon(qf,:) = [1 1 1 1 0];
                        elseif TE == 1
                            fcamp = Zc(ent(Pin(2),Pin(1)))/(fathzy(ent(Pin(2),Pin(1))) + fathzx(ent(Pin(2),Pin(1))));
                            nosfon(qf,:) = [1 0 0 1 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 4                  %Calor
                    if simu ~= 2
                        aent = ent(Pin(2),Pin(1));
                        
                        fcamp = Zter(aent)./(Zter(aent).*Gter(aent) + 2);
                        nosfon(qf,:) = [1 1 10]';
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0]';
                    end
            end
            
            
            
            if fonte == 1
                
                %criando a funcao seno
                f  = fontedk{qf,3}(3);
                Amp = fontedk{qf,3}(4);
                teta = fontedk{qf,3}(5);
                tsen = fontedk{qf,3}(6);
                tfuncao(qf) = tsen;
                funcao{qf} = @(tseno) Amp*fcamp*sin(2*pi*f*dt*tseno + teta);
                
            elseif fonte == 2
                
                tfuncao(qf) = k;
                ugauss = fontedk{qf,3}(3);
                Amp = fontedk{qf,3}(4);
                ogauss = fontedk{qf,3}(5);
                
                funcao{qf} = @(x) Amp*fcamp*exp(-0.5*((x - ugauss)/ogauss).^2)/(ogauss*sqrt(2*pi));
                
            elseif fonte == 3
                tpulso = fontedk{qf,3}(4);
                Amp = fontedk{qf,3}(3);
                funcao{qf} = @(x) Amp*fcamp;
                tfuncao(qf) = tpulso;
            elseif fonte == 4
                
                funcao{qf} = fontedk{qf,4}*fcamp;
                tfuncao(qf) = fontedk{qf,3}(3);
            end
        end
    else
        funcao = 0;
        tfuncao = 0;
        nosfon = [0 0 0];
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
elseif dimenmalha == 2
    Pindk = zeros(nsdy,nsdx);
    Pin3m = cell(nsdy,nsdx);
    
    %arrumando Pin3m
    if quantfonte
        tfuncao = zeros(1,quantfonte);
        funcao = cell(1,quantfonte);
        nosfon = zeros(quantfonte,5);
        for b = 1:nsdx
            for a = 1:nsdy
                if a == nsdy && b == nsdx
                    Pin3m{a,b} = zeros(Ty-nnosy*(nsdy-1),Tx-nnosx*(nsdx-1),quantfonte);
                elseif a == nsdy
                    Pin3m{a,b} = zeros(Ty-nnosy*(nsdy-1),nnosx,quantfonte);
                elseif a == nsdx
                    Pin3m{a,b} = zeros(nnosy,Tx-nnosx*(nsdx-1),quantfonte);
                else
                    Pin3m{a,b} = zeros(nnosy,nnosx,quantfonte);
                end
            end
        end
        for qf = 1:quantfonte
            for pa = 1:Ty
                for pb = 1:Tx
                    if fontedk{qf,1}(pa,pb) == qf
                        Pin = [pb pa];
                        if ceil(pa/nnosy) > nsdy && ceil(pb/nnosx) > nsdx
                            Pindk(nsdy, ...
                                nsdx) = 1;
                            
                            Pin3m{nsdy, ...              %y celular
                                nsdx}(...                %x celular
                                (pa - nnosy*(nsdy-1)), ...    %y
                                (pb - nnosx*(nsdx - 1)),qf) = qf;   %x
                            
                        elseif ceil(pa/nnosy) > nsdy
                            
                            Pindk(nsdy, ...
                                ceil(pb/nnosx)) = 1;
                            
                            
                            Pin3m{nsdy, ...              %y celular
                                ceil(pb/nnosx)}(...                %x celular
                                ...
                                (pa - nnosy*(nsdy-1)), ...    %y
                                ...
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = qf;   %x
                            
                        elseif ceil(pb/nnosx) > nsdx
                            
                            Pindk(ceil(pa/nnosy), ...
                                nsdx) = 1;
                            
                            
                            Pin3m{ceil(pa/nnosy), ...              %y celular
                                nsdx}(...                %x celular
                                ...
                                round((pa/nnosy - ...              %y
                                ceil(pa/nnosy) + 1)*nnosy), ...    %y
                                ...
                                (pb - nnosx*(nsdx - 1)),qf) = qf;   %x
                            
                        else
                            
                            Pindk(ceil(pa/nnosy), ...
                                ceil(pb/nnosx)) = 1;
                            
                            
                            Pin3m{ceil(pa/nnosy), ...              %y celular
                                ceil(pb/nnosx)}(...                %x celular
                                ...
                                round((pa/nnosy - ...              %y
                                ceil(pa/nnosy) + 1)*nnosy), ...    %y
                                ...
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = qf;   %x
                            
                        end
                    else
                        if ceil(pa/nnosy) > nsdy && ceil(pb/nnosx) > nsdx
                            
                            Pin3m{nsdy, ...              %y celular
                                nsdx}(...                %x celular
                                (pa - nnosy*(nsdy-1)), ...    %y
                                (pb - nnosx*(nsdx - 1)),qf) = 0;   %x
                            
                        elseif ceil(pa/nnosy) > nsdy
                            
                            Pin3m{nsdy, ...              %y celular
                                ceil(pb/nnosx)}(...                %x celular
                                ...
                                (pa - nnosy*(nsdy-1)), ...    %y
                                ...
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = 0;   %x
                            
                        elseif ceil(pb/nnosx) > nsdx
                            
                            Pin3m{ceil(pa/nnosy), ...              %y celular
                                nsdx}(...                %x celular
                                ...
                                round((pa/nnosy - ...              %y
                                ceil(pa/nnosy) + 1)*nnosy), ...    %y
                                ...
                                (pb - nnosx*(nsdx - 1)),qf) = 0;   %x
                            
                        else
                            
                            Pin3m{ceil(pa/nnosy), ...              %y celular
                                ceil(pb/nnosx)}(...                %x celular
                                ...
                                round((pa/nnosy - ...              %y
                                ceil(pa/nnosy) + 1)*nnosy), ...    %y
                                ...
                                round((pb/nnosx - ...              %x
                                ceil(pb/nnosx) + 1)*nnosx),qf) = 0;   %x
                            
                        end
                    end
                end
            end
            
            fonte = fontedk{qf,3}(2);
            
            switch fontedk{qf,2}
                case 1                  %Hx ou Ex
                    if simu ~=3
                        if TM == 1
                            fcamp = 0.5*dl/YLTx(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [-1 0 1 0 0];
                        elseif TE == 1
                            fcamp = -0.5*fatex(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [1 0 1 0 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 2                  %Hy ou Ey
                    if simu ~= 3
                        if TM == 1
                            fcamp = 0.5*dl/YLTy(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [0 1 0 -1 0];
                        elseif TE == 1
                            fcamp = -0.5*fatey(ent(Pin(2),Pin(1)));
                            nosfon(qf,:) = [0 1 0 1 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 3                  %Ez ou Hz
                    if simu ~= 3
                        if TM == 1
                            fcamp = -Yc(ent(Pin(2),Pin(1)))*dl/(4*(YLTy(ent(Pin(2),Pin(1))) + YLTx(ent(Pin(2),Pin(1)))));
                            nosfon(qf,:) = [1 1 1 1 0];
                        elseif TE == 1
                            fcamp = Zc(ent(Pin(2),Pin(1)))/(fathzy(ent(Pin(2),Pin(1))) + fathzx(ent(Pin(2),Pin(1))) + 2);
                            nosfon(qf,:) = [1 -1 -1 1 0];
                        end
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0];
                    end
                case 4                  %Calor
                    if simu ~= 2
                        aent = ent(Pin(2),Pin(1));
                        
                        fcamp = dl^3.*Zter(aent)./(Zter(aent).*Gter(aent) + 4);
                        nosfon(qf,:) = [1 1 1 1 10]';
                    else
                        fcamp = 0;
                        nosfon(qf,:) = [0 0 0 0 0]';
                    end
            end
            
            
            
            if fonte == 1
                
                %criando a funcao seno
                f  = fontedk{qf,3}(3);
                Amp = fontedk{qf,3}(4);
                teta = fontedk{qf,3}(5);
                tsen = fontedk{qf,3}(6);
                tfuncao(qf) = tsen;
                funcao{qf} = @(tseno) Amp*fcamp*sin(2*pi*f*dt*tseno + teta);
                
            elseif fonte == 2
                
                tfuncao(qf) = k;
                ugauss = fontedk{qf,3}(3);
                Amp = fontedk{qf,3}(4);
                ogauss = fontedk{qf,3}(5);
                
                funcao{qf} = @(x) Amp*fcamp*exp(-0.5*((x - ugauss)/ogauss).^2)/(ogauss*sqrt(2*pi));
                
            elseif fonte == 3
                tpulso = fontedk{qf,3}(4);
                Amp = fontedk{qf,3}(3);
                funcao{qf} = @(x) Amp*fcamp;
                tfuncao(qf) = tpulso;
            elseif fonte == 4
                
                funcao{qf} = fontedk{qf,4}*fcamp;
                tfuncao(qf) = fontedk{qf,3}(3);
            end
        end
    else
        funcao = 0;
        tfuncao = 0;
        nosfon = [0 0 0 0 0];
    end
end

end