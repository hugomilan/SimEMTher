function varargout = fluxext(varargin)
% FLUXEXT MATLAB code for fluxext.fig
%      FLUXEXT, by itself, creates a new FLUXEXT or raises the existing
%      singleton*.
%
%      H = FLUXEXT returns the handle to a new FLUXEXT or the handle to
%      the existing singleton*.
%
%      FLUXEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLUXEXT.M with the given input arguments.
%
%      FLUXEXT('Property','Value',...) creates a new FLUXEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fluxext_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fluxext_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fluxext

% Last Modified by GUIDE v2.5 30-Apr-2012 16:38:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fluxext_OpeningFcn, ...
                   'gui_OutputFcn',  @fluxext_OutputFcn, ...
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


% --- Executes just before fluxext is made visible.
function fluxext_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fluxext (see VARARGIN)

% Choose default command line output for fluxext
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fluxext wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% Iniciando
textofluxext(handles)

ajustaflux(handles)

% --- Outputs from this function are returned to the command line.
function varargout = fluxext_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lista.
function lista_Callback(hObject, eventdata, handles)
% hObject    handle to lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lista contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lista


% --- Executes during object creation, after setting all properties.
function lista_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Inserirbtn.
function Inserirbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Inserirbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fluxosext idioma


if idioma == 1
    titulo = 'Flux';
    tipoflux = ['Input one of this number: 1 - Convection flux; '...
        '2 - Radiation flux, 3 - Convection and Radiation flux:'];
    mat = 'nº of Material';
    diamec = 'Characteristic Diameter (m)';
    objgeo = '1 - Horizontal Cylinder; 2 - Vertical Cylinder; 3 - Globe';
elseif idioma == 2
    titulo = 'Fluxo';
    tipoflux = ['Insira um dos números: 1 - Fluxo por Convecção; '...
        '2 - Fluxo por Radiação, 3 - Fluxo por Convecção e Radiação:'];
    mat = 'nº do Material';
    diamec = 'Diâmetro Característico (m)';
    objgeo = '1 - Cilindro Horizontal; 2 - Cilindro Vertical; 3 - Globo';
end
            
tipo = inputdlg({tipoflux mat diamec objgeo},titulo,1);
if fluxosext(1,1) == 0
    fluxosext(1,1) = str2num(tipo{1,1});
    fluxosext(1,2) = str2num(tipo{2,1});
    fluxosext(1,3) = str2num(tipo{3,1});
    fluxosext(1,4) = str2num(tipo{4,1});
else
    fluxosext(end+1,1) = str2num(tipo{1,1});
    fluxosext(end,2) = str2num(tipo{2,1});
    fluxosext(end,3) = str2num(tipo{3,1});
    fluxosext(end,4) = str2num(tipo{4,1});
end

ajustaflux(handles)





% --- Executes on button press in Retirarbtn.
function Retirarbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Retirarbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fluxosext

a = get(handles.lista,'value');

if fluxosext(1,1) == 0
    
elseif size(fluxosext,1) == 1
    fluxosext(1,:) = [0 0 0 0];
elseif a == size(fluxosext,1)
    fluxosext = fluxosext(1:(end-1),:);
else
    
    for b = a:(size(fluxosext,1)-1)
        fluxosext(b,:) = fluxosext(b+1,:);
    end
    fluxosext = fluxosext(1:b,:);
    
end
ajustaflux(handles)


% --- Executes on button press in Retornarbtn.
function Retornarbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Retornarbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edcar
close(fluxext)
