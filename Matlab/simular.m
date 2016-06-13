function varargout = simular(varargin)
% SIMULAR MATLAB code for simular.fig
%      SIMULAR, by itself, creates a new SIMULAR or raises the existing
%      singleton*.
%
%      H = SIMULAR returns the handle to a new SIMULAR or the handle to
%      the existing singleton*.
%
%      SIMULAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULAR.M with the given input arguments.
%
%      SIMULAR('Property','Value',...) creates a new SIMULAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simular_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simular_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simular

% Last Modified by GUIDE v2.5 26-Apr-2012 19:23:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @simular_OpeningFcn, ...
    'gui_OutputFcn',  @simular_OutputFcn, ...
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


% --- Executes just before simular is made visible.
function simular_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simular (see VARARGIN)

% Choose default command line output for simular
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simular wait for user response (see UIRESUME)
% uiwait(handles.figure1);

textosimular(handles)

% --- Outputs from this function are returned to the command line.
function varargout = simular_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnSimular.
function btnSimular_Callback(hObject, eventdata, handles)
% hObject    handle to btnSimular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global camposimu idioma quantcampo
if idioma == 1
    msgsim = 'Simuling...';
    msgsimfin = 'Simuling Accomplished';
    msgnosim = 'No one field selected. Please, choose one field to simule.';
elseif idioma == 2
    msgsim = 'Simulando...';
    msgsimfin = 'Simulação Concluída';
    msgnosim = ['Nenhum Campo Selecionado. Por favor,', ...
        ' escolha pelo menos um para que a simulação possa ser feita'];
end
quantcampo = 0;
if camposimu ~=1
    if (~rem(camposimu,2)) %Hx ou Ex
        quantcampo = 1;
    end
    
    if (~rem(camposimu,3)) %Hy ou Ey
        quantcampo = quantcampo + 1;
    end
    
    if (~rem(camposimu,7)) %Ez ou Hz
        quantcampo = quantcampo + 1;
    end
    
    if (~rem(camposimu,11)) %SAR
        quantcampo = quantcampo + 1;
    end
    
    if (~rem(camposimu,13)) %Térmico
        quantcampo = quantcampo + 1;
    end
    set(handles.mensagens,'string',msgsim);
    pause(1)
    tlmsimular()
    set(handles.mensagens,'string',msgsimfin);
else
    set(handles.mensagens,'string',msgnosim);
end

% --- Executes on button press in btnRetornar.
function btnRetornar_Callback(hObject, eventdata, handles)
% hObject    handle to btnRetornar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tlm
close(simular)

% --- Executes on button press in cbHx.
function cbHx_Callback(hObject, eventdata, handles)
% hObject    handle to cbHx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbHx
global camposimu
if get(hObject,'value')
    camposimu = camposimu*2;
else
    camposimu = camposimu/2;
end

% --- Executes on button press in cbHy.
function cbHy_Callback(hObject, eventdata, handles)
% hObject    handle to cbHy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbHy
global camposimu
if get(hObject,'value')
    camposimu = camposimu*3;
else
    camposimu = camposimu/3;
end

% --- Executes on button press in cbEz.
function cbEz_Callback(hObject, eventdata, handles)
% hObject    handle to cbEz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbEz
global camposimu
if get(hObject,'value')
    camposimu = camposimu*7;
else
    camposimu = camposimu/7;
end

% --- Executes on button press in cbSAR.
function cbSAR_Callback(hObject, eventdata, handles)
% hObject    handle to cbSAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbSAR
global camposimu
if get(hObject,'value')
    camposimu = camposimu*11;
else
    camposimu = camposimu/11;
end


% --- Executes on button press in chTerm.
function chTerm_Callback(hObject, eventdata, handles)
% hObject    handle to chTerm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chTerm

global camposimu
if get(hObject,'value')
    camposimu = camposimu*13;
else
    camposimu = camposimu/13;
end


% --- Executes on button press in cbcarregar.
function cbcarregar_Callback(hObject, eventdata, handles)
% hObject    handle to cbcarregar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbcarregar
global carregar
carregar = get(hObject,'Value');