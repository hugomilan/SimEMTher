function textosimular(handles)

global idioma simu camposimu TEM carregar versao dimenmalha

if idioma == 1
    msgtitulofig = versao;
    msgsimu = 'Simulate';
    if dimenmalha == 1
        msgtitulo = 'Transmission-Line Matrix One-Dimensional';
    elseif dimenmalha == 2
        msgtitulo = 'Transmission-Line Matrix Two-Dimensional';
    end
    msgtemp = 'Temperature';
    msgret = 'Return';
    msgcarre = 'Load Previous Result';
    
    
elseif idioma == 2
    msgtitulofig = versao;
    msgsimu = 'Simulate';
    if dimenmalha == 1
        msgtitulo = 'Transmission-Line Matrix Unidimensional';
    elseif dimenmalha == 2
        msgtitulo = 'Transmission-Line Matrix Bidimensional';
    end
    msgtemp = 'Temperatura';
    msgret = 'Retornar';
    msgcarre = 'Carregar Resultado Anterior';
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.text3,'string',msgsimu)
set(handles.text2,'string',msgtitulo)
set(handles.uipanel1,'title',msgsimu)
set(handles.chTerm,'string',msgtemp)
set(handles.btnSimular,'string',msgsimu)
set(handles.btnRetornar,'string',msgret)
set(handles.cbcarregar,'string',msgcarre)




if simu == 1
    
    set(handles.cbHx,'Visible','on')
    set(handles.cbHy,'Visible','on')
    set(handles.cbEz,'Visible','on')
    set(handles.cbSAR,'Visible','on')
    set(handles.chTerm,'Visible','on')
    
elseif simu == 2
    
    set(handles.cbHx,'Visible','on')
    set(handles.cbHy,'Visible','on')
    set(handles.cbEz,'Visible','on')
    set(handles.cbSAR,'Visible','on')
    
    set(handles.chTerm,'Visible','off')
    
    if (~rem(camposimu,13))
        camposimu = camposimu/13;
    end
    
elseif simu == 3
    
    set(handles.chTerm,'Visible','on')
    
    set(handles.cbHx,'Visible','off')
    
    if (~rem(camposimu,2))
        camposimu = camposimu/2;
    end
    set(handles.cbHy,'Visible','off')
    
    if (~rem(camposimu,3))
        camposimu = camposimu/3;
    end
    
    set(handles.cbEz,'Visible','off')
    
    if (~rem(camposimu,7))
        camposimu = camposimu/7;
    end
    
    set(handles.cbSAR,'Visible','off')
    
    if (~rem(camposimu,11))
        camposimu = camposimu/11;
    end
    
end

if (~rem(camposimu,2))
    set(handles.cbHx,'Value',1)
else
    set(handles.cbHx,'Value',0)
end

if (~rem(camposimu,3))
    set(handles.cbHy,'Value',1)
else
    set(handles.cbHy,'Value',0)
end

if (~rem(camposimu,7))
    set(handles.cbEz,'Value',1)
else
    set(handles.cbEz,'Value',0)
end

if (~rem(camposimu,11))
    set(handles.cbSAR,'Value',1)
else
    set(handles.cbSAR,'Value',0)
end

if (~rem(camposimu,13))
    set(handles.chTerm,'Value',1)
else
    set(handles.chTerm,'Value',0)
end

if TEM == 2
    set(handles.cbHx,'string','Ex')
    set(handles.cbHy,'string','Ey')
    set(handles.cbEz,'string','Hz')
end

if carregar == 0
    set(handles.cbcarregar,'value',0)
elseif carregar == 1
    set(handles.cbcarregar,'value',1)
end