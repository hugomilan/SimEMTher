function rad = radfront(Zter, Gter, dl, emis, meio, meiofron)

csb = 5.67058e-8;           %Constante de Steffan-Boltzman

rad = emis(meio)*emis(meiofron)*csb/...
    (emis(meio) + emis(meiofron) + emis(meio)*emis(meiofron))...
    *(Zter(meio)/(2*dl));
%     *Zter(meio)*(Zter(meio)*Gter(meio) + 2)/(4*dl);