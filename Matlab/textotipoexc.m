function textotipoexc (handles,fontenumdk)
global idioma fontedk

if idioma == 1
    msgos = 'Sinusoidal Wave';
    msgog = 'Gaussian Wave';
    msgogde = 'Displacement = ';
    msgdu = 'Duration = ';
    msgamp = 'Amp = ';
    msgfreq = 'Freq = ';
    msgteta = 'Teta = ';
    msgpul = 'Pulse = ';
    msgoge = 'General Wave';

    
    
    
elseif idioma == 2

    msgos = 'Onda Senoidal';
    msgog = 'Onda Gaussiana';
    msgogde = 'Deslocamento = ';
    msgdu = 'Duração = ';
    msgamp = 'Amp = ';
    msgfreq = 'Freq = ';
    msgteta = 'Teta = ';
    msgpul = 'Pulso = ';
    msgoge = 'Onda Genérica';
end




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
end