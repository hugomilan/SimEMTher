function textofluxext (handles)
global idioma versao

if idioma == 1
    msgtitulofig = versao;
    msgtitulo = 'External Flux';
    msgadd = 'Insert';
    msgret = 'Remove';
    msgretur = 'Return';
    
    
elseif idioma == 2
    msgtitulofig = versao;
    msgtitulo = 'Fluxos Externos';
    msgadd = 'Inserir';
    msgret = 'Remover';
    msgretur = 'Retornar';
        
end

% Colocando os textos
set(handles.figure1,'name',msgtitulofig)
set(handles.text2,'string',msgtitulo)

set(handles.Inserirbtn,'string',msgadd)
set(handles.Retirarbtn,'string',msgret)
set(handles.Retornarbtn,'string',msgretur)
