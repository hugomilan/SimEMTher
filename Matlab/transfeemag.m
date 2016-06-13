function tau = transfeemag(ent,ra,rb,YLTx,YLTy,pos)

% Calcula o coeficiente de reflexão entre os nós

if pos == 1
    tau = (2*YLTy(ent(ra+1,rb)))/(YLTy(ent(ra+1,rb)) + YLTy(ent(ra,rb)));
elseif pos == 2
    tau = (2*YLTx(ent(ra,rb-1)))/(YLTx(ent(ra,rb-1)) + YLTx(ent(ra,rb)));
elseif pos == 3
    tau = (2*YLTy(ent(ra-1,rb)))/(YLTy(ent(ra-1,rb)) + YLTy(ent(ra,rb)));
elseif pos == 4
    tau = (2*YLTx(ent(ra,rb+1)))/(YLTx(ent(ra,rb+1)) + YLTx(ent(ra,rb)));
end
end