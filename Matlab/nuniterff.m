function [] = nuniterff (k, nres, cl, resul, malha, Tbster, nsdx, ...
    tfuncao, funcao, nos, Ster, Tbterdk, Pin3m, Pindk, entdk, foninter, ...
    nnosx, toc1, Tx, reflint, ZG2n)
global saltosimu
tt = 1;
%% nres ~= 1
%preparação para as diferentes res.
nkres = ceil(k/nres); %numero de passos-de-tempo por variável
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
            
            [Tbster Tbterdk] = vunitergen(mt, malha, Tbster, nsdx, Tbterdk);
            
            for bp = 1:nsdx
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                end
            end

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
                    
                    [Tbster Tbterdk] = vunitergen(mt, malha, Tbster, nsdx, Tbterdk);
                    
                    for bp = 1:nsdx
                        if Pindk(bp) == 1
                            [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                                Tbster(bp,:), c, 1,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                        else
                            [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                                Tbster(bp,:), c, 0,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                        end
                    end

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
                    
                    [Tbster Tbterdk] = vunitergen(mt, malha, Tbster, nsdx, Tbterdk);
                    
                    for bp = 1:nsdx
                        if Pindk(bp) == 1
                            [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                                Tbster(bp,:), c, 1,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                        else
                            [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                                Tbster(bp,:), c, 0,  foninter, tfuncao, ...
                                funcao, nos, Ster, Pin3m{bp}, ...
                                tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                        end
                    end

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
        
        [resul.(b2res)] = cunires(nsdx, nnosx, Tx, k - nkres*ares);
        
    else
        
        b2res = ['r',num2str(ares+1)];
        
        
        [resul.(b2res)] = cunires(nsdx, nnosx, Tx, nkres);
        
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
            
            [Tbster Tbterdk] = vunitergen(mt, malha, Tbster, nsdx, Tbterdk);

            for bp = 1:nsdx
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                end
            end

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
            
            [Tbster Tbterdk] = vunitergen(mt, malha, Tbster, nsdx, Tbterdk);
            
            for bp = 1:nsdx
                if Pindk(bp) == 1
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 1,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                else
                    [malha{bp}, resul.(bres){bp}(:,ceil((c-nr-1)/saltosimu)+1)] = euniter(malha{bp}, ...
                        Tbster(bp,:), c, 0,  foninter, tfuncao, ...
                        funcao, nos, Ster, Pin3m{bp}, ...
                        tt, resul.(bres){bp}(:,1), reflint{bp}, ZG2n, entdk{bp});
                end
            end

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
    for bp = 1:nsdx
        malha{bp} = salvemalha(malha{bp});
    end
end
save('malhasav.mat','malha','Tbterdk')
end