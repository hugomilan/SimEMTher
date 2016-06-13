function textomalhaentfig (handles)
global  Tx Ty idioma dl ent tabcar corcar dimenmalha versao

if idioma == 1
    msgtitulofig = versao;
    msgtitulo = 'Input Mesh Editor';
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix One-dimensional';
        confy = 'off';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Two-Dimensional';
        confy = 'on';
        conffig = 'auto';
    end
    msgnox = 'Number of Nodes in x';
    msgnoy = 'Number of Nodes in y';
    msgtamno = 'Size of Node';
    msgedcar = 'Characteristics Editor';
    msggmalha = 'Mesh Generate';
    msgretornar = 'Return';
    
    
    
elseif idioma == 2
    msgtitulofig = versao;
    msgtitulo = 'Editor da Malha de Entrada';
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix Unidimensional';
        confy = 'off';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Bidimensional';
        confy = 'on';
        conffig = 'auto';
    end
    msgnox = 'Quantidade de Nós em x';
    msgnoy = 'Quantidade de Nós em y';
    msgtamno = 'Tamanho do Nó';
    msgedcar = 'Editor de Características';
    msggmalha = 'Gerar Malha';
    msgretornar = 'Retornar';
    
    
    
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.titulo01,'string',msgtitulo)
set(handles.text1,'string',msgtitulotlm)
set(handles.text3,'string',msgnox)
set(handles.text4,'string',msgnoy)
set(handles.text5,'string',msgtamno)
set(handles.edcar,'string',msgedcar)
set(handles.gmalha,'string',msggmalha)
set(handles.retornar,'string',msgretornar)


% Valores Iniciais Necessários
set(handles.Tys,'string',num2str(Ty))
set(handles.Txs,'string',num2str(Tx))
set(handles.dls,'string',[num2str(dl),' m'])
set(handles.Tye,'string',num2str(Ty))
set(handles.Txe,'string',num2str(Tx))
set(handles.dle,'string',num2str(dl))

%figuras dependentes da dimensão
set(handles.text4,'visible',confy)
set(handles.Tye,'visible',confy)
set(handles.Tys,'visible',confy)




% Plotando a malha de entrada
set(gcf,'currentaxes',handles.figmalha)
imagesc(ent)

set(handles.figmalha,'xtickmode','auto')
set(handles.figmalha,'ytickmode',conffig)
set(handles.figmalha,'ztickmode','auto')

set(handles.figmalha,'xticklabelmode','auto')
set(handles.figmalha,'yticklabelmode',conffig)
set(handles.figmalha,'zticklabelmode','auto')

if strcmp(conffig,'manual')
    set(handles.figmalha,'YTick',zeros(1,0))
end
        
set(handles.figmalha,'clim',[0 size(tabcar,1)])




% Verificando para a escala
set(gcf,'currentaxes',handles.figmamap)
imagesc(corcar)

set(handles.figmamap,'xtickmode','manual')
set(handles.figmamap,'ytickmode','manual')
set(handles.figmamap,'ztickmode','manual')

set(handles.figmamap,'xticklabelmode','manual')
set(handles.figmamap,'yticklabelmode','manual')
set(handles.figmamap,'zticklabelmode','manual')

b(1) = 0;
b1{1} = '0';
for c = 1:(size(tabcar,1))
    b(c+1) = c;
    b1{c+1} = num2str(c);
end

set(handles.figmamap,'yticklabel',b1)

set(handles.figmamap,'XTick',zeros(1,0))

set(handles.figmamap,'YTick',b)
set(handles.figmamap,'clim',[0 size(tabcar,1)])