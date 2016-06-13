function coetrans = transfrontuniar(meio, Rter, Zter, Temp)
global Rterar Zterar
coetrans = 2*(Zter(meio))/...
    (Rter(meio) + Rterar + Zter(meio) + Zterar)*...
    (Temp/2);

end