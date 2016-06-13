function coetrans = transfrontbi(meio, Rterx, Rtery, Zterx, Ztery, Z2c, IF, Gter, meiofron, Temp, dire)
%dire = 1 => x
%dire = 2 => y
if dire == 1
    
    coetrans = 2*(Zterx(meio))/...
    (Rterx(meio) + Rterx(meiofron) + Zterx(meio) + Zterx(meiofron))*...
    (Temp*(2*Z2c(meiofron) - 2*Gter(meiofron)*Zterx(meiofron)*Ztery(meiofron))...
    + Zterx(meiofron)*Ztery(meiofron)*IF(meiofron))/(4*(Zterx(meiofron) + Ztery(meiofron)));

elseif dire == 2
    
    coetrans = 2*(Ztery(meio))/...
    (Rtery(meio) + Rtery(meiofron) + Ztery(meio) + Ztery(meiofron))*...
    (Temp*(2*Z2c(meiofron) - 2*Gter(meiofron)*Zterx(meiofron)*Ztery(meiofron))...
    + Zterx(meiofron)*Ztery(meiofron)*IF(meiofron))/(4*(Zterx(meiofron) + Ztery(meiofron)));
    
end

end