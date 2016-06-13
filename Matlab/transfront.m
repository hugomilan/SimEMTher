function coetrans = transfront(meio, Rterx, Rtery, Zterx, Ztery, IF, Gter, meiofron, Temp, dire)
%dire = 1 => x
%dire = 2 => y
if dire == 1
    
    coetrans = 2*(Zterx(meio))/...
    (Rterx(meio) + Rterx(meiofron) + Zterx(meio) + Zterx(meiofron))*...
    (Temp*(2*Z2c(meiofront) - 2*Gter(meiofront)*Zterx(meiofront)*Ztery(meiofront))...
    + Zterx(meiofront)*Ztery(meiofront)*IF(meiofront))/(4*(Zterx(meiofront) + Ztery(meiofront)));

elseif dire == 2
    
    coetrans = 2*(Ztery(meio))/...
    (Rtery(meio) + Rtery(meiofron) + Ztery(meio) + Ztery(meiofron))*...
    (Temp*(2*Z2c(meiofront) - 2*Gter(meiofront)*Zterx(meiofront)*Ztery(meiofront))...
    + Zterx(meiofront)*Ztery(meiofront)*IF(meiofront))/(4*(Zterx(meiofront) + Ztery(meiofront)));
    
end

end