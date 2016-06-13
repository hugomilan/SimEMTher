function rad = radfrontbi(Zterx, Ztery, Z2c, dl, emis, meio, meiofron, dire)

csb = 5.67058e-8;           %Constante de Steffan-Boltzman
%dire = 1 -> x
%dire = 2 -> y
if dire == 1
    rad = emis(meio)*emis(meiofron)*csb/...
    (emis(meio) + emis(meiofron) + emis(meio)*emis(meiofron))*...
        (Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));
elseif dire == 2
    rad = emis(meio)*emis(meiofron)*csb/...
    (emis(meio) + emis(meiofron) + emis(meio)*emis(meiofron))*...
        (Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));
end
end