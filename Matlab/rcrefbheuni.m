function ro = rcrefbheuni(ent,rb,Zter,Rter,pos)

% Calcula o coeficiente de reflexão entre os nós
%1 - Esquerda
%2 - Direita

if pos == 1
    ro = (Rter(ent(1,rb)) - Zter(ent(1,rb)) + Rter(ent(1,rb-1)) + Zter(ent(1,rb-1)))/...
        (Rter(ent(1,rb)) + Zter(ent(1,rb)) + Rter(ent(1,rb-1)) + Zter(ent(1,rb-1)));
elseif pos == 2
    ro = (Rter(ent(1,rb)) - Zter(ent(1,rb)) + Rter(ent(1,rb+1)) + Zter(ent(1,rb+1)))/...
        (Rter(ent(1,rb)) + Zter(ent(1,rb)) + Rter(ent(1,rb+1)) + Zter(ent(1,rb+1)));
end
end