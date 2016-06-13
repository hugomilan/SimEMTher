function ajustaflux (handles)

global fluxosext idioma

msgflux = cell(3,1);
if idioma == 1
    msgflux{1,1} = 'Conv. Flux';
    msgflux{2,1} = 'Rad. Flux';
    msgflux{3,1} = 'Conv. and Rad. Flux';
    msgtipo{1,1} = ' (Horizontal Cylinder with ';
    msgtipo{2,1} = ' (Vertical Cylinder with ';
    msgtipo{3,1} = ' (Globe with ';
    msgmetro = ' m)';
    msgof = ' in ';
    msgnoflux = 'No External Flux';
elseif idioma == 2
    msgflux{1,1} = 'Fluxo de Conv.';
    msgflux{2,1} = 'Fluxo de Rad.';
    msgflux{3,1} = 'Fluxo de Conv. e Rad.';
    msgtipo{1,1} = ' (Cilindro Horizontal com ';
    msgtipo{2,1} = ' (Cilindro Vertical com ';
    msgtipo{3,1} = ' (Globo com ';
    msgmetro = ' m)';
    msgof = ' em ';
    msgnoflux = 'Sem Fluxos Externos';
end

textolista = cell(1,1);
textolista{1,1} = msgnoflux;
if fluxosext(1,1) ~= 0
   
    for a = 1:size(fluxosext,1)
        textolista{a,1} = [msgflux{fluxosext(a,1)}, ...
            msgof, num2str(fluxosext(a,2)), msgtipo{fluxosext(a,4)}, ...
            num2str(fluxosext(a,3)), msgmetro];
    end
end
set(handles.lista,'value',1)
set(handles.lista,'string',textolista(:,1))