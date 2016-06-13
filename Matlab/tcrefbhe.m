function tau = tcrefbhe(ent,ra,rb,Zterx,Ztery,Rterx,Rtery,pos)

% Calcula o coeficiente de reflexão entre os nós

if pos == 1
    tau = (2*Ztery(ent(ra,rb)))/...
         (Rtery(ent(ra,rb)) + Ztery(ent(ra,rb)) + Rtery(ent(ra+1,rb)) + Ztery(ent(ra+1,rb)));
elseif pos == 2
    tau = (2*Zterx(ent(ra,rb)))/...
         (Rterx(ent(ra,rb)) + Zterx(ent(ra,rb)) + Rterx(ent(ra,rb-1)) + Zterx(ent(ra,rb-1)));
elseif pos == 3
    tau = (2*Ztery(ent(ra,rb)))/...
         (Rtery(ent(ra,rb)) + Ztery(ent(ra,rb)) + Rtery(ent(ra-1,rb)) + Ztery(ent(ra-1,rb)));
elseif pos == 4
    tau = (2*Zterx(ent(ra,rb)))/...
         (Rterx(ent(ra,rb)) + Zterx(ent(ra,rb)) + Rterx(ent(ra,rb+1)) + Zterx(ent(ra,rb+1)));
end
end