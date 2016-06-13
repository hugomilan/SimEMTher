function [MaG, resul] = euniter (MaG, Tb, c, efon, foninter, ...
    tfuncao, funcao, nos, Ster, Pin, tt, resul, reflint, ZG2n, entdk)

quantfonte = size(funcao,2);

Tx = size(MaG,2);
if tt == 1
    %MaG{:}(1,:) => Incidente no passo c+1 e depois refletida no passo c+1
    %MaG{:}(2,:) => Refletida no passo c.
    if efon == 1
        
        b = 1; %primeira coluna
        meio = entdk(b); %segunda coluna mostra 1 para esquerdo e 2 para direito
        MaG{b}(1,1) = [MaG{b}(2,1) Tb(1)]*reflint{b}(1,:)';%Esquerdo
        MaG{b}(1,2) = [MaG{b}(2,2) MaG{b+1}(2,1)]*reflint{b}(2,:)';%direito
        
        fun2 = 0;
        for fong = 1:quantfonte
            if tfuncao(fong) >= c && Pin(b,fong) == fong
                if nos(fong,3) == 10
                    fun2 = funcao{fong}(c) + fun2;
                end
            end
        end
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio) + fun2;
        
        %calculo das tensoes refletidas
        MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        
        
        
        
        
        b = Tx; %ultima coluna
        meio = entdk(b);
        MaG{b}(1,1) = [MaG{b}(2,1) MaG{b-1}(2,2)]*reflint{b}(1,:)';
        MaG{b}(1,2) = [MaG{b}(2,2) Tb(2)]*reflint{b}(2,:)';
        
        
        
        fun2 = 0;
        for fong = 1:quantfonte
            if tfuncao(fong) >= c && Pin(b,fong) == fong
                if nos(fong,3) == 10
                    fun2 = funcao{fong}(c) + fun2;
                end
            end
        end
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio) + fun2;
        
        %calculo das tensoes refletidas
        MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        
        
        for b = 2:(Tx-1) %varredura horizontal
            %tensão incidente para a funcao
            meio = entdk(b);
            MaG{b}(1,1) = [MaG{b}(2,1) MaG{b-1}(2,2)]*reflint{b}(1,:)';
            MaG{b}(1,2) = [MaG{b}(2,2) MaG{b+1}(2,1)]*reflint{b}(2,:)';
            
            
            fun2 = 0;
            for fong = 1:quantfonte
                if tfuncao(fong) >= c && Pin(b,fong) == fong
                    if nos(fong,3) == 10
                        fun2 = funcao{fong}(c) + fun2;
                    end
                end
            end
            
            %calculo da Temperatura
            resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio) + fun2;
            
            %calculo das tensoes refletidas
            MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        end
        
        
    else
        %sem fonte
        b = 1; %primeira coluna
        meio = entdk(b);
        MaG{b}(1,1) = [MaG{b}(2,1) Tb(1)]*reflint{b}(1,:)';%Esquerdo
        MaG{b}(1,2) = [MaG{b}(2,2) MaG{b+1}(2,1)]*reflint{b}(2,:)';%direito
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio);
        
        %calculo das tensoes refletidas
        MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio); %no posicionado em (b)
        
        
        
        
        
        b = Tx; %ultima coluna
        meio = entdk(b);
        MaG{b}(1,1) = [MaG{b}(2,1) MaG{b-1}(2,2)]*reflint{b}(1,:)';
        MaG{b}(1,2) = [MaG{b}(2,2) Tb(2)]*reflint{b}(2,:)';
        
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio);
        
        %calculo das tensoes refletidas
        MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio); %no posicionado em (b)
        
        
        for b = 2:(Tx-1) %varredura horizontal
            %tensão incidente para a funcao
            meio = entdk(b);
            MaG{b}(1,1) = [MaG{b}(2,1) MaG{b-1}(2,2)]*reflint{b}(1,:)';
            MaG{b}(1,2) = [MaG{b}(2,2) MaG{b+1}(2,1)]*reflint{b}(2,:)';
            
            
            %calculo da Temperatura
            resul(b,1) = sum(MaG{b}(1,1:2))*ZG2n(meio) + foninter(meio);
            
            %calculo das tensoes refletidas
            MaG{b}(1,1:2) = Ster{meio}*(MaG{b}(1,1:2))' + foninter(meio); %no posicionado em (b)
            %             MaG{b}(1,1:2)
            %             pause
        end
    end
else
    %% tt ~= 1
    %MaG{:}(2,:) => Incidente no passo c+1 e depois refletida no passo c+1
    %MaG{:}(1,:) => Refletida no passo c.
    if efon == 1
        
        b = 1; %primeira coluna
        meio = entdk(b);
        MaG{b}(2,1) = [MaG{b}(1,1) Tb(1)]*reflint{b}(1,:)';%Esquerdo
        MaG{b}(2,2) = [MaG{b}(1,2) MaG{b+1}(1,1)]*reflint{b}(2,:)';%direito
        
        fun2 = 0;
        for fong = 1:quantfonte
            if tfuncao(fong) >= c && Pin(b,fong) == fong
                if nos(fong,3) == 10
                    fun2 = funcao{fong}(c) + fun2;
                end
            end
        end
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio) + fun2;
        
        %calculo das tensoes refletidas
        MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        
        
        
        
        
        b = Tx; %ultima coluna
        meio = entdk(b);
        MaG{b}(2,1) = [MaG{b}(1,1) MaG{b-1}(1,2)]*reflint{b}(1,:)';
        MaG{b}(2,2) = [MaG{b}(1,2) Tb(2)]*reflint{b}(2,:)';
        
        
        fun2 = 0;
        for fong = 1:quantfonte
            if tfuncao(fong) >= c && Pin(b,fong) == fong
                if nos(fong,3) == 10
                    fun2 = funcao{fong}(c) + fun2;
                end
            end
        end
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio) + fun2;
        
        %calculo das tensoes refletidas
        MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        
        
        for b = 2:(Tx-1) %varredura horizontal
            %tensão incidente para a funcao
            meio = entdk(b);
            MaG{b}(2,1) = [MaG{b}(1,1) MaG{b-1}(1,2)]*reflint{b}(1,:)';
            MaG{b}(2,2) = [MaG{b}(1,2) MaG{b+1}(1,1)]*reflint{b}(2,:)';
            
            fun2 = 0;
            for fong = 1:quantfonte
                if tfuncao(fong) >= c && Pin(b,fong) == fong
                    if nos(fong,3) == 10
                        fun2 = funcao{fong}(c) + fun2;
                    end
                end
            end
            
            %calculo da Temperatura
            resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio) + fun2;
            
            %calculo das tensoes refletidas
            MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio) + fun2; %no posicionado em (b)
        end
        
        
    else
        %sem fonte
        b = 1; %primeira coluna
        meio = entdk(b);
        MaG{b}(2,1) = [MaG{b}(1,1) Tb(1)]*reflint{b}(1,:)';%Esquerdo
        MaG{b}(2,2) = [MaG{b}(1,2) MaG{b+1}(1,1)]*reflint{b}(2,:)';%direito
        
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio);
        
        %calculo das tensoes refletidas
        MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio); %no posicionado em (b)
        
        
        
        
        
        b = Tx; %ultima coluna
        meio = entdk(b);
        MaG{b}(2,1) = [MaG{b}(1,1) MaG{b-1}(1,2)]*reflint{b}(1,:)';
        MaG{b}(2,2) = [MaG{b}(1,2) Tb(2)]*reflint{b}(2,:)';
        
        %calculo da Temperatura
        resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio);
        
        %calculo das tensoes refletidas
        MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio); %no posicionado em (b)
        
        
        for b = 2:(Tx-1) %varredura horizontal
            %tensão incidente para a funcao
            meio = entdk(b);
            MaG{b}(2,1) = [MaG{b}(1,1) MaG{b-1}(1,2)]*reflint{b}(1,:)';
            MaG{b}(2,2) = [MaG{b}(1,2) MaG{b+1}(1,1)]*reflint{b}(2,:)';
            
            
            %calculo da Temperatura
            resul(b,1) = sum(MaG{b}(2,1:2))*ZG2n(meio) + foninter(meio);
            
            %calculo das tensoes refletidas
            MaG{b}(2,1:2) = Ster{meio}*(MaG{b}(2,1:2))' + foninter(meio); %no posicionado em (b)
        end
    end
end