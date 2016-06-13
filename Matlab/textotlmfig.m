function textotlmfig (handles)
global dtTLM k Tx Ty quantcampo idioma dimenmalha saltosimu versao

if idioma == 1
    msgtitulofig = versao;
    if dimenmalha == 1
        msgtitulo = 'Transmission-Line Matrix One-dimensional';
    elseif dimenmalha == 2
        msgtitulo = 'Transmission-Line Matrix Two-Dimensional';
    end
    
    msgmalhaentrada = 'Input Mesh';
    msgsimular = 'Simulate';
    msgedfonte = 'Source';
    msgresultado = 'Results';
    msgdimensao = {'One-dimensional'; 'Two-dimensional'};
    msgpassotempo = 'Input Time-Step';
    msgtemposimu = ['Simuling ',num2str(dtTLM*k),'s'];
    msgconmemo = ['Approximate consumption of memory: ', ...
        num2str(Ty*Tx*k*8*quantcampo/(1e9*saltosimu)),' GB.'];
    msgtextoini = ['Algorithm accomplished by the Reseach Group ',...
        'Modelling in Electric Systems (GPMSE) of Federal ', ...
        'University of Rondoina (UNIR) in the research line Numerical ', ...
        'Simulation in Electromagnetic Fields'];
    msgarquivo = 'File';
    msgsalvar = 'Save';
    msgabrir = 'Open';
    msgfechar = 'Close';
    valpopup = 1;
    msgsalto = 'Input how much time-step have to pass to save a point';
    msgsaltosimu = ['Salving 1 point to each ', num2str(saltosimu), ' time-step'];
    
elseif idioma == 2
    msgtitulofig = versao;
    if dimenmalha == 1
        msgtitulo = 'Transmission-Line Matrix Unidimensional';
    elseif dimenmalha == 2
        msgtitulo = 'Transmission-Line Matrix Bidimensional';
    end
    msgmalhaentrada = 'Malha de Entrada';
    msgsimular = 'Simular';
    msgedfonte = 'Fonte';
    msgresultado = 'Resultados';
    msgdimensao = {'Unidimensional'; 'Bidimensional'};
    msgpassotempo = 'Insira os Passos-de-tempo';
    msgtemposimu = ['Simulando ',num2str(dtTLM*k),'s'];
    msgconmemo = ['Consumo aproximado da memória: ', ...
    num2str(Ty*Tx*k*8*quantcampo/(1e9*saltosimu)),' GB.'];
    msgtextoini = ['Algoritmo Realizado pelo Grupo de Pesquisa ',...
        'Modelagem em Sistemas Elétricos (GPMSE) da Universidade ', ...
        'Federal de Rondônia (UNIR) na linha de pesquisa Simulação ', ...
        'Numérica de Campos Eletromagnéticos'];
    msgarquivo = 'Arquivo';
    msgsalvar = 'Salvar';
    msgabrir = 'Abrir';
    msgfechar = 'Fechar';
    valpopup = 2;
    
    msgsalto = 'Quantidade de Passos-de-Tempo para Salvar um ponto';
    msgsaltosimu = ['Salvando 1 ponto a cada ', num2str(saltosimu), ' passos-de-tempo'];
    
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.titulo,'string',msgtitulo)
set(handles.malhaentrada,'string',msgmalhaentrada)
set(handles.simular,'string',msgsimular)
set(handles.editarfonte,'string',msgedfonte)
set(handles.resul,'string',msgresultado)
set(handles.text3,'string',msgpassotempo)
set(handles.tsimu,'string',msgtemposimu)
set(handles.txtconmem,'string',msgconmemo)
set(handles.text6,'string',msgtextoini)
set(handles.Arquivos,'Label',msgarquivo)
set(handles.salvar,'Label',msgsalvar)
set(handles.abrir,'Label',msgabrir)
set(handles.fechar,'Label',msgfechar)
set(handles.kpassos,'string',num2str(k))

set(handles.popidioma,'value',valpopup)

set(handles.pupdimensao,'string',msgdimensao)
set(handles.pupdimensao,'value',dimenmalha)
set(handles.txtmsalto,'string',msgsalto);
set(handles.txtsalto,'string',msgsaltosimu);
set(handles.edsalto,'string',saltosimu);