function mensg = tertemp (toc2)

cr = clock;
cm = 0;bm = 0; th = 1;                                       %utilizados no calculo
nd = floor(toc2/86400);                                      %dias
hH = floor(24*(toc2/86400 - nd));                            %horas
mM = floor((60*(24*(toc2/86400 - nd) - hH)));                %minutos
sS = round(60*(60*(24*(toc2/86400 - nd) - hH) - mM));        %segundos


sres = round(cr(6)) + sS;
if (round(cr(6)) + sS) >= 60
    sres = round(cr(6)) + sS - 60;
    cm = 1;
end

mres = cr(5) + mM + cm;
if (cr(5) + mM + cm) >= 60
    mres = cr(5) + mM + cm - 60;
    bm = 1;
end
hres = cr(4) + hH + bm;
while th == 1
    if hres >= 24
        hres = hres - 24;
        nd = nd + 1;
    else
        th = 0;
    end
end

if nd == 0
    mensg = ['às ',num2str(hres),'h ', num2str(mres), 'm ',num2str(sres), 's.'];
else
    mensg = ['para daqui ', num2str(nd), ' dias às ',num2str(hres),'h ', num2str(mres), 'm ',num2str(sres), 's.'];
end

end