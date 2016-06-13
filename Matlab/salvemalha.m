function [malha] = salvemalha (malha)

Ty = size(malha,1);
Tx = size(malha,2);

for a = 1:Ty
    for b = 1:Tx
        v = malha{a,b}(2,:);
        malha{a,b}(2,:) = malha{a,b}(1,:);
        malha{a,b}(1,:) = v;
    end
end