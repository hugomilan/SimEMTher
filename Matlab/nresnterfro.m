function [] = nresnterfro (k, nres, cl, resul, malha, Tbster, nsdy, nsdx, ...
    tfuncao, funcao, nos, Ster, Tbterdk, Pin3m, Pindk, entdk, foninter, ...
    nnosx, nnosy, toc1, Tx, Ty, reflint, Zfatx, Zfaty, FSBF, FNOF, FCOF)
global saltosimu
%ajustando para a localização dos subdomínios
sw1 = zeros(1,nsdx-2);
sw2 = zeros(1,nsdx-2);
sw1(1) = 1 + nsdy;
sw2(1) = nsdy*2;
for ps1 = 1:nsdx
    if ps1 <= nsdx - 2 && ps1 ~= 1
        sw1(ps1) = sw1(ps1-1) + nsdy;
        sw2(ps1) = sw2(ps1-1) + nsdy;
    end
end
tt = 1;
%% nres ~= 1
%preparação para as diferentes res.
nkres = ceil(k/nres); %numero de passos-de-tempo por variável
tcl = 1; %verificar o clock
ck = ceil((k-1)/cl);
cc = 0;
ttc = 1;
ajuscc = 1;
for ares = 1:(nres-1); %varrendo os resul
    bres = ['r',num2str(ares)];
    nr = ((ares - 1)*nkres);
    
    if ares*nkres < (cc+1)*ck
        
        for c = ((ares - 1)*nkres+1):ares*nkres
            if tt == 1
                mt = 2;
                
            elseif tt == 2
                mt = 1;
                
            end
            
            [Tbster Tbterdk] = vartergen(mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2);
            
            for bp = 1:nsdx*nsdy
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                end
            end
            
            
            %perdas por fluxo na fronteira. Mudança na refletida e na temp.
            [malha, resul.(bres)] = calcfroflu(malha, resul.(bres), tt,  FSBF, ...
                FNOF, FCOF, ceil((c-nr-1)/saltosimu)+1, 1, 0);
            
            
            if tt == 1
                tt = 2;
            elseif tt == 2
                tt = 1;
            end
        end
        
        ajuscc = ares*nkres - cc*ck + 1;
        
        
    elseif ares*nkres >= (cc+1)*ck %se for igual ou maior que a porcentagem
        while  ttc == 1
            if ares*nkres >= (cc+1)*ck %quantas variaveis precisam ser simuladas?
                
                for c = (cc*ck+ajuscc):(cc + 1)*ck
                    if tt == 1
                        mt = 2;
                        
                    elseif tt == 2
                        mt = 1;
                        
                    end
                    
                    [Tbster Tbterdk] = vartergen(mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2);
                    
                    for bp = 1:nsdx*nsdy
                        if Pindk(bp) == 1
                            [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                                Tbster{bp}, c, 1,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                        else
                            [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                                Tbster{bp}, c, 0,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                        end
                    end
                    
                    
                    %perdas por fluxo na fronteira. Mudança na refletida e na temp.
            [malha, resul.(bres)] = calcfroflu(malha, resul.(bres), tt,  FSBF, ...
                FNOF, FCOF, ceil((c-nr-1)/saltosimu)+1, 1, 0);
                    
                    
                    if tt == 1
                        tt = 2;
                    elseif tt == 2
                        tt = 1;
                    end
                end
                
                %Tempo restante estimado
                toc1 = mhora(cl,cc,toc1);
                
                cc = cc + 1;
                ajuscc = 1;
            elseif (ares*nkres - 1) < (cc+1)*ck
                for c = cc*ck:ares*nkres
                    if tt == 1
                        mt = 2;
                        
                    elseif tt == 2
                        mt = 1;
                        
                    end
                    
                    [Tbster Tbterdk] = vartergen(mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2);
                    
                    for bp = 1:nsdx*nsdy
                        if Pindk(bp) == 1
                            [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                                Tbster{bp}, c, 1,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                        else
                            [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                                Tbster{bp}, c, 0,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                        end
                    end
                    
                    
                    %perdas por fluxo na fronteira. Mudança na refletida e na temp.
                    [malha, resul.(bres)] = calcfroflu(malha, resul.(bres), tt,  FSBF, ...
                        FNOF, FCOF, ceil((c-nr-1)/saltosimu)+1, 1, 0);
                    
                    
                    if tt == 1
                        tt = 2;
                    elseif tt == 2
                        tt = 1;
                    end
                end
                
                ajuscc = ares*nkres - cc*ck + 1;
                break
            end
        end
    end
    
    %% salvar, deletar e criar.
    save(['resul',num2str(ares),'.mat'],'resul')
    clear resul
    
    if ares == (nres-1)
        
        b2res = ['r',num2str(ares+1)];
        
        [resul.(b2res)] = criares(nsdy, nsdx, nnosy, nnosx, Ty, Tx, k - nkres*ares);
        
    else
        
        b2res = ['r',num2str(ares+1)];
        
        
        [resul.(b2res)] = criares(nsdy, nsdx, nnosy, nnosx, Ty, Tx, nkres);
        
    end
end
%% Última varter
if isempty(ares)
    ares = 1;
end
bres = ['r',num2str(nres)];
nr = (nres-1)*nkres;
while  ttc == 1
    if nres*nkres >= (cc+1)*ck
        
        for c = (cc*ck+ajuscc):(cc+1)*ck
            if tt == 1
                mt = 2;
                
            elseif tt == 2
                mt = 1;
                
            end
            
            [Tbster Tbterdk] = vartergen(mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2);
            
            for bp = 1:nsdx*nsdy
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                end
            end
            
            
            %perdas por fluxo na fronteira. Mudança na refletida e na temp.
            [malha, resul.(bres)] = calcfroflu(malha, resul.(bres), tt,  FSBF, ...
                FNOF, FCOF, ceil((c-nr-1)/saltosimu)+1, 1, 0);
            
            
            if tt == 1
                tt = 2;
            elseif tt == 2
                tt = 1;
            end
        end
        
        %Tempo restante estimado
        toc1 = mhora(cl,cc,toc1);
        
        cc = cc + 1;
        ajuscc = 1;
    else
        
        for c = (cc*ck+1):k
            if tt == 1
                mt = 2;
                
            elseif tt == 2
                mt = 1;
                
            end
            
            [Tbster Tbterdk] = vartergen(mt, malha, Tbster, nsdy, nsdx, Tbterdk, sw1, sw2);
            
            for bp = 1:nsdx*nsdy
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,:,ceil((c-nr-1)/saltosimu)+1)] = espter(malha{bp}, ...
                        Tbster{bp}, c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,:,1), reflint{bp}, Zfatx, Zfaty, entdk{bp});
                end
            end
            
            
            %perdas por fluxo na fronteira. Mudança na refletida e na temp.
            [malha, resul.(bres)] = calcfroflu(malha, resul.(bres), tt,  FSBF, ...
                FNOF, FCOF, ceil((c-nr-1)/saltosimu)+1, 1, 0);
            
            
            if tt == 1
                tt = 2;
            elseif tt == 2
                tt = 1;
            end
        end
        break
    end
end
save(['resul',num2str(nres),'.mat'],'resul')
clear resul
%Salvando a malha
if tt == 2
    for bp = 1:nsdx*nsdy
        malha{bp} = salvemalha(malha{bp});
    end
end
save('malhasav.mat','malha')
end