function varargout = tlm(varargin)
% TLM MATLAB code for tlm.fig
%      TLM, by itself, creates a new TLM or raises the existing
%      singleton*.
%
%      H = TLM returns the handle to a new TLM or the handle to
%      the existing singleton*.
%
%      TLM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TLM.M with the given input arguments.
%
%      TLM('Property','Value',...) creates a new TLM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tlm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tlm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tlm

% Last Modified by GUIDE v2.5 03-Mar-2012 22:17:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tlm_OpeningFcn, ...
                   'gui_OutputFcn',  @tlm_OutputFcn, ...
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


% --- Executes just before tlm is made visible.
function tlm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tlm (see VARARGIN)

% Choose default command line output for tlm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tlm wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global k

if isempty(k)
    criaglobais
end
% Setando a quantidade de passos-de-tempo no texto editável
set(handles.kpassos,'string',num2str(k))



% Setando as logos no programa
set(gcf,'currentaxes',handles.figDEE)
imshow('DEE.jpg')
set(gcf,'currentaxes',handles.figGPMSE)
imshow('GPMSE.jpg')


textotlmfig(handles)


% --- Outputs from this function are returned to the command line.
function varargout = tlm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Arquivos_Callback(hObject, eventdata, handles)
% hObject    handle to Arquivos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function salvar_Callback(hObject, eventdata, handles)
% hObject    handle to salvar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Salvandos todas as variáveis necessárias para que o meio em análise seja
% reaberto
global ent dl k tabcar fontedk camposimu quantfonte dtTLM simu textoaviso ...
 mostraopcao fronthorizontal frontvertical fortabhor fortabver verifther ...
 verifem valorfronteira rosan cpsan tsan BHE flux valflux msgflux matflux ...
 dimenmalha saltosimu fonteimg TEM fluxosext Altitude Latitude Ta Dgn Tgn VV

fronteira = cell(1,9);
fronteira{1,1} = textoaviso;
fronteira{1,2} = mostraopcao;
fronteira{1,3} = fronthorizontal;
fronteira{1,4} = frontvertical;
fronteira{1,5} = fortabhor;
fronteira{1,6} = fortabver;
fronteira{1,7} = verifem;
fronteira{1,8} = verifther;
fronteira{1,9} = valorfronteira;

salvar.ent = ent;
salvar.dl = dl;
salvar.k = k;
salvar.tabcar = tabcar;
salvar.fontedk = fontedk;
salvar.quantfonte = quantfonte;
salvar.dtTLM = dtTLM;
salvar.camposimu = camposimu;
salvar.simu = simu;
salvar.fronteira = fronteira;
salvar.rosan = rosan;
salvar.cpsan = cpsan;
salvar.tsan = tsan;
salvar.BHE = BHE;
salvar.flux = flux;
salvar.valflux = valflux;
salvar.msgflux = msgflux;
salvar.matflux = matflux;
salvar.dimenmalha = dimenmalha;
salvar.saltosimu = saltosimu;
salvar.fonteimg = fonteimg;
salvar.TEM = TEM;
salvar.fluxosext = fluxosext;
salvar.Altitude = Altitude;
salvar.Latitude = Latitude;
salvar.Ta = Ta;
salvar.Tgn = Tgn;
salvar.Dgn = Dgn;
salvar.VV = VV;

uisave('salvar');

% -------------------------,-------------------------------------------
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Abrindo todas as variáveis necessárias para que o meio em análise seja
% continuado
global ent dl k tabcar camposimu Tx Ty fontedk quantfonte dtTLM simu ...
        textoaviso mostraopcao fronthorizontal frontvertical fortabhor ...
        fortabver verifther verifem valorfronteira rosan cpsan tsan BHE ...
        flux valflux msgflux matflux corcar dimenmalha saltosimu fonteimg ...
        TEM fluxosext Altitude Latitude Ta Tgn Dgn VV
uiopen
if exist('salvar')
    
    
    ent = salvar.ent;
    dl = salvar.dl;
    k = salvar.k;
    tabcar = salvar.tabcar;
    fontedk = salvar.fontedk;
    quantfonte = salvar.quantfonte;
    dtTLM = salvar.dtTLM;
    camposimu = salvar.camposimu;
    simu = salvar.simu;
    fronteira = salvar.fronteira;
    rosan = salvar.rosan;
    cpsan = salvar.cpsan;
    tsan = salvar.tsan;
    BHE = salvar.BHE;
    flux = salvar.flux;
    valflux = salvar.valflux;
    msgflux = salvar.msgflux;
    matflux = salvar.matflux;
    dimenmalha = salvar.dimenmalha;
    saltosimu = salvar.saltosimu;
    fonteimg = salvar.fonteimg;
    TEM = salvar.TEM;
    fluxosext = salvar.fluxosext;
    Altitude = salvar.Altitude;
    Latitude = salvar.Latitude;
    Ta = salvar.Ta;
    Tgn = salvar.Tgn;
    Dgn = salvar.Dgn;
    VV = salvar.VV;
    
    textoaviso = fronteira{1,1};
    mostraopcao = fronteira{1,2};
    fronthorizontal = fronteira{1,3};
    frontvertical = fronteira{1,4};
    fortabhor = fronteira{1,5};
    fortabver = fronteira{1,6};
    verifem = fronteira{1,7};
    verifther = fronteira{1,8};
    valorfronteira = fronteira{1,9};
    
    corcar = [1:size(tabcar,1)]';
    
    [Ty Tx] = size(ent);
    
    clear salvar
    textotlmfig(handles)
end

% --------------------------------------------------------------------
function fechar_Callback(hObject, eventdata, handles)
% hObject    handle to fechar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --- Executes on button press in malhaentrada.
function malhaentrada_Callback(hObject, eventdata, handles)
% hObject    handle to malhaentrada (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
malhaentrada
close(tlm)


% --- Executes on button press in editarfonte.
function editarfonte_Callback(hObject, eventdata, handles)
% hObject    handle to editarfonte (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fonteedit
close(tlm)


% --- Executes on button press in simular.
function simular_Callback(hObject, eventdata, handles)
% hObject    handle to simular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
simular
close(tlm)



function kpassos_Callback(hObject, eventdata, handles)
% hObject    handle to kpassos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kpassos as text
%        str2double(get(hObject,'String')) returns contents of kpassos as a double
global k

k = str2double(get(hObject,'string'));
textotlmfig(handles)



% --- Executes during object creation, after setting all properties.
function kpassos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kpassos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resul.
function resul_Callback(hObject, eventdata, handles)
% hObject    handle to resul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resulgui
close(tlm)


% --- Executes on selection change in popidioma.
function popidioma_Callback(hObject, eventdata, handles)
% hObject    handle to popidioma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popidioma contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popidioma
global idioma
idioma = get(handles.popidioma,'value');
textotlmfig(handles)


% --- Executes during object creation, after setting all properties.
function popidioma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popidioma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pupdimensao.
function pupdimensao_Callback(hObject, eventdata, handles)
% hObject    handle to pupdimensao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupdimensao contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupdimensao
global dimenmalha
dimenmalha = get(hObject,'value');
textotlmfig(handles)
% trocadimensao(dimenmalha)

% --- Executes during object creation, after setting all properties.
function pupdimensao_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupdimensao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edsalto_Callback(hObject, eventdata, handles)
% hObject    handle to edsalto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edsalto as text
%        str2double(get(hObject,'String')) returns contents of edsalto as a double
global saltosimu

saltosimu = str2num(get(hObject,'string'));

textotlmfig(handles)

% --- Executes during object creation, after setting all properties.
function edsalto_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edsalto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
