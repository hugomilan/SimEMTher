function ro = reflmagte(ent,ra,rb,ZTLx,ZTLy,Gy,Gx,pos)

% Calcula o coeficiente de reflexão entre os nós

if pos == 1
    ro = (2*ZTLy(ent(ra+1,rb)) - ZTLy(ent(ra,rb))*(ZTLy(ent(ra+1,rb))*(Gy(ent(ra,rb)) + Gy(ent(ra+1,rb))) + 2))/...
        (2*ZTLy(ent(ra+1,rb)) + ZTLy(ent(ra,rb))*(ZTLy(ent(ra+1,rb))*(Gy(ent(ra,rb)) + Gy(ent(ra+1,rb))) + 2));
elseif pos == 2
    ro = (2*ZTLx(ent(ra,rb-1)) - ZTLx(ent(ra,rb))*(ZTLx(ent(ra,rb-1))*(Gx(ent(ra,rb)) + Gx(ent(ra,rb-1))) + 2))/...
        (2*ZTLx(ent(ra,rb-1)) + ZTLx(ent(ra,rb))*(ZTLx(ent(ra,rb-1))*(Gx(ent(ra,rb)) + Gx(ent(ra,rb-1))) + 2));
elseif pos == 3
    ro = (2*ZTLy(ent(ra-1,rb)) - ZTLy(ent(ra,rb))*(ZTLy(ent(ra-1,rb))*(Gy(ent(ra,rb)) + Gy(ent(ra-1,rb))) + 2))/...
        (2*ZTLy(ent(ra-1,rb)) + ZTLy(ent(ra,rb))*(ZTLy(ent(ra-1,rb))*(Gy(ent(ra,rb)) + Gy(ent(ra-1,rb))) + 2));
elseif pos == 4
    ro = (2*ZTLx(ent(ra,rb+1)) - ZTLx(ent(ra,rb))*(ZTLx(ent(ra,rb+1))*(Gx(ent(ra,rb)) + Gx(ent(ra,rb+1))) + 2))/...
        (2*ZTLx(ent(ra,rb+1)) + ZTLx(ent(ra,rb))*(ZTLx(ent(ra,rb+1))*(Gx(ent(ra,rb)) + Gx(ent(ra,rb+1))) + 2));
end
end