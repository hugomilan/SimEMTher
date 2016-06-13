function mensg = seg2dhms (toc2)

nd = floor(toc2/86400);                                      %dias
hres = floor(24*(toc2/86400 - nd));                          %horas
mres = floor((60*(24*(toc2/86400 - nd) - hres)));            %minutos
sres = round(60*(60*(24*(toc2/86400 - nd) - hres) - mres));  %segundos

if nd == 0
    if hres == 0
        if mres == 0
            if sres == 0
                msres = round(toc2*1000);
                mensg = [num2str(msres), 'ms'];
            else
                mensg = [num2str(sres), 's'];
            end
        else
            mensg = [num2str(mres), 'm ',num2str(sres), 's'];
        end
    else
        mensg = [num2str(hres),'h ', num2str(mres), 'm ',num2str(sres), 's'];
    end
else
    mensg = [num2str(nd), ' dias e ',num2str(hres),'h ', num2str(mres), 'm ',num2str(sres), 's'];
end

end