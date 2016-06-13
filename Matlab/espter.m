function [MaG, resul] = espter (MaG, Tb, c, efon, foninter, ...
    tfuncao, funcao, nos, Ster, Pin, tt, resul, reflint, Zfatx, Zfaty, entdk)

quantfonte = size(funcao,2);

Ty = size(MaG,1);
Tx = size(MaG,2);
if tt == 1
    %MaG{:,:}(1,:) => Incidente no passo c+1 e depois refletida no passo c+1
    %MaG{:,:}(2,:) => Refletida no passo c.
    if efon == 1
        for a = 1:Ty %varredura vertical
            for b = 1:Tx %varredura horizontal
                %tensão incidente para a funcao
                meio = entdk(a,b);
                if a == 1 && b == 1 %primeira linha primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a+1,b+1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 && b == Tx %primeira linha ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a+1,b-1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 %primeira linha
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a,b)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == 1 %ultima linha primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a-1,b+1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == Tx %ultima linha ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a-1,b-1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty %ultima linha
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a,b)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif b == 1 %primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif b == Tx %ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                else %qualquer outro no
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                end
                
                fun2 = 0;
                for fong = 1:quantfonte
                    if tfuncao(fong) >= c && Pin(a,b,fong) == fong
                        if nos(fong,5) == 10
                            fun2 = funcao{fong}(c) + fun2;
                        end
                    end
                end
                
                %calculo da Temperatura
                resul(a,b) = Zfatx(meio)*(MaG{a,b}(1,1) + MaG{a,b}(1,3)) + ...
                    Zfaty(meio)*(MaG{a,b}(1,2) + MaG{a,b}(1,4)) + ...
                    foninter(meio) + fun2;
                
                %calculo das tensoes refletidas
                MaG {a,b}(1,1:4) = Ster{meio}*(MaG {a,b}(1,1:4))' + foninter(meio) + fun2; %no posicionado em (a,b)
            end
        end
    else
        %sem fonte
        for a = 1:Ty %varredura vertical
            for b = 1:Tx %varredura horizontal
                %tensão incidente para a funcao
                meio = entdk(a,b);
                
                
                if a == 1 && b == 1 %primeira linha primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a+1,b+1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 && b == Tx %primeira linha ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a+1,b-1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 %primeira linha
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) Tb(a,b)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == 1 %ultima linha primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a-1,b+1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == Tx %ultima linha ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a-1,b-1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty %ultima linha
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) Tb(a,b)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif b == 1 %primeira coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                    
                elseif b == Tx %ultima coluna
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                else %qualquer outro no
                    MaG{a,b}(1,1) = [MaG{a,b}(2,1) MaG{a+1,b}(2,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(1,2) = [MaG{a,b}(2,2) MaG{a,b-1}(2,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(1,3) = [MaG{a,b}(2,3) MaG{a-1,b}(2,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(1,4) = [MaG{a,b}(2,4) MaG{a,b+1}(2,2)]*reflint{a,b}(4,:)';
                end
                
                %calculo da Temperatura
                resul(a,b) = Zfatx(meio)*(MaG{a,b}(1,1) + MaG{a,b}(1,3)) + ...
                    Zfaty(meio)*(MaG{a,b}(1,2) + MaG{a,b}(1,4)) + ...
                    foninter(meio);
                
                %calculo das tensoes refletidas
                MaG {a,b}(1,1:4) = Ster{meio}*(MaG {a,b}(1,1:4))' + foninter(meio); %no posicionado em (a,b)
            end
        end
    end
else
    %% tt ~= 1
    %MaG{:,:}(2,:) => Incidente no passo c+1 e depois refletida no passo c+1
    %MaG{:,:}(1,:) => Refletida no passo c.
    if efon == 1
        for a = 1:Ty %varredura vertical
            for b = 1:Tx %varredura horizontal
                meio = entdk(a,b);
                %tensão incidente para a funcao
                if a == 1 && b == 1 %primeira linha primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a+1,b+1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 && b == Tx %primeira linha ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a+1,b-1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 %primeira linha
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a,b)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == 1 %ulti1a linha primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a-1,b+1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == Tx %ultima linha ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a-1,b-1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty %ultima linha
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a,b)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif b == 1 %primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif b == Tx %ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                else %qualquer outro no
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                end
                
                
                
                fun2 = 0;
                for fong = 1:quantfonte
                    if tfuncao(fong) >= c && Pin(a,b,fong) == fong
                        if nos(fong,5) == 10
                            fun2 = funcao{fong}(c) + fun2;
                        end
                    end
                end
                
                %calculo da Temperatura
                resul(a,b) = Zfatx(meio)*(MaG{a,b}(2,1) + MaG{a,b}(2,3)) + ...
                    Zfaty(meio)*(MaG{a,b}(2,2) + MaG{a,b}(2,4)) + ...
                    foninter(meio) + fun2;
                
                %calculo das tensoes refletidas
                MaG {a,b}(2,1:4) = Ster{meio}*(MaG {a,b}(2,1:4))' + foninter(meio) + fun2; %no posicionado em (a,b)
                
            end
        end
    else
        
        for a = 1:Ty %varredura vertical
            for b = 1:Tx %varredura horizontal
                meio = entdk(a,b);
                %tensão incidente para a funcao
                if a == 1 && b == 1 %primeira linha primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a+1,b+1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 && b == Tx %primeira linha ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a+1,b-1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == 1 %primeira linha
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) Tb(a,b)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == 1 %ulti1a linha primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a-1,b+1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty && b == Tx %ultima linha ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a-1,b-1)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                elseif a == Ty %ultima linha
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) Tb(a,b)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif b == 1 %primeira coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) Tb(a,b)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                    
                elseif b == Tx %ultima coluna
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) Tb(a,b)]*reflint{a,b}(4,:)';
                    
                else %qualquer outro no
                    MaG{a,b}(2,1) = [MaG{a,b}(1,1) MaG{a+1,b}(1,3)]*reflint{a,b}(1,:)';
                    MaG{a,b}(2,2) = [MaG{a,b}(1,2) MaG{a,b-1}(1,4)]*reflint{a,b}(2,:)';
                    MaG{a,b}(2,3) = [MaG{a,b}(1,3) MaG{a-1,b}(1,1)]*reflint{a,b}(3,:)';
                    MaG{a,b}(2,4) = [MaG{a,b}(1,4) MaG{a,b+1}(1,2)]*reflint{a,b}(4,:)';
                end
                %calculo da Temperatura
                resul(a,b) = Zfatx(meio)*(MaG{a,b}(2,1) + MaG{a,b}(2,3)) + ...
                    Zfaty(meio)*(MaG{a,b}(2,2) + MaG{a,b}(2,4)) + ...
                    foninter(meio);
                
                %calculo das tensoes refletidas
                MaG {a,b}(2,1:4) = Ster{meio}*(MaG {a,b}(2,1:4))' + foninter(meio); %no posicionado em (a,b)
            end
        end
    end
end