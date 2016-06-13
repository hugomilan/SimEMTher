function rad = radfrontuniar(Zter, Gter, emis, meio)

csb = 5.6697e-8;           %Constante de Steffan-Boltzman
% rad = emis(meio)*csb*Zter(meio)/(Zter(meio)*Gter(meio) + 2);

rad = emis(meio)*csb*Zter(meio);