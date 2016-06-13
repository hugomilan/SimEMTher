function ro = rcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,pos)

% Calcula o coeficiente de reflexão entre os nós

if pos == 1
    ro = (Rtery(ent(ra,rb)) - Ztery(ent(ra,rb)) + Rtery(ent(ra+1,rb)) + Ztery(ent(ra+1,rb)))/...
         (Rtery(ent(ra,rb)) + Ztery(ent(ra,rb)) + Rtery(ent(ra+1,rb)) + Ztery(ent(ra+1,rb)));
elseif pos == 2
    ro = (Rterx(ent(ra,rb)) - Zterx(ent(ra,rb)) + Rterx(ent(ra,rb-1)) + Zterx(ent(ra,rb-1)))/...
         (Rterx(ent(ra,rb)) + Zterx(ent(ra,rb)) + Rterx(ent(ra,rb-1)) + Zterx(ent(ra,rb-1)));
elseif pos == 3
    ro = (Rtery(ent(ra,rb)) - Ztery(ent(ra,rb)) + Rtery(ent(ra-1,rb)) + Ztery(ent(ra-1,rb)))/...
         (Rtery(ent(ra,rb)) + Ztery(ent(ra,rb)) + Rtery(ent(ra-1,rb)) + Ztery(ent(ra-1,rb)));
elseif pos == 4
    ro = (Rterx(ent(ra,rb)) - Zterx(ent(ra,rb)) + Rterx(ent(ra,rb+1)) + Zterx(ent(ra,rb+1)))/...
         (Rterx(ent(ra,rb)) + Zterx(ent(ra,rb)) + Rterx(ent(ra,rb+1)) + Zterx(ent(ra,rb+1)));
end
end