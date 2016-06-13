function varargout = malhaentrada(varargin)
% MALHAENTRADA MATLAB code for malhaentrada.fig
%      MALHAENTRADA, by itself, creates a new MALHAENTRADA or raises the existing
%      singleton*.
%
%      H = MALHAENTRADA returns the handle to a new MALHAENTRADA or the handle to
%      the existing singleton*.
%
%      MALHAENTRADA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MALHAENTRADA.M with the given input arguments.
%
%      MALHAENTRADA('Property','Value',...) creates a new MALHAENTRADA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before malhaentrada_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to malhaentrada_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help malhaentrada

% Last Modified by GUIDE v2.5 03-Aug-2011 23:57:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @malhaentrada_OpeningFcn, ...
    'gui_OutputFcn',  @malhaentrada_OutputFcn, ...
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


% --- Executes just before malhaentrada is made visible.
function malhaentrada_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to malhaentrada (see VARARGIN)

% Choose default command line output for malhaentrada
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes malhaentrada wait for user response (see UIRESUME)
% uiwait(handles.figure1);

textomalhaentfig (handles)




% --- Outputs from this function are returned to the command line.
function varargout = malhaentrada_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Tye_Callback(hObject, eventdata, handles)
% hObject    handle to Tye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tye as text
%        str2double(get(hObject,'String')) returns contents of Tye as a double
global Ty
Ty = str2double(get(hObject,'String'));
set(handles.Tys,'string',num2str(Ty))


% --- Executes during object creation, after setting all properties.
function Tye_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tye (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Txe_Callback(hObject, eventdata, handles)
% hObject    handle to Txe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Txe as text
%        str2double(get(hObject,'String')) returns contents of Txe as a double
global Tx
Tx = str2double(get(hObject,'String'));
set(handles.Txs,'string',num2str(Tx))

% --- Executes during object creation, after setting all properties.
function Txe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Txe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dle_Callback(hObject, eventdata, handles)
% hObject    handle to dle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dle as text
%        str2double(get(hObject,'String')) returns contents of dle as a double
global dl dtTLM tabcar simu
dl = str2double(get(hObject,'String'));
set(handles.dls,'string',[num2str(dl),' m'])
if simu ~= 3
    dtTLM = 100;
    e0 = 8.854e-12;
    u0 = 4*pi*1e-7;
    for a = 1:size(tabcar,1)
        b = sqrt((tabcar(a,1)*e0*tabcar(a,3)*u0)/2)*dl;
        if dtTLM > b
            dtTLM = b;
        end
    end
end

% --- Executes during object creation, after setting all properties.
function dle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gmalha.
function gmalha_Callback(hObject, eventdata, handles)
% hObject    handle to gmalha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ty Tx ent dl fronthorizontal frontvertical fortabhor fortabver ...
    mostraopcao fonteimg fontedk dimenmalha msgflux valflux
if dimenmalha == 1
    Ty = 1;
elseif dimenmalha == 2
    Ty = str2double(get(handles.Tye,'String'));
end
Tx = str2double(get(handles.Txe,'String'));

ent = ones(Ty,Tx);
dl = str2double(get(handles.dle,'string'));

textomalhaentfig(handles)



% Ajustando para a fonte
fonteimg = zeros(Ty,Tx);
fontedk{1,1} = zeros(Ty,Tx);


% Ajustando as variáveis da fronteira
fronthorizontal = ones(2,Ty,2);
frontvertical = ones(2,Tx,2);

fortabhor = cell(2,Ty);
for a1 = 1:Ty
    fazopcao = size(mostraopcao{1,1},1);
    fortabhor{1,a1} = cell(1,fazopcao);
    for bbop = 1:fazopcao
        fortabhor{1,a1}{1,bbop} = num2str(bbop);
    end
    
    fazopcao = size(mostraopcao{1,2},1);
    fortabhor{2,a1} = cell(1,fazopcao);
    for bbop = 1:fazopcao
        fortabhor{2,a1}{1,bbop} = num2str(bbop);
    end
end



fortabver = cell(2,Tx);
for a1 = 1:Tx 
    fazopcao = size(mostraopcao{1,1},1);
    fortabver{1,a1} = cell(1,fazopcao);
    for bbop = 1:fazopcao
        fortabver{1,a1}{1,bbop} = num2str(bbop);
    end
    
    fazopcao = size(mostraopcao{1,2},1);
    fortabver{2,a1} = cell(1,fazopcao);
    for bbop = 1:fazopcao
        fortabver{2,a1}{1,bbop} = num2str(bbop);
    end
end

% Variáveis para verificar o fluxo
msgflux = cell(1,2);
msgflux{1,1} = 'Flux among Environment';
msgflux{1,2} = 'Fluxo entre os Meios';
valflux = 0;



% --- Executes on button press in edcar.
function edcar_Callback(hObject, eventdata, handles)
% hObject    handle to edcar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edcar
close(malhaentrada)

% --- Executes on button press in retornar.
function retornar_Callback(hObject, eventdata, handles)
% hObject    handle to retornar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tlm
close(malhaentrada)
