function textoedfon(handles)

global idioma mostraopcao campfront simu fronthorizontal frontvertical ...
    fortabhor fortabver Tx Ty dimenmalha versao

if idioma == 1
    msgtitulofig = versao;
    if dimenmalha == 1
        msgtitulotlm = 'Transmission-Line Matrix One-dimensional';
        confy = 'off';
    elseif dimenmalha == 2
        msgtitulotlm = 'Transmission-Line Matrix Two-Dimensional';
        confy = 'on';
    end
    msgcamp = 'Field';
    msgem = 'Electromagnetic';
    msgter = 'Thermal';
    msginno = 'Input between nodes';
    msgfaces = {'Right'; 'Left'; 'Up'; 'Down'};
    msginfon = 'Input Bound. in nodes';
    msgadd = 'Add';
    msgreti = 'Remove';
    msgret = 'Return';
    msgtbhornam = {'Right';'Left'};
    msgtbvernam = {'Up';'Down'};
    
    
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
    msgcamp = 'Campo';
    msgem = 'Eletromagnético';
    msgter = 'Térmico';
    msginno = 'Inserir Entre os nós';
    msgfaces = {'Direito'; 'Esquerdo'; 'Cima'; 'Baixo'};
    msginfon = 'Inserir Front. nos nós';
    msgadd = 'Adicionar';
    msgreti = 'Retirar';
    msgret = 'Retornar';
    msgtbhornam = {'Direito';'Esquerdo'};
    msgtbvernam = {'Cima';'Baixo'};

end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.msgtitulotlm,'string',msgtitulotlm)
set(handles.bgCampo,'title',msgcamp)
set(handles.rbem,'string',msgem)
set(handles.rbter,'string',msgter)
set(handles.txtinsnos,'string',msginno)
set(handles.pmfaces,'string',msgfaces)
set(handles.pbinno,'string',msginfon)
set(handles.btinserirop,'string',msgadd)
set(handles.btretirarop,'string',msgreti)
set(handles.btretornar,'string',msgret)


%on/off dimensão
set(handles.txtinsnos,'visible',confy)
set(handles.edtno01,'visible',confy)
set(handles.edtno02,'visible',confy)
set(handles.pmfaces,'visible',confy)
set(handles.pbinno,'visible',confy)
set(handles.tbvertical,'visible',confy)

% Setando o listbox
if simu == 2
    set(handles.rbter,'Visible','off')
elseif simu == 3
    set(handles.rbem,'Visible','off')
    campfront = 2;
end
if campfront == 1
    set(handles.rbem,'Value',1)
elseif campfront == 2
    set(handles.rbter,'Value',1)
end

set(handles.lbopcoes,'string',mostraopcao{1,campfront}(:,idioma))

% Setando as tabelas
% Tabela horizontal
set(handles.tbhorizontal,'data',fronthorizontal(:,:,campfront))
set(handles.tbhorizontal,'ColumnFormat',fortabhor(campfront,:))
set(handles.tbhorizontal,'ColumnEditable',true(ones(1,Ty)))
set(handles.tbhorizontal,'Rowname',msgtbhornam)

% Tabela Vertical
set(handles.tbvertical,'data',frontvertical(:,:,campfront))
set(handles.tbvertical,'ColumnFormat',fortabver(campfront,:))
set(handles.tbvertical,'ColumnEditable',true(ones(1,Tx)))
set(handles.tbvertical,'Rowname',msgtbvernam)