function textoedcar (handles)
global idioma ent tabcar coledi colfor colwid colnam msgflux corcar dimenmalha simu TEM versao

colnam = cell(1,10);
if idioma == 1
    msgtitulofig = versao;
    msgtitulo = 'Input Mesh Editor - Characteristic';
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix One-dimensional';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Two-Dimensional';
        conffig = 'auto';
    end
    msgaddcar = 'Add Characteristic';
    msgretcar = 'Remove Characteristic';
    msgsimu = 'Simulation';
    msgemtm1 = 'Electromagnetic Field';
    msgemtm2 = '& Thermal Diffusion';
    msgem = 'Electromagnetic Field';
    msgtm = 'Thermal Diffusion';
    msgincar = 'Input Characteristic in the Mesh';
    msgindt = 'Input dt';
    msgretornar = 'Return';
    msgrosan = 'Blood Density (kg/m³)';
    msgcpsan = 'Blood Specific Heat (kg/m³)';
    msgtsan = 'Blood Temperature (K)';
    msgfluxconv = 'Convection Flux';
    msgfluxrad = 'Radiation Flux';
    msgbtfron = 'Boundaries';
    msgpnem = 'EM Propagation';
    msgbtfex = 'External Flux';
    msgalt = 'Altitude (m)';
    msglong = 'Latitude (ºDec)';
    msgTa = 'Air Temperature (K)';
    msgTgn = 'Black Globe Temperature (K)';
    msgDgn = 'Black Globe Diameter (m)';
    msgVV = 'Wind Velocity (m/s)';
    
    % Nomes na Tabela
    colnam{1} = 'Relative Permissivity';
    colnam{2} = 'Electrical Condutivity (S/m)';
    colnam{3} = 'Relative Permeability';
    colnam{4} = 'Density (kg/m³)';
    colnam{5} = 'Specific Heat (J/(kg*K))';
    colnam{6} = 'Thermal Conductivity (W/(m*K))';
    colnam{7} = 'Initial Temperature (K)';
    colnam{8} = 'Blood Perfusion (m³/(m³*s))';
    colnam{9} = 'Metabolic Heat Generation (W/m³)';
    colnam{10} = 'Emissivity';
    
elseif idioma == 2
    msgtitulofig = versao;
    msgtitulo = 'Editor da Malha de Entrada - Características';
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix Unidimensional';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Bidimensional';
        conffig = 'auto';
    end
    msgaddcar = 'Adicionar Característica';
    msgretcar = 'Retirar Característica';
    msgsimu = 'Simulação';
    msgemtm1 = 'Campo Eletromagnético';
    msgemtm2 = '& Difusão Térmica';
    msgem = 'Campo Eletromagnético';
    msgtm = 'Difusão Térmica';
    msgincar = 'Inserir Característica na Malha';
    msgindt = 'Inserir dt';
    msgretornar = 'Retornar';
    msgrosan = 'Densidade do Sangue (kg/m³)';
    msgcpsan = 'Calor Específico do Sangue (kg/m³)';
    msgtsan = 'Temperatura do Sangue (K)';
    msgfluxconv = 'Fluxo por Convecção';
    msgfluxrad = 'Fluxo por Radiação';
    msgbtfron = 'Fronteiras';
    msgpnem = 'Propagação EM';
    msgbtfex = 'Fluxo Externo';
    msgalt = 'Altitude (m)';
    msglong = 'Latitude (ºDec)';
    msgTa = 'Temperatura do Ar (K)';
    msgTgn = 'Temperatura do Globo Negro (K)';
    msgDgn = 'Diâmetro do Globo Negro (m)';
    msgVV = 'Velocidade do Vento (m/s)';
    
    % Nomes na Tabela
    colnam{1} = 'Permissividade Relativa';
    colnam{2} = 'Condutividade Elétrica (S/m)';
    colnam{3} = 'Permeabilidade Relativa';
    colnam{4} = 'Densidade (kg/m³)';
    colnam{5} = 'Calor Específico (J/(kg*K))';
    colnam{6} = 'Condutividade Térmica (W/(m*K))';
    colnam{7} = 'Temperatura Inicial (K)';
    colnam{8} = 'Perfusão do Sangue (m³/(m³*s))';
    colnam{9} = 'Geração de Calor Metabólico (W/m³)';
    colnam{10} = 'Emissividade';
    
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.text2,'string',msgtitulo)
set(handles.text1,'string',msgtitulotlm)
set(handles.addcar,'string',msgaddcar)
set(handles.retcar,'string',msgretcar)
set(handles.painelsimu,'Title',msgsimu)
set(handles.simuemter,'string',msgemtm1)
set(handles.txtdifusao,'string',msgemtm2)
set(handles.simuem,'string',msgem)
set(handles.simuter,'string',msgtm)
set(handles.insercar,'string',msgincar)
set(handles.txtdtter,'string',msgindt)
set(handles.retonar,'string',msgretornar)
set(handles.txtrosan,'string',msgrosan)
set(handles.txtcpsan,'string',msgcpsan)
set(handles.txttsan,'string',msgtsan)
set(handles.cbfluxconv,'string',msgfluxconv)
set(handles.cbfluxrad,'string',msgfluxrad)
set(handles.btfronteira,'string',msgbtfron)
set(handles.EMpainel,'title',msgpnem)
set(handles.fluxextbtn,'string',msgbtfex)
set(handles.txtAltitude,'string',msgalt)
set(handles.txtLatitude,'string',msglong)
set(handles.txtTa,'string',msgTa)
set(handles.txtTgn,'string',msgTgn)
set(handles.txtDgn,'string',msgDgn)
set(handles.txtVV,'string',msgVV)


% Mensagens no Popup
set(handles.pupmeiosflux,'String',msgflux(:,idioma))

% plotando a malha para análise
set(gcf,'currentaxes',handles.figedcar)
imagesc(ent)
set(handles.figedcar,'xtickmode','auto')
set(handles.figedcar,'ytickmode',conffig)
set(handles.figedcar,'ztickmode','auto')

set(handles.figedcar,'xticklabelmode','auto')
set(handles.figedcar,'yticklabelmode',conffig)
set(handles.figedcar,'zticklabelmode','auto')
set(handles.figedcar,'clim',[0 size(tabcar,1)])

if strcmp(conffig,'manual')
    set(handles.figedcar,'YTick',zeros(1,0))
end

% plotando a escala
set(gcf,'currentaxes',handles.figmostra)
imagesc(corcar)

set(handles.figmostra,'xtickmode','manual')
set(handles.figmostra,'ytickmode','manual')
set(handles.figmostra,'ztickmode','manual')

set(handles.figmostra,'xticklabelmode','manual')
set(handles.figmostra,'yticklabelmode','manual')
set(handles.figmostra,'zticklabelmode','manual')

b(1) = 0;
b1{1} = 0;
for c = 1:(size(tabcar,1))
    b(c+1) = c;
    b1{c+1} = num2str(c);
end


set(handles.figmostra,'yticklabel',b1)

set(handles.figmostra,'XTick',zeros(1,0))

set(handles.figmostra,'YTick',b)

set(handles.figmostra,'clim',[0 size(tabcar,1)])


% Colunas para as diferentes formas de simulação
if isempty(coledi)
    coledi = get(handles.tabelacar,'ColumnEditable');
    colfor = get(handles.tabelacar,'ColumnFormat');
    colwid = get(handles.tabelacar,'ColumnWidth');
end



% Verificação da convergência do modelo da BHE
convBHE(handles)

if simu == 3 || dimenmalha == 1
    set(handles.EMpainel,'visible','off')
else
    set(handles.EMpainel,'visible','on')
    if TEM == 1
        set(handles.TMbtn,'value',1)
    elseif TEM == 2
        set(handles.TEbtn,'value',1)
    else
        set(handles.TMbtn,'value',0)
        set(handles.TEbtn,'value',0)
    end
end