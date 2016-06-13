function rad = radfrontuni(Zter, Gter, emis, meio, meiofron)

csb = 5.6697e-8;           %Constante de Steffan-Boltzman
rad = emis(meio)*csb*Zter(meio);