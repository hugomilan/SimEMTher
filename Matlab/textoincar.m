function textoincar(handles)

global idioma tabcar ent corcar dimenmalha versao

if idioma == 1
    msgtitulofig = versao;
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix One-dimensional';
        confy = 'off';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Two-Dimensional';
        confy = 'on';
        conffig = 'auto';
    end
    msgcarac = 'Characteristic';
    msgxin = 'X Initial';
    msgxfin = 'X Final';
    msgyin = 'Y Initial';
    msgyfin = 'Y Final';
    msgadd = 'Add';
    msgret = 'Return';

    
elseif idioma == 2
    msgtitulofig = versao;
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix Unidimensional';
        confy = 'off';
        conffig = 'manual';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Bidimensional';
        confy = 'on';
        conffig = 'auto';
    end
    msgcarac = 'Característica';
    msgxin = 'X Inicial';
    msgxfin = 'X Final';
    msgyin = 'Y Inicial';
    msgyfin = 'Y Final';
    msgadd = 'Adicionar';
    msgret = 'Retornar';


end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.msgtitulotlm,'string',msgtitulotlm)
set(handles.text5,'string',msgcarac)
set(handles.text1,'string',msgxin)
set(handles.text2,'string',msgxfin)
set(handles.text3,'string',msgyin)
set(handles.yfins,'string',msgyfin)
set(handles.adicionar,'string',msgadd)
set(handles.retornar,'string',msgret)

%on/off, dependendo da dimensão
set(handles.text3,'visible',confy)
set(handles.yin,'visible',confy)
set(handles.ytin,'visible',confy)
set(handles.yfins,'visible',confy)
set(handles.ytfin,'visible',confy)
set(handles.yfin,'visible',confy)

% Setando o listbox
set(handles.listcar,'string',num2str([1:size(tabcar,1)]'))



% plotando a malha para análise
set(gcf,'currentaxes',handles.figin)
imagesc(ent)
set(handles.figin,'xtickmode','auto')
set(handles.figin,'ytickmode',conffig)
set(handles.figin,'ztickmode','auto')

set(handles.figin,'xticklabelmode','auto')
set(handles.figin,'yticklabelmode',conffig)
set(handles.figin,'zticklabelmode','auto')
set(handles.figin,'clim',[0 size(tabcar,1)])

if strcmp(conffig,'manual')
    set(handles.figin,'YTick',zeros(1,0))
end

% plotando a escala
set(gcf,'currentaxes',handles.figmap)
imagesc(corcar)

set(handles.figmap,'xtickmode','manual')
set(handles.figmap,'ytickmode','manual')
set(handles.figmap,'ztickmode','manual')

set(handles.figmap,'xticklabelmode','manual')
set(handles.figmap,'yticklabelmode','manual')
set(handles.figmap,'zticklabelmode','manual')



b(1) = 0;
b1{1} = 0;
for c = 1:(size(tabcar,1))
    b(c+1) = c;
    b1{c+1} = num2str(c);
end


set(handles.figmap,'yticklabel',b1)

set(handles.figmap,'XTick',zeros(1,0))

set(handles.figmap,'YTick',b)

set(handles.figmap,'clim',[0 size(tabcar,1)])