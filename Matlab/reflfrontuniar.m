function coerefl = reflfrontuniar(meio, Rter, Zter, a)
global Rterar Zterar
if a == 1
coerefl = (Rter(meio) + Rterar - Zter(meio) + Zterar)/(...
    Rter(meio) + Rterar + Zter(meio) + Zterar);
else
    coerefl = (Rter(meio) + Rterar - Zterar + Zter(meio))/(...
    Rter(meio) + Rterar + Zter(meio) + Zterar);
end

end
                   