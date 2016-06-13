function coerefl = reflfrontbi(meio, Rterx, Rtery, Zterx, Ztery, meiofron, dire)
%dire = 1 => x; dire = 2 => y
if dire == 1
    coerefl = (Rterx(meio) + Rterx(meiofron) - Zterx(meio) + Zterx(meiofron))/(...
        Rterx(meio) + Rterx(meiofron) + Zterx(meio) + Zterx(meiofron));
elseif dire == 2
    coerefl = (Rtery(meio) + Rtery(meiofron) - Ztery(meio) + Ztery(meiofron))/(...
        Rtery(meio) + Rtery(meiofron) + Ztery(meio) + Ztery(meiofron));
    
end
end
