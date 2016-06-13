function varargout = resulgui(varargin)
% RESULGUI MATLAB code for resulgui.fig
%      RESULGUI, by itself, creates a new RESULGUI or raises the existing
%      singleton*.
%
%      H = RESULGUI returns the handle to a new RESULGUI or the handle to
%      the existing singleton*.
%
%      RESULGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULGUI.M with the given input arguments.
%
%      RESULGUI('Property','Value',...) creates a new RESULGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resulgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resulgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resulgui

% Last Modified by GUIDE v2.5 04-May-2012 19:07:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @resulgui_OpeningFcn, ...
    'gui_OutputFcn',  @resulgui_OutputFcn, ...
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


% --- Executes just before resulgui is made visible.
function resulgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resulgui (see VARARGIN)

% Choose default command line output for resulgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resulgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

textoresulgui(handles)

% --- Outputs from this function are returned to the command line.
function varargout = resulgui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






function kres_Callback(hObject, eventdata, handles)
% hObject    handle to kres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kres as text
%        str2double(get(hObject,'String')) returns contents of kres as a double


% --- Executes during object creation, after setting all properties.
function kres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xres_Callback(hObject, eventdata, handles)
% hObject    handle to xres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xres as text
%        str2double(get(hObject,'String')) returns contents of xres as a double


% --- Executes during object creation, after setting all properties.
function xres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yres_Callback(hObject, eventdata, handles)
% hObject    handle to yres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yres as text
%        str2double(get(hObject,'String')) returns contents of yres as a double


% --- Executes during object creation, after setting all properties.
function yres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global camposimu dimenmalha ppon
%descobrindo o campo selecionado
switch 1
    case get(handles.chx,'value')
        campo = 1;
    case get(handles.chy,'value')
        campo = 2;
    case get(handles.cez,'value')
        campo = 3;
    case get(handles.cSAR,'value')
        campo = 4;
    case get(handles.rbtemp,'value')
        campo = 5;
end




%descobrindo a opção de visualização
switch 1
    case get(handles.prop,'value')
        res = 2;
    case get(handles.pont,'value')
        res = 3;
    case get(handles.campox,'value')
        res = 4;
    case get(handles.campoy,'value')
        res = 5;
    case get(handles.vet,'value')
        res = 6;
    case get(handles.propx,'value')
        res = 7;
    case get(handles.propy,'value')
        res = 8;
    case get(handles.contornodinamico,'value')
        res = 9;
    case get(handles.contornoestatico,'value')
        res = 10;
    case get(handles.Fourierbtn,'value')
        res = 11;
end

load('todas');

k2 = (str2num(get(handles.kres,'string')));
x = str2num(get(handles.xres,'string'));
y = str2num(get(handles.yres,'string'));
freq = 0;
if ~isempty(str2num(get(handles.freqined,'string')))
    freq = str2num(get(handles.freqined,'string'));    %freq. in
end
pon = [x y];
modo = 1;
Amp = 1;

if simu ~= 3
    ppon = respostas(Tbs, pon, res, nsdy, nsdx, k, ...
        Tx, Ty, Amp, SARval, nnosy, nnosx, x, y, freq, k2, nres, modo, ...
        campo, camposimu, dl, dimenmalha);
else
    ppon = respostas(entdk, pon, res, nsdy, nsdx, k, ...
        Tx, Ty, Amp, SARval, nnosy, nnosx, x, y, freq, k2, nres, modo, ...
        campo, camposimu, dl, dimenmalha);
end





% --- Executes on button press in retorno.
function retorno_Callback(hObject, eventdata, handles)
% hObject    handle to retorno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tlm
close(resulgui)



function freqined_Callback(hObject, eventdata, handles)
% hObject    handle to freqined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqined as text
%        str2double(get(hObject,'String')) returns contents of freqined as a double


% --- Executes during object creation, after setting all properties.
function freqined_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function passofreqed_Callback(hObject, eventdata, handles)
% hObject    handle to passofreqed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of passofreqed as text
%        str2double(get(hObject,'String')) returns contents of passofreqed as a double


% --- Executes during object creation, after setting all properties.
function passofreqed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to passofreqed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function freqfimed_Callback(hObject, eventdata, handles)
% hObject    handle to freqfimed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of freqfimed as text
%        str2double(get(hObject,'String')) returns contents of freqfimed as a double


% --- Executes during object creation, after setting all properties.
function freqfimed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to freqfimed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel3.
function uipanel3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch 1
    case get(handles.Fourierbtn,'value')
        set(handles.freqintxt,'visible','on')
        set(handles.freqined,'visible','on')
    otherwise
        set(handles.freqintxt,'visible','off')
        set(handles.freqined,'visible','off')
end
