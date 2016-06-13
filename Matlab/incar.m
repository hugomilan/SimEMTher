function varargout = incar(varargin)
% INCAR MATLAB code for incar.fig
%      INCAR, by itself, creates a new INCAR or raises the existing
%      singleton*.
%
%      H = INCAR returns the handle to a new INCAR or the handle to
%      the existing singleton*.
%
%      INCAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INCAR.M with the given input arguments.
%
%      INCAR('Property','Value',...) creates a new INCAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before incar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to incar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help incar

% Last Modified by GUIDE v2.5 28-Jan-2012 15:17:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @incar_OpeningFcn, ...
                   'gui_OutputFcn',  @incar_OutputFcn, ...
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


% --- Executes just before incar is made visible.
function incar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to incar (see VARARGIN)

% Choose default command line output for incar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes incar wait for user response (see UIRESUME)
% uiwait(handles.figure1);
textoincar(handles)


% --- Outputs from this function are returned to the command line.
function varargout = incar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listcar.
function listcar_Callback(hObject, eventdata, handles)
% hObject    handle to listcar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listcar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listcar
set(handles.textocar,'string',num2str(get(hObject,'value')))

% --- Executes during object creation, after setting all properties.
function listcar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listcar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xin_Callback(hObject, eventdata, handles)
% hObject    handle to xin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xin as text
%        str2double(get(hObject,'String')) returns contents of xin as a double
set(handles.xtin,'string',get(hObject,'string'))

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
set(handles.xtfin,'string',get(hObject,'string'))

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
set(handles.ytin,'string',get(hObject,'string'))

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
set(handles.ytfin,'string',get(hObject,'string'))

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
edcar
close(incar)


% --- Executes on button press in adicionar.
function adicionar_Callback(hObject, eventdata, handles)
% hObject    handle to adicionar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ent tabcar  Tx Ty matflux msgflux valflux dimenmalha
carnum = (get(handles.listcar,'Value'));
xin = str2double(get(handles.xin,'string'));
xfin = str2double(get(handles.xfin,'string'));

if dimenmalha == 1
    yin = 1;
    yfin = 1;
elseif dimenmalha == 2
    yin = str2double(get(handles.yin,'string'));
    yfin = str2double(get(handles.yfin,'string'));
end


ent(yin:yfin,xin:xfin) = carnum*ones(yfin-yin+1,xfin-xin+1);

textoincar(handles)

%% Verificando as possibilidades de convecção e radiação
msgflux = cell(1,2);
msgflux{1,1} = 'Flux among Environment';
msgflux{1,2} = 'Fluxo entre os Meios';

if dimenmalha == 1
    matflux = zeros(size(tabcar,1),size(tabcar,1),4);
    for x = 2:(Tx-1)
        if (ent(1,x) - ent(1,x-1)) ~= 0
            matflux(ent(1,x),ent(1,x-1),2) = 1;
        end
        if (ent(1,x) - ent(1,x+1)) ~= 0
            matflux(ent(1,x),ent(1,x+1),4) = 1;
        end
    end
    
    
    
    
elseif dimenmalha == 2
    matflux = zeros(size(tabcar,1),size(tabcar,1),4);
    for x = 2:(Tx-1)
        for y = 2:(Ty-1)
            if (ent(y,x) - ent(y+1,x)) ~= 0
                matflux(ent(y,x),ent(y+1,x),1) = 1;
            end
            if (ent(y,x) - ent(y,x-1)) ~= 0
                matflux(ent(y,x),ent(y,x-1),2) = 1;
            end
            if (ent(y,x) - ent(y-1,x)) ~= 0
                matflux(ent(y,x),ent(y-1,x),3) = 1;
            end
            if (ent(y,x) - ent(y,x+1)) ~= 0
                matflux(ent(y,x),ent(y,x+1),4) = 1;
            end
        end
    end
end


msgporta = cell(2,4);
msgporta{1,1} = ' to down.';
msgporta{1,2} = ' to left.';
msgporta{1,3} = ' to up.';
msgporta{1,4} = ' to right.';

msgporta{2,1} = ' por baixo.';
msgporta{2,2} = ' pela esquerda.';
msgporta{2,3} = ' por cima.';
msgporta{2,4} = ' pela direta.';

valflux = [0 0 0 0]; %zeros(vm,2);

vm = 2;
if dimenmalha == 1
    for porta = 1:4
        for x = 1:size(matflux,1)
            for y = 1:size(matflux,1)
                if matflux(x,y,porta) == 1
                    msgflux{vm,1} = ['Environment flux ', num2str(x) ...
                        ' to ', num2str(y), msgporta{1,porta}];
                    msgflux{vm,2} = ['Fluxo do meio ', num2str(x) ...
                        ' para ', num2str(y), msgporta{2,porta}];
                    valflux(vm,:) = [0 (x) (y) porta];
                    vm = vm + 1;
                end
            end
        end
    end
    
    
    
elseif dimenmalha == 2
    for porta = 1:4
        for x = 1:size(matflux,1)
            for y = 1:size(matflux,1)
                if matflux(x,y,porta) == 1
                    msgflux{vm,1} = ['Environment flux ', num2str(x) ...
                        ' to ', num2str(y), msgporta{1,porta}];
                    msgflux{vm,2} = ['Fluxo do meio ', num2str(x) ...
                        ' para ', num2str(y), msgporta{2,porta}];
                    valflux(vm,:) = [0 (x) (y) porta];
                    vm = vm + 1;
                end
            end
        end
    end
end
