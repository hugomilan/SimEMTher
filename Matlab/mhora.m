function [toc1] = mhora(cl,cc,toc1)

if cl == 0
    toc3 = toc;
    toc2 = toc3 - toc1;
    msg1 = seg2dhms(toc2);
    msg2 = tertemp(toc2*9);
    cr = clock;
    disp (['Tempo gasto em 10%: ', msg1, ' às ', num2str(cr(4)), 'h ', ...
        num2str(cr(5)),'m ', num2str(round(cr(6))), 's. Término estimado ', msg2])
    
else
    
    toc3 = toc;
    toc2 = toc3 - toc1;
    cr = clock;
    msg1 = seg2dhms(toc3);
    msg2 = tertemp((cl-cc-1)*toc2);
    if ((cc+1)*100/cl) == 100
        disp (['Tempo gasto em ', num2str((cc+1)*100/cl), '%: ', msg1, ...
            ' às ',num2str(cr(4)),'h ',num2str(cr(5)),'m ',...
            num2str(round(cr(6))),'s. Salvando...'])
    else
        disp (['Tempo gasto em ', num2str((cc+1)*100/cl), '%: ', msg1, ...
            ' às ',num2str(cr(4)),'h ',num2str(cr(5)),'m ',...
            num2str(round(cr(6))),'s. Término estimado ', msg2])
    end
    
    
    toc1 = toc3;
    
end