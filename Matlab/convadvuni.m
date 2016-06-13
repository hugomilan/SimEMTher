function conv = convadvuni(Zter, Gter, Kter, diaanimal, Tfron, meio, meiofron)

conv = Kter(meiofron)/diaanimal(meio)...
    *Zter(meio)/(Zter(meio)*Gter(meio) + 2);
