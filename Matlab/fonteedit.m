function varargout = fonteedit(varargin)
% FONTEEDIT MATLAB code for fonteedit.fig
%      FONTEEDIT, by itself, creates a new FONTEEDIT or raises the existing
%      singleton*.
%
%      H = FONTEEDIT returns the handle to a new FONTEEDIT or the handle to
%      the existing singleton*.
%
%      FONTEEDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FONTEEDIT.M with the given input arguments.
%
%      FONTEEDIT('Property','Value',...) creates a new FONTEEDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fonteedit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fonteedit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fonteedit

% Last Modified by GUIDE v2.5 26-Nov-2011 11:26:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @fonteedit_OpeningFcn, ...
    'gui_OutputFcn',  @fonteedit_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fonteedit is made visible.
function fonteedit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fonteedit (see VARARGIN)

% Choose default command line output for fonteedit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fonteedit wait for user response (see UIRESUME)
% uiwait(handles.figure1);

textofonteedit(handles,1)

% --- Outputs from this function are returned to the command line.
function varargout = fonteedit_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in formaonda.
function formaonda_Callback(hObject, eventdata, handles)
% hObject    handle to formaonda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fontedk quantfonte idioma TEM

%Ajustando o idioma
if idioma == 1
        msgerror1 = ['Do not found a field of stimulation. Select a Field that '...
        'will do the stimulation to edit the function.'];
    msgerror2 = 'Do not selected Field';
    msgerror3 = 'Add one source to can do the configuration';
    msgerror4 = 'Source no found.';
    msgea = 'Input the Amplitude ';
    msgef = 'Input the frequency:';
    msgeang = 'Input the discrepancy angle:';
    msgept = 'Input the duration of wave';
    msgedt = 'Input the displacement in time:';
    msgefv = 'Input a function in shap of vector line:';
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
    msgerror1 = ['Não foi escolhido um campo para excitação.',...
        ' Escolha o campo que fará a excitação para depois',...
        ' editar a função.'];
    msgerror2 = 'Campo Não Selecionado';
    msgerror3 = ['Adicione uma fonte para poder realizar as ',...
        'configurações.'];
    msgerror4 = 'Fonte Não Encontrada.';
    msgea = 'Entre com a Amplitude ';
    msgef = 'Entre com a frequência:';
    msgeang = 'Entre com o ângulo de defasagem:';
    msgept = 'Entre com a duração da Onda';
    msgedt = 'Entre com o deslocamento no tempo:';
    msgefv = 'Entre com a função em forma de vetor linha:';
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

if quantfonte
    forma = get(hObject,'Value');
    fontenumdk = get(handles.numfonte,'Value');
    
    if fontedk{fontenumdk,2} == 1 || fontedk{fontenumdk,2} == 2
        campoSI = '(A/m) :';
        if TEM == 2
            campoSI = '(V/m) :';
        end
    elseif fontedk{fontenumdk,2} == 3
        campoSI = '(V/m) :';
        if TEM == 2
            campoSI = '(A/m) :';
        end
    elseif fontedk{fontenumdk,2} == 4
        campoSI = '(W/m³) :';
    elseif fontedk{fontenumdk,2} == 0
        errordlg(msgerror1,msgerror2);
        return
    end
    Amptexto = [msgea,campoSI];
    
    
    fontedk{fontenumdk,3}(2) = (forma - 1);
    % 1 - Senóide; 2 - Gaussiana; 3 - Contínua; 4 - Genérica;
    
    switch forma
        case 2
            pro = {msgef,Amptexto,msgeang,msgept};
            titulo = msgos;
            nlinhas = 1;
            senoidal = inputdlg(pro,titulo,nlinhas);
            
            if ~isempty(senoidal) && ~strcmp(senoidal{1},'') ...
                    && ~strcmp(senoidal{2},'') &&  ~strcmp(senoidal{3},'') ...
                    && ~strcmp(senoidal{4},'')
                
                f = str2num(senoidal{1});
                freqch = senoidal{1};
                A = str2num(senoidal{2});
                teta = str2num(senoidal{3});
                tseno = str2num(senoidal{4});
                
                fontedk{fontenumdk,3}(3) = f;
                fontedk{fontenumdk,3}(4) = A;
                fontedk{fontenumdk,3}(5) = teta;
                fontedk{fontenumdk,3}(6) = tseno;
                fontedk{fontenumdk,4} = 0;
                
                set(handles.onda,'string',msgos);
                set(handles.p1,'string',[msgfreq,senoidal{1}]);
                set(handles.p2,'string',[msgamp,num2str(A)]);
                set(handles.p3,'string',[msgteta,num2str(teta)]);
                set(handles.p4,'string',[msgdu,num2str(tseno)]);
            end
        case 3
            pro = {msgedt,Amptexto,msgept};
            titulo = msgog;
            nlinhas = 1;
            gauss = inputdlg(pro,titulo,nlinhas);
            
            if ~isempty(gauss) && ~strcmp(gauss{1},'') ...
                    && ~strcmp(gauss{2},'') &&  ~strcmp(gauss{3},'')
                
                ugauss = str2num(gauss{1});
                A = str2num(gauss{2});
                ogauss = str2num(gauss{3});
                
                fontedk{fontenumdk,3}(3) = ugauss;
                fontedk{fontenumdk,3}(4) = A;
                fontedk{fontenumdk,3}(5) = ogauss;
                fontedk{fontenumdk,3}(6) = 0;
                fontedk{fontenumdk,4} = 0;
                
                set(handles.onda,'string',msgog);
                set(handles.p1,'string',[msgogde,num2str(ugauss)]);
                set(handles.p2,'string',[msgamp,num2str(A)]);
                set(handles.p3,'string',[msgdu,num2str(ogauss)]);
                set(handles.p4,'string','');
            end
        case 4
            pro = {Amptexto,msgept};
            titulo = msgpul;
            nlinhas = 1;
            pulso = inputdlg(pro,titulo,nlinhas);
            
            if ~isempty(pulso) && ~strcmp(pulso{1},'') ...
                    && ~strcmp(pulso{2},'')
                
                A = str2num(pulso{1});
                tpulso = str2num(pulso{2});
                
                fontedk{fontenumdk,3}(3) = A;
                fontedk{fontenumdk,3}(4) = tpulso;
                fontedk{fontenumdk,3}(5) = 0;
                fontedk{fontenumdk,3}(6) = 0;
                fontedk{fontenumdk,4} = 0;
                
                set(handles.onda,'string',msgpul);
                set(handles.p1,'string',[msgamp,num2str(A)]);
                set(handles.p2,'string',[msgdu,num2str(tpulso)]);
                set(handles.p3,'string','');
                set(handles.p4,'string','');
            end
        case 5
            pro = {msgefv};
            titulo = msgoge;
            nlinhas = 1;
            gen = inputdlg(pro,titulo,nlinhas);
            
            
            if ~isempty(gen) && ~isempty(gen(1)) && ~strcmp(gen(1),'')
                funcao = str2num(gen{1});
                tfuncao = size(funcao,2);
                
                fontedk{fontenumdk,3}(3) = tfuncao;
                fontedk{fontenumdk,3}(4) = 0;
                fontedk{fontenumdk,3}(5) = 0;
                fontedk{fontenumdk,3}(6) = 0;
                fontedk{fontenumdk,4} = funcao;
                
                set(handles.onda,'string',msgog);
                set(handles.p1,'string',[msgdu,num2str(tfuncao)]);
                set(handles.p2,'string','');
                set(handles.p3,'string','');
                set(handles.p4,'string','');
            end
    end
else
    errordlg(msgerror3,msgerror4);
    
end


% --- Executes when selected object is changed in formant.
function formant_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in formant
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global fontedk quantfonte
if get(handles.circ,'Value') == 1
    
    set(handles.diam01,'visible','on')
    set(handles.tdiam,'visible','on')
    set(handles.ediam,'visible','on')
    set(handles.diam02,'visible','on')
    set(handles.ex,'visible','on')
    set(handles.tx,'visible','on')
    set(handles.diam03,'visible','on')
    set(handles.ey,'visible','on')
    set(handles.ty,'visible','on')
    
    set(handles.q01,'visible','off')
    set(handles.q02,'visible','off')
    set(handles.q03,'visible','off')
    set(handles.q04,'visible','off')
    set(handles.q05,'visible','off')
    set(handles.q06,'visible','off')
    set(handles.q07,'visible','off')
    set(handles.q08,'visible','off')
    set(handles.xin,'visible','off')
    set(handles.xfin,'visible','off')
    set(handles.yin,'visible','off')
    set(handles.yfin,'visible','off')
    forat = 1;
elseif get(handles.quad,'Value') == 1
    set(handles.q01,'visible','on')
    set(handles.q02,'visible','on')
    set(handles.q03,'visible','on')
    set(handles.q04,'visible','on')
    set(handles.q05,'visible','on')
    set(handles.q06,'visible','on')
    set(handles.q07,'visible','on')
    set(handles.q08,'visible','on')
    set(handles.xin,'visible','on')
    set(handles.xfin,'visible','on')
    set(handles.yin,'visible','on')
    set(handles.yfin,'visible','on')
    
    set(handles.diam01,'visible','off')
    set(handles.tdiam,'visible','off')
    set(handles.ediam,'visible','off')
    set(handles.diam02,'visible','off')
    set(handles.ex,'visible','off')
    set(handles.tx,'visible','off')
    set(handles.diam03,'visible','off')
    set(handles.ey,'visible','off')
    set(handles.ty,'visible','off')
    forat = 2;
end

if quantfonte
    fontenumdk = get(handles.numfonte,'Value');
    fontedk{fontenumdk,3}(1) = forat;
end


function ediam_Callback(hObject, eventdata, handles)
% hObject    handle to ediam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ediam as text
%        str2double(get(hObject,'String')) returns contents of ediam as a double

global dl Ty Tx diam

if str2num(get(hObject,'string')) > dl*Ty
    errordlg(['Diâmetro maior do que a malha de Simulação.'...
        ' Diminua a antena ou aumente a malha de simulação'],...
        'Antena muito grande')
elseif str2num(get(hObject,'string')) > dl*Tx
    errordlg(['Diâmetro maior do que a malha de Simulação.'...
        ' Diminua a antena ou aumente a malha de simulação'],...
        'Antena muito grande')
else
    diam    = str2num(get(hObject,'string'));
    set(handles.tdiam,'string',[get(hObject,'string'), ' m'])
end

% --- Executes during object creation, after setting all properties.
function ediam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ediam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ex_Callback(hObject, eventdata, handles)
% hObject    handle to ex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ex as text
%        str2double(get(hObject,'String')) returns contents of ex as a double
global Pinx
set(handles.tx,'string',get(hObject,'string'))
Pinx = num2str(get(hObject,'string'));

% --- Executes during object creation, after setting all properties.
function ex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ey_Callback(hObject, eventdata, handles)
% hObject    handle to ey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ey as text
%        str2double(get(hObject,'String')) returns contents of ey as a double
global Piny
set(handles.ty,'string',get(hObject,'string'))
Piny = num2str(get(hObject,'string'));

% --- Executes during object creation, after setting all properties.
function ey_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ey (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gante.
function gante_Callback(hObject, eventdata, handles)
% hObject    handle to gante (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fontedk dl diam Pin xin xfin yin yfin Ty Tx fonteimg quantfonte
fontenumdk = get(handles.numfonte,'Value');
if fontenumdk ~= 0
    if fontedk{fontenumdk,1} == 0;
        fontedk{fontenumdk,1} = zeros(Ty,Tx);
    end
    if get(handles.circ,'Value') == 1
        
        diam = str2double(get(handles.ediam,'string'));
        Pin(1) = str2double(get(handles.ex,'string'));
        Pin(2) = str2double(get(handles.ey,'string'));
        %Pontos onde a fonte é situada
        if round(diam/dl) <= 1
            fontedk{fontenumdk,1}(Pin(2),Pin(1)) = fontenumdk;
            fonteimg(Pin(2),Pin(1)) = fontenumdk;
        else
            rax = round(diam/2/dl)^2; %utilizado no calc.
            
            for n1 = -round(diam/dl/2):round(diam/dl/2)
                for n2 = -round(diam/dl/2):round(diam/dl/2)
                    if (n1)^2 + (n2)^2 <= rax
                        fontedk{fontenumdk,1}(n1 + Pin(2),...
                            n2 + Pin(1)) = fontenumdk;
                        fonteimg(n1 + Pin(2),...
                            n2 + Pin(1)) = fontenumdk;
                    end
                end
            end
        end
        %fonte é a matriz do tamanho da malha que recebe 1 no ponto em que há
        %uma entrada de fonte.
        %     %Pindk é a matriz do tamanho dos subdomínios que recebe 1 no subdomínio
        %     %em que há entrada de fonte.
        %     %Pin3m é a matriz celular com subdomínios onde os subdomínios que
        %     %contêm uma entrada de fonte recebem uma matriz com 1 nos pontos dos
        %     %subdomínios que contêm a fonte.
        
    elseif get(handles.quad,'Value') == 1
        xin = str2double(get(handles.xin,'string'));
        xfin = str2double(get(handles.xfin,'string'));
        yin = str2double(get(handles.yin,'string'));
        yfin = str2double(get(handles.yfin,'string'));
        fontedk{fontenumdk,1}(yin:yfin,xin:xfin) = fontenumdk;
        fonteimg(yin:yfin,xin:xfin) = fontenumdk;
    end
    set(gcf,'currentaxes',handles.axes1)
    imagesc(fonteimg)
    set(handles.axes1,'xtickmode','auto')
    set(handles.axes1,'ytickmode','auto')
    set(handles.axes1,'ztickmode','auto')
    
    set(handles.axes1,'xticklabelmode','auto')
    set(handles.axes1,'yticklabelmode','auto')
    set(handles.axes1,'zticklabelmode','auto')
    set(handles.axes1,'CLim', [-1 quantfonte])
end

function xin_Callback(hObject, eventdata, handles)
% hObject    handle to xin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xin as text
%        str2double(get(hObject,'String')) returns contents of xin as a double
set(handles.q02,'string',get(hObject,'string'))

% --- Executes during object creation, after setting all properties.
function xin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xfin_Callback(hObject, eventdata, handles)
% hObject    handle to xfin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xfin as text
%        str2double(get(hObject,'String')) returns contents of xfin as a double
set(handles.q06,'string',get(hObject,'string'))

% --- Executes during object creation, after setting all properties.
function xfin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xfin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yin_Callback(hObject, eventdata, handles)
% hObject    handle to yin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yin as text
%        str2double(get(hObject,'String')) returns contents of yin as a double
set(handles.q04,'string',get(hObject,'string'))

% --- Executes during object creation, after setting all properties.
function yin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yfin_Callback(hObject, eventdata, handles)
% hObject    handle to yfin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yfin as text
%        str2double(get(hObject,'String')) returns contents of yfin as a double
set(handles.q08,'string',get(hObject,'string'))

% --- Executes during object creation, after setting all properties.
function yfin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in retornar.
function retornar_Callback(hObject, eventdata, handles)
% hObject    handle to retornar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tlm
close(fonteedit)



% --- Executes during object creation, after setting all properties.
function formaonda_CreateFcn(hObject, eventdata, handles)
% hObject    handle to formaonda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in numfonte.
function numfonte_Callback(hObject, eventdata, handles)
% hObject    handle to numfonte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns numfonte contents as cell array
%        contents{get(hObject,'Value')} returns selected item from numfonte
global fontedk quantfonte idioma
if quantfonte
    
    if idioma == 1
        msgcamp = 'Field ';
        msgcaampc = 'Heat ';
    elseif idioma == 2
        msgcamp = 'Campo ';
        msgcaampc = 'Calor ';
    end
    
    
    fontenumdk = get(hObject,'Value');
    
    if fontedk{fontenumdk,2} == 1
        set(handles.campsel,'String',[msgcamp, 'Hx (A/m)'])
        set(handles.cHx,'Value',1)
    elseif fontedk{fontenumdk,2} == 2
        set(handles.campsel,'String',[msgcamp, 'Hy (A/m)'])
        set(handles.cHy,'Value',1)
    elseif fontedk{fontenumdk,2} == 3
        set(handles.cEz,'Value',1)
        set(handles.campsel,'String',[msgcamp, 'Ez (V/m)'])
    elseif fontedk{fontenumdk,2} == 4
        set(handles.cCalor,'Value',1)
        set(handles.campsel,'String',[msgcaampc, '(W/m³)'])
    elseif fontedk{fontenumdk,2} == 0
        set(handles.cHx,'Value',0)
        set(handles.cHy,'Value',0)
        set(handles.cEz,'Value',0)
        set(handles.cCalor,'Value',0)
        set(handles.campsel,'String','')
    end
    
    if fontedk{fontenumdk,3}(1) == 1
        set(handles.circ,'Value',1)
        set(handles.diam01,'visible','on')
        set(handles.tdiam,'visible','on')
        set(handles.ediam,'visible','on')
        set(handles.diam02,'visible','on')
        set(handles.ex,'visible','on')
        set(handles.tx,'visible','on')
        set(handles.diam03,'visible','on')
        set(handles.ey,'visible','on')
        set(handles.ty,'visible','on')
        
        set(handles.q01,'visible','off')
        set(handles.q02,'visible','off')
        set(handles.q03,'visible','off')
        set(handles.q04,'visible','off')
        set(handles.q05,'visible','off')
        set(handles.q06,'visible','off')
        set(handles.q07,'visible','off')
        set(handles.q08,'visible','off')
        set(handles.xin,'visible','off')
        set(handles.xfin,'visible','off')
        set(handles.yin,'visible','off')
        set(handles.yfin,'visible','off')
        
        set(handles.circ,'Value',1)
        set(handles.quad,'Value',0)
        
    elseif fontedk{fontenumdk,3}(1) == 2
        set(handles.quad,'Value',1)
        set(handles.q01,'visible','on')
        set(handles.q02,'visible','on')
        set(handles.q03,'visible','on')
        set(handles.q04,'visible','on')
        set(handles.q05,'visible','on')
        set(handles.q06,'visible','on')
        set(handles.q07,'visible','on')
        set(handles.q08,'visible','on')
        set(handles.xin,'visible','on')
        set(handles.xfin,'visible','on')
        set(handles.yin,'visible','on')
        set(handles.yfin,'visible','on')
        
        set(handles.diam01,'visible','off')
        set(handles.tdiam,'visible','off')
        set(handles.ediam,'visible','off')
        set(handles.diam02,'visible','off')
        set(handles.ex,'visible','off')
        set(handles.tx,'visible','off')
        set(handles.diam03,'visible','off')
        set(handles.ey,'visible','off')
        set(handles.ty,'visible','off')
        
        set(handles.circ,'Value',0)
        set(handles.quad,'Value',1)
    else
        
        set(handles.q01,'visible','off')
        set(handles.q02,'visible','off')
        set(handles.q03,'visible','off')
        set(handles.q04,'visible','off')
        set(handles.q05,'visible','off')
        set(handles.q06,'visible','off')
        set(handles.q07,'visible','off')
        set(handles.q08,'visible','off')
        set(handles.xin,'visible','off')
        set(handles.xfin,'visible','off')
        set(handles.yin,'visible','off')
        set(handles.yfin,'visible','off')
        
        set(handles.diam01,'visible','off')
        set(handles.tdiam,'visible','off')
        set(handles.ediam,'visible','off')
        set(handles.diam02,'visible','off')
        set(handles.ex,'visible','off')
        set(handles.tx,'visible','off')
        set(handles.diam03,'visible','off')
        set(handles.ey,'visible','off')
        set(handles.ty,'visible','off')
        
        set(handles.circ,'Value',0)
        set(handles.quad,'Value',0)
        
    end
    
    set(handles.formaonda,'Value',(fontedk{fontenumdk,3}(2) + 1))
    
    textotipoexc(handles,fontenumdk)

    
    set(handles.corfon,'Visible','on')
    set(gcf,'currentaxes',handles.corfon)
    imagesc(fontenumdk)
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

% --- Executes during object creation, after setting all properties.
function numfonte_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numfonte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in infonte.
function infonte_Callback(hObject, eventdata, handles)
% hObject    handle to infonte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global quantfonte fontedk Ty Tx idioma simu
if quantfonte == 0
    if idioma == 1
        set(handles.numfonte,'string', 'Source 1');
    elseif idioma == 2
        set(handles.numfonte,'string', 'Fonte 1');
    end
    quantfonte = 1;
    set(handles.selcampo,'Visible','on')
    set(handles.formant,'Visible','on')
    set(handles.gante,'Visible','on')
    set(handles.pushbutton8,'Visible','on')
    set(handles.formaonda,'Visible','on')
    set(handles.circ,'Value',0)
    set(handles.quad,'Value',0)
    set(handles.q01,'visible','off')
    set(handles.q02,'visible','off')
    set(handles.q03,'visible','off')
    set(handles.q04,'visible','off')
    set(handles.q05,'visible','off')
    set(handles.q06,'visible','off')
    set(handles.q07,'visible','off')
    set(handles.q08,'visible','off')
    set(handles.xin,'visible','off')
    set(handles.xfin,'visible','off')
    set(handles.yin,'visible','off')
    set(handles.yfin,'visible','off')
    
    set(handles.diam01,'visible','off')
    set(handles.tdiam,'visible','off')
    set(handles.ediam,'visible','off')
    set(handles.diam02,'visible','off')
    set(handles.ex,'visible','off')
    set(handles.tx,'visible','off')
    set(handles.diam03,'visible','off')
    set(handles.ey,'visible','off')
    set(handles.ty,'visible','off')
    
    
else
    if idioma == 1
        msgfon = 'Source ';
    elseif idioma == 2
        msgfon = 'Fonte ';
    end
    tfonte = get (handles.numfonte,'string');
    quantfonte = quantfonte + 1;
    fontedk{quantfonte,1} = zeros(Ty,Tx);
    fontedk{quantfonte,2} = 0;
    fontedk{quantfonte,3} = zeros(1,6);
    fontedk{quantfonte,3}(1) = 0;
    amsg = [msgfon num2str(quantfonte)];
    set(handles.numfonte,'string', [tfonte; amsg]);
    
    set(gcf,'currentaxes',handles.corfon)
    imagesc(get(handles.numfonte,'Value'))
    set(handles.corfon,'Clim',[-1 quantfonte])
    set(handles.corfon,'xtickmode','manual')
    set(handles.corfon,'ytickmode','manual')
    set(handles.corfon,'ztickmode','manual')
    
    set(handles.corfon,'xticklabelmode','manual')
    set(handles.corfon,'yticklabelmode','manual')
    set(handles.corfon,'zticklabelmode','manual')
    set(handles.corfon,'yticklabel',0)
    set(handles.corfon,'XTick',zeros(1,0))
    set(handles.corfon,'YTick',0)
    
    set(handles.axes1,'CLim', [-1 quantfonte])
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


% --- Executes on button press in retfonte.
function retfonte_Callback(hObject, eventdata, handles)
% hObject    handle to retfonte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global quantfonte fontedk fonteimg Ty Tx idioma

if quantfonte == 1
    if idioma == 1
        set(handles.numfonte,'string', 'Click in Insert');
    elseif idioma == 2
    set(handles.numfonte,'string', 'Clique em Inserir');
    end
    quantfonte = 0;
    set(handles.selcampo,'Visible','off')
    set(handles.formant,'Visible','off')
    set(handles.gante,'Visible','off')
    set(handles.pushbutton8,'Visible','off')
    set(handles.formaonda,'Visible','off')
    set(handles.circ,'Value',0)
    set(handles.quad,'Value',0)
    
    set(handles.q01,'visible','off')
    set(handles.q02,'visible','off')
    set(handles.q03,'visible','off')
    set(handles.q04,'visible','off')
    set(handles.q05,'visible','off')
    set(handles.q06,'visible','off')
    set(handles.q07,'visible','off')
    set(handles.q08,'visible','off')
    set(handles.xin,'visible','off')
    set(handles.xfin,'visible','off')
    set(handles.yin,'visible','off')
    set(handles.yfin,'visible','off')
    
    set(handles.diam01,'visible','off')
    set(handles.tdiam,'visible','off')
    set(handles.ediam,'visible','off')
    set(handles.diam02,'visible','off')
    set(handles.ex,'visible','off')
    set(handles.tx,'visible','off')
    set(handles.diam03,'visible','off')
    set(handles.ey,'visible','off')
    set(handles.ty,'visible','off')
    
    set(handles.onda,'string','');
    set(handles.p1,'string','');
    set(handles.p2,'string','');
    set(handles.p3,'string','');
    set(handles.p4,'string','');
    set(handles.campsel,'String','')
    
    set(handles.corfon,'Visible','off')
    
    set(gcf,'currentaxes',handles.axes1)
    fontedk{1,1} = zeros(Ty,Tx);
    fonteimg = zeros(Ty,Tx);
    imagesc(fonteimg)
    
elseif quantfonte > 1
    tfonte = get (handles.numfonte,'string');
    quantfonte = quantfonte - 1;
    if get(handles.numfonte,'value') == (quantfonte + 1)
        set(handles.numfonte,'value',quantfonte);
    end
    for a = 1:Ty
        for b = 1:Tx
            if fontedk{(quantfonte + 1),1}
                fonteimg(Ty,Tx) = 0;
            end
        end
    end
    fontedk{(quantfonte + 1),1} = zeros(Ty,Tx);
    set(gcf,'currentaxes',handles.axes1)
    imagesc(fonteimg)
    
    set(handles.axes1,'xtickmode','auto')
    set(handles.axes1,'ytickmode','auto')
    set(handles.axes1,'ztickmode','auto')
    
    set(handles.axes1,'xticklabelmode','auto')
    set(handles.axes1,'yticklabelmode','auto')
    set(handles.axes1,'zticklabelmode','auto')
    set(handles.axes1,'CLim', [-1 quantfonte])
    
    set(handles.numfonte,'string', tfonte(1:(end - 1),:));
    
    set(handles.corfon,'Clim',[-1 quantfonte])
end


% --- Executes when selected object is changed in selcampo.
function selcampo_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in selcampo
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global campfonte quantfonte fontedk idioma TEM
%Ajustando o idioma
if idioma == 1
    msgchx = 'Field Hx (A/m)';
    msgchy = 'Field Hy (A/m)';
    msgcez = 'Field Ez (V/m)';
    msgcc = 'Heat (W/m³)';
    if TEM == 2
        msgchx = 'Field Ex (V/m)';
        msgchy = 'Field Ey (V/m)';
        msgcez = 'Field Hz (A/m)';
    end
elseif idioma == 2
    msgchx = 'Campo Hx (A/m)';
    msgchy = 'Campo Hy (A/m)';
    msgcez = 'Campo Ez (V/m)';
    msgcc = 'Calor (W/m³)';
    if TEM == 2
        msgchx = 'Campo Ex (V/m)';
        msgchy = 'Campo Ey (V/m)';
        msgcez = 'Campo Hz (A/m)';
    end
end

if get(handles.cHx,'Value')
    campfonte = 1;
    set(handles.campsel,'String',msgchx)
elseif get(handles.cHy,'Value')
    campfonte = 2;
    set(handles.campsel,'String',msgchy)
elseif get(handles.cEz,'Value')
    campfonte = 3;
    set(handles.campsel,'String',msgcez)
elseif get(handles.cCalor,'Value')
    campfonte = 4;
    set(handles.campsel,'String',msgcc)
end

if quantfonte
    fontenumdk = get(handles.numfonte,'Value');
    fontedk{fontenumdk,2} = campfonte;
end

set(handles.corfon,'Visible','on')
set(gcf,'currentaxes',handles.corfon)
imagesc(fontenumdk)

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




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fontedk Ty Tx fonteimg quantfonte
fontenumdk = get(handles.numfonte,'Value');
for a = 1:Ty
    for b = 1:Tx
        if fontedk{fontenumdk,1}(a,b)
            fonteimg(a,b) = 0;
        end
    end
end
fontedk{fontenumdk,1} = zeros(Ty,Tx);
set(gcf,'currentaxes',handles.axes1)
imagesc(fonteimg)
set(handles.axes1,'xtickmode','auto')
set(handles.axes1,'ytickmode','auto')
set(handles.axes1,'ztickmode','auto')

set(handles.axes1,'xticklabelmode','auto')
set(handles.axes1,'yticklabelmode','auto')
set(handles.axes1,'zticklabelmode','auto')
set(handles.axes1,'CLim', [-1 quantfonte])
