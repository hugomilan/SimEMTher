function conv = convfrontbi(Zterx, Ztery, Z2c, Kter, diaanimal, Tfron, meio, meiofron, dire)
global Pressao Tempin calesp
peesp = 2*3481.9648*Pressao/(Tempin(meio) + Tfron);
kterconv = calesp(meio)*(1.88e-5 + 1.324e-7*(Tempin(meio) + Tfron + 546)/2);
visco = 1.3291e-5 + 9e-8*(Tempin(meio) + Tfron + 546)/2;
Pra = peesp*calesp(meio)*visco/kterconv;
Gra = gravidade*diaanimal(meio)^3*(Tempin(meio) - Tfron)/Tempin(meio);
Nu = (0.6 + 0.387*(Gra*Pra)^(1/6)*(1 + (0.559/Pra)^(9/16))^(-8/27))^2;


%dire = 1 -> x
%dire = 2 -> y
if dire == 1
    conv = Kter(meiofron)*Nu(meiofron)/(Ty*0.5)*...
        (Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));
elseif dire == 2
    conv = Kter(meiofron)*Nu(meiofron)/(Ty*0.5)*...
        (Ztery(meio)*Zterx(meio)/(2*Z2c(meio)));
end
end