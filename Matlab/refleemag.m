function ro = refleemag(ent,ra,rb,YLTx,YLTy,pos)

% Calcula o coeficiente de reflexão entre os nós

if pos == 1
    ro = (YLTy(ent(ra,rb)) - YLTy(ent(ra+1,rb)))/(YLTy(ent(ra+1,rb)) + YLTy(ent(ra,rb)));
elseif pos == 2
    ro = (YLTx(ent(ra,rb)) - YLTx(ent(ra,rb-1)))/(YLTx(ent(ra,rb-1)) + YLTx(ent(ra,rb)));
elseif pos == 3
    ro = (YLTy(ent(ra,rb)) - YLTy(ent(ra-1,rb)))/(YLTy(ent(ra-1,rb)) + YLTy(ent(ra,rb)));
elseif pos == 4
    ro = (YLTx(ent(ra,rb)) - YLTx(ent(ra,rb+1)))/(YLTx(ent(ra,rb+1)) + YLTx(ent(ra,rb)));
end
end