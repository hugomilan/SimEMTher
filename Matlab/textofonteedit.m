function textofonteedit(handles, fontenumdk)

global idioma quantfonte dtTLM fonteimg fontedk simu TEM versao

formond = cell(5,1);
if idioma == 1
    msgtitulofig = versao;
    msgtitulo = 'Source Editor';
    msginse = 'Insert';
    msgrem = 'Remove';
    msgclin = 'Click in Insert';
    msgex = 'Stimulate';
    msgccal = 'Heat';
    msgfan = 'Antenna Shape';
    msgcir = 'Circular';
    msgretan = 'Rectangular';
    msgdiam = 'Diameter';
    msgxcen = 'X Central';
    msgycen = 'Y Central';
    msgxin = 'X Initial';
    msgxfin = 'X Final';
    msgyin = 'Y Initial';
    msgyfin = 'Y Final';
    msgadant = 'Add Antenna';
    msgliant = 'Clear Antenna';
    msgret = 'Return';
    
    
    msgfm = 'Max. Freq.: ';
    msgchy = 'Field Hx (A/m)';
    msgchx = 'Field Hy (A/m)';
    msgcez = 'Field Ez (V/m)';
    msgcc = 'Heat (W/m³)';
    msgf = 'Source ';
    msgos = 'Sinusoidal Wave';
    msgog = 'Gaussian Wave';
    msgogde = 'Displacement = ';
    msgdu = 'Duration = ';
    msgamp = 'Amp = ';
    msgfreq = 'Freq = ';
    msgteta = 'Teta = ';
    msgpul = 'Pulse = ';
    msgoge = 'General Wave';
    formond{1} = 'Function';
    formond{2} = 'Sinusoidal';
    formond{3} = 'Gaussian';
    formond{4} = 'Pulse';
    formond{5} = 'General';
elseif idioma == 2
    msgtitulofig = versao;
    msgtitulo = 'Editor de Fonte';
    msginse = 'Inserir';
    msgrem = 'Remover';
    msgclin = 'Clique em Inserir';
    msgex = 'Excitação';
    msgccal = 'Calor';
    msgfan = 'Forma da Antena';
    msgcir = 'Circular';
    msgretan = 'Retangular';
    msgdiam = 'Diametro';
    msgxcen = 'X Central';
    msgycen = 'Y Central';
    msgxin = 'X Inicial';
    msgxfin = 'X Final';
    msgyin = 'Y Inicial';
    msgyfin = 'Y Final';
    msgadant = 'Adicionar Antena';
    msgliant = 'Remover Antena';
    msgret = 'Retornar';
    
    
    msgfm = 'Freq. Máx.: ';
    msgchy = 'Campo Hx (A/m)';
    msgchx = 'Campo Hy (A/m)';
    msgcez = 'Campo Ez (V/m)';
    msgcc = 'Calor (W/m³)';
    msgf = 'Fonte ';
    msgos = 'Onda Senoidal';
    msgog = 'Onda Gaussiana';
    msgogde = 'Deslocamento = ';
    msgdu = 'Duração = ';
    msgamp = 'Amp = ';
    msgfreq = 'Freq = ';
    msgteta = 'Teta = ';
    msgpul = 'Pulso = ';
    msgoge = 'Onda Genérica';
    formond{1} = 'Função';
    formond{2} = 'Senoidal';
    formond{3} = 'Gaussiana';
    formond{4} = 'Pulso';
    formond{5} = 'Genérica';
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.text22,'string',msgtitulo)
set(handles.infonte,'string',msginse)
set(handles.retfonte,'string',msgrem)
set(handles.numfonte,'string',msgclin)
set(handles.selcampo,'title',msgex)
set(handles.cCalor,'string',msgccal)
set(handles.formant,'title',msgfan)
set(handles.circ,'string',msgcir)
set(handles.quad,'string',msgretan)
set(handles.diam01,'string',msgdiam)
set(handles.diam02,'string',msgxcen)
set(handles.diam03,'string',msgycen)
set(handles.q01,'string',msgxin)
set(handles.q05,'string',msgxfin)
set(handles.q03,'string',msgyin)
set(handles.q07,'string',msgyfin)
set(handles.gante,'string',msgadant)
set(handles.pushbutton8,'string',msgliant)
set(handles.retornar,'string',msgret)
set(handles.formaonda,'string',formond)

msgfm2 = [num2str(1/(10*dtTLM)), ' Hz'];

if (1/(10*dtTLM)) > 1e12
    msgfm2 = [num2str(1/(10*dtTLM*1e12)), ' THz'];
elseif (1/(10*dtTLM)) > 1e9
    msgfm2 = [num2str(1/(10*dtTLM*1e9)), ' GHz'];
elseif(1/(10*dtTLM)) > 1e6
    msgfm2 = [num2str(1/(10*dtTLM*1e6)), ' MHz'];
elseif(1/(10*dtTLM)) > 1e3
    msgfm2 = [num2str(1/(10*dtTLM*1e3)), ' kHz'];
end

set(handles.txtfreq,'string',[msgfm, msgfm2])


if quantfonte == 0
    set(handles.selcampo,'Visible','off')
    set(handles.formant,'Visible','off')
    set(handles.gante,'Visible','off')
    set(handles.pushbutton8,'Visible','off')
    set(handles.formaonda,'Visible','off')
    set(handles.circ,'Value',0)
    set(handles.quad,'Value',0)
else
    set(handles.corfon,'Visible','on')
    set(gcf,'currentaxes',handles.corfon)

    imagesc(1)
    
    set(handles.corfon,'xtickmode','manual')
    set(handles.corfon,'ytickmode','manual')
    set(handles.corfon,'ztickmode','manual')
    
    set(handles.corfon,'xticklabelmode','manual')
    set(handles.corfon,'yticklabelmode','manual')
    set(handles.corfon,'zticklabelmode','manual')
    set(handles.corfon,'yticklabel',0)
    set(handles.corfon,'XTick',zeros(1,0))
    set(handles.corfon,'YTick',0)
    set(handles.corfon,'Clim',[-1 quantfonte])
end



% Plotando os ponto da excitação
set(gcf,'currentaxes',handles.axes1)
imagesc(fonteimg)
set(handles.axes1,'xtickmode','auto')
set(handles.axes1,'ytickmode','auto')
set(handles.axes1,'ztickmode','auto')

set(handles.axes1,'xticklabelmode','auto')
set(handles.axes1,'yticklabelmode','auto')
set(handles.axes1,'zticklabelmode','auto')
set(handles.axes1,'CLim', [-1 quantfonte])

if fontedk{1,2} == 1
    set(handles.campsel,'String',msgchx)
    set(handles.cHx,'Value',1)
elseif fontedk{1,2} == 2
    set(handles.campsel,'String',msgchy)
    set(handles.cHy,'Value',1)
elseif fontedk{1,2} == 3
    set(handles.cEz,'Value',1)
    set(handles.campsel,'String',msgcez)
elseif fontedk{1,2} == 4
    set(handles.cCalor,'Value',1)
    set(handles.campsel,'String',msgcc)
elseif fontedk{1,2} == 0
    set(handles.cHx,'Value',0)
    set(handles.cHy,'Value',0)
    set(handles.cEz,'Value',0)
    set(handles.cCalor,'Value',0)
    set(handles.campsel,'String','')
end




% Concatenação no listbox
if quantfonte ~= 0
    set(handles.numfonte,'string',[msgf, '1']);
    for bfon = 2:quantfonte
        tfonte = get (handles.numfonte,'string');
        set(handles.numfonte,'string', [tfonte; [msgf, num2str(bfon)]]);
    end
end
set(handles.numfonte,'Value',1);

% Setando no popup menu
set(handles.formaonda,'Value',(fontedk{fontenumdk,3}(2) + 1))

switch (fontedk{fontenumdk,3}(2) + 1)
    case 1
        set(handles.onda,'string','');
        set(handles.p1,'string','');
        set(handles.p2,'string','');
        set(handles.p3,'string','');
        set(handles.p4,'string','');
    case 2
        
        set(handles.onda,'string',msgos);
        set(handles.p1,'string',[msgfreq,num2str(fontedk{fontenumdk,3}(3))]);
        set(handles.p2,'string',[msgamp,num2str(fontedk{fontenumdk,3}(4))]);
        set(handles.p3,'string',[msgteta,num2str(fontedk{fontenumdk,3}(5))]);
        set(handles.p4,'string',[msgdu,num2str(fontedk{fontenumdk,3}(6))]);
        
    case 3
        
        set(handles.onda,'string',msgog);
        set(handles.p1,'string',[msgogde,num2str(fontedk{fontenumdk,3}(3))]);
        set(handles.p2,'string',[msgamp,num2str(fontedk{fontenumdk,3}(4))]);
        set(handles.p3,'string',[msgdu,num2str(fontedk{fontenumdk,3}(5))]);
        set(handles.p4,'string','');
        
    case 4
        
        set(handles.onda,'string',msgpul);
        set(handles.p1,'string',[msgamp,num2str(fontedk{fontenumdk,3}(3))]);
        set(handles.p2,'string',[msgdu,num2str(fontedk{fontenumdk,3}(4))]);
        set(handles.p3,'string','');
        set(handles.p4,'string','');
        
    case 5
        
        set(handles.onda,'string',msgoge);
        set(handles.p1,'string',[msgdu,num2str(fontedk{fontenumdk,3}(3))]);
        set(handles.p2,'string','');
        set(handles.p3,'string','');
        set(handles.p4,'string','');
        
end

if simu == 1
    set(handles.cHx,'Visible','on')
    set(handles.cHy,'Visible','on')
    set(handles.cEz,'Visible','on')
    set(handles.cCalor,'Visible','on')
elseif simu == 2
    set(handles.cHx,'Visible','on')
    set(handles.cHy,'Visible','on')
    set(handles.cEz,'Visible','on')
    set(handles.cCalor,'Visible','off')
elseif simu == 3
    set(handles.cHx,'Visible','off')
    set(handles.cHy,'Visible','off')
    set(handles.cEz,'Visible','off')
    set(handles.cCalor,'Visible','on')
end

if TEM == 2
    set(handles.cHx,'string','Ex')
    set(handles.cHy,'string','Ey')
    set(handles.cEz,'string','Hz')
end