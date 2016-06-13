function textoresulgui (handles)
global idioma dimenmalha camposimu TEM versao

if idioma == 1
    msgtitulofig = versao;
    msgtitulo = 'Results';
    if dimenmalha == 1
        dimenvisi = 'off';
    elseif dimenmalha == 2
        dimenvisi = 'on';
    end
    msgpaicamp = 'Field';
    msgptemp = 'Temperature';
    msgpaivisu = 'Visualize';
    
    msgest = 'Static';
    msgpont = 'Punctual';
    msgcampx = 'x Field';
    msgcampy = 'y Field';
    msgcont = 'Contour';
    
    msgdin = 'Dinamic';
    msgpxy = 'x and y Propagation';
    if TEM == 1
        msgvmag = 'Vector Magnetic Field';
    elseif TEM == 2
        msgvmag = 'Vector Electric Field';
    else
        msgvmag = '';
    end
    msgpropx = 'x Propagation';
    msgpropy = 'y Propagation';
    
    msgtempk = 'k Time';
    msgposix = 'x position';
    msgposiy = 'y Position';
    
    msgretornar = 'Return';
    msgbtvisu = 'Visualize';
    
    msgfreqin = 'Freq. Range';
        
elseif idioma == 2
    msgtitulofig = versao;
    msgtitulo = 'Resultados';
    if dimenmalha == 1
        dimenvisi = 'off';
    elseif dimenmalha == 2
        dimenvisi = 'on';
    end
    msgpaicamp = 'Campo';
    msgptemp = 'Temperatura';
    msgpaivisu = 'Visualizar';
    
    msgest = 'Estático';
    msgpont = 'Pontual';
    msgcampx = 'Campo em x';
    msgcampy = 'Campo em y';
    msgcont = 'Contorno';
    
    msgdin = 'Dinamico';
    msgpxy = 'Propagação em x e y';
    if TEM == 1
        msgvmag = 'Vetores do campo magnético';
    elseif TEM == 2
        msgvmag = 'Vetores do campo elétrico';
    else
        msgvmag = '';
    end
    
    msgpropx = 'Propagação em x';
    msgpropy = 'Propagação em y';
    
    msgtempk = 'Tempo em k';
    msgposix = 'Posição em x';
    msgposiy = 'Posição em y';
    
    msgretornar = 'Retornar';
    msgbtvisu = 'Visualizar';
    
    msgfreqin = 'Range de Freq.';
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.text1,'string',msgtitulo)
set(handles.uipanel1,'title',msgpaicamp)
set(handles.rbtemp,'string',msgptemp)
set(handles.uipanel3,'title',msgpaivisu)
set(handles.text5,'string',msgest)
set(handles.pont,'string',msgpont)
set(handles.campox,'string',msgcampx)
set(handles.campoy,'string',msgcampy)
set(handles.contornoestatico,'string',msgcont)
set(handles.contornodinamico,'string',msgcont)
set(handles.text6,'string',msgdin)
set(handles.prop,'string',msgpxy)
set(handles.vet,'string',msgvmag)
set(handles.propx,'string',msgpropx)
set(handles.propy,'string',msgpropy)
set(handles.text2,'string',msgtempk)
set(handles.text3,'string',msgposix)
set(handles.text4,'string',msgposiy)
set(handles.retorno,'string',msgretornar)
set(handles.pushbutton1,'string',msgbtvisu)
set(handles.freqintxt,'string',msgfreqin,'visible','off')
set(handles.freqined,'visible','off')


%deixando a tela invisivel
set(handles.axes1,'visible','off')

if (~rem(camposimu,13))
    set(handles.rbtemp,'Visible','on')
    set(handles.rbtemp,'Value',1)
else
    set(handles.rbtemp,'Visible','off')
end

if (~rem(camposimu,11))
    set(handles.cSAR,'Visible','on')
    set(handles.cSAR,'Value',1)
else
    set(handles.cSAR,'Visible','off')
end

if (~rem(camposimu,7))
    set(handles.cez,'Visible','on')
    set(handles.cez,'value',1)
else
    set(handles.cez,'Visible','off')
end

if (~rem(camposimu,3))
    set(handles.chy,'Visible','on')
    set(handles.chy,'value',1)
else
    set(handles.chy,'Visible','off')
    set(handles.vet,'Visible','off')
end

if (~rem(camposimu,2))
    set(handles.chx,'Visible','on')
    set(handles.chx,'value',1)
else
    set(handles.chx,'Visible','off')
    set(handles.vet,'Visible','off')
end

if (~rem(camposimu,6))
    visimag = 'on';
else
    visimag = 'off';
end

set(handles.text4,'visible',dimenvisi)
set(handles.yres,'visible',dimenvisi)
set(handles.prop,'visible',dimenvisi)
set(handles.propy,'visible',dimenvisi)
set(handles.contornodinamico,'visible',dimenvisi)
set(handles.vet,'visible',dimenvisi)
set(handles.vet,'visible',visimag)
set(handles.contornoestatico,'visible',dimenvisi)
set(handles.campoy,'visible',dimenvisi)

if dimenmalha == 1
    set(handles.propx,'value',1)
end

if TEM == 2
    set(handles.chx,'string','Ex')
    set(handles.chy,'string','Ey')
    set(handles.cez,'string','Hz')
end