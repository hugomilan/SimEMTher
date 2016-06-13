function conv = convadvbi (Zterx, Ztery, Z2c, Kter, diaanimal, meio, meiofron)
global Pressao calesp Tempin 

peesp = 2*3481.9648*Pressao/(Tempin(meio) + Tfron);
kterconv = calesp(meio)*(1.88e-5 + 1.324e-7*(Tempin(meio) + Tfron + 546)/2);
visco = 1.3291e-5 + 9e-8*(Tempin(meio) + Tfron + 546)/2;
Pra = peesp*calesp(meio)*visco/kterconv;
Gra = gravidade*diaanimal(meio)^2*(Tempin(meio) - Tfron)/Tempin(meio);
Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;

conv = Kter(meiofron)*Nu/diaanimal(meio)...
    *(Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));
