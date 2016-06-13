function rad = radadvbi (Zterx, Ztery, Z2c, dl, emis, Ty, meio, meiofron)

csb = 5.67058e-8;           %Constante de Steffan-Boltzman

rad = emis(meio)*emis(meiofron)*csb/...
    (emis(meio) + emis(meiofron) + emis(meio)*emis(meiofron))...
    *(Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));