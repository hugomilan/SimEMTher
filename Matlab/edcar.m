function varargout = edcar(varargin)
% EDCAR MATLAB code for edcar.fig
%      EDCAR, by itself, creates a new EDCAR or raises the existing
%      singleton*.
%
%      H = EDCAR returns the handle to a new EDCAR or the handle to
%      the existing singleton*.
%
%      EDCAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDCAR.M with the given input arguments.
%
%      EDCAR('Property','Value',...) creates a new EDCAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edcar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edcar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edcar

% Last Modified by GUIDE v2.5 03-Jun-2012 15:18:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @edcar_OpeningFcn, ...
    'gui_OutputFcn',  @edcar_OutputFcn, ...
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


% --- Executes just before edcar is made visible.
function edcar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edcar (see VARARGIN)

% Choose default command line output for edcar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edcar wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%% Inicilização
global dtTLM

textoedcar(handles)

mostra_tabela(handles)

set(handles.dttexto,'string',['dt = ',num2str(dtTLM)])

% --- Outputs from this function are returned to the command line.
function varargout = edcar_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addcar.
function addcar_Callback(hObject, eventdata, handles)
% hObject    handle to addcar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tabcar corcar


% Adicionado mais uma característica
if isempty(tabcar)
    tabcar = [1 0 1 1.2 1000 0.023 273 0 0 0];
else
    tabcar = [tabcar; 1 0 1 1.2 1000 0.023 273 0 0 0];
end

mostra_tabela(handles)

set(handles.figedcar,'clim',[0 size(tabcar,1)])


% Plotando a escala
set(gcf,'currentaxes',handles.figmostra)
corcar = (1:size(tabcar,1))';
imagesc(corcar)

set(handles.figmostra,'xtickmode','manual')
set(handles.figmostra,'ytickmode','manual')
set(handles.figmostra,'ztickmode','manual')

set(handles.figmostra,'xticklabelmode','manual')
set(handles.figmostra,'yticklabelmode','manual')
set(handles.figmostra,'zticklabelmode','manual')

b(1) = 0;
b1{1} = 0;
for c = 1:(size(tabcar,1))
    b(c+1) = c;
    b1{c+1} = num2str(c);
end

set(handles.figmostra,'yticklabel',b1)

set(handles.figmostra,'XTick',zeros(1,0))

set(handles.figmostra,'YTick',b)
set(handles.figmostra,'clim',[0 size(tabcar,1)])


% --- Executes on button press in retcar.
function retcar_Callback(hObject, eventdata, handles)
% hObject    handle to retcar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tabcar corcar
if size(tabcar,1) ~= 1
    tabcar = tabcar(1:(end-1),:);
    
    mostra_tabela(handles)
    
    set(gcf,'currentaxes',handles.figmostra)
    corcar = (1:size(tabcar,1))';
    imagesc(corcar)
    
    set(handles.figmostra,'xtickmode','manual')
    set(handles.figmostra,'ytickmode','manual')
    set(handles.figmostra,'ztickmode','manual')
    
    set(handles.figmostra,'xticklabelmode','manual')
    set(handles.figmostra,'yticklabelmode','manual')
    set(handles.figmostra,'zticklabelmode','manual')
    set(handles.figedcar,'clim',[0 size(tabcar,1)])
    
    b(1) = 0;
    b1{1} = 0;
    for c = 1:(size(tabcar,1))
        b(c+1) = c;
        b1{c+1} = num2str(c);
    end
    
    set(handles.figmostra,'yticklabel',b1)
    
    set(handles.figmostra,'XTick',zeros(1,0))
    
    set(handles.figmostra,'YTick',b)
    set(handles.figmostra,'clim',[0 size(tabcar,1)])
    
end

% --- Executes on button press in retonar.
function retonar_Callback(hObject, eventdata, handles)
% hObject    handle to retonar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
malhaentrada
close(edcar)


% --- Executes on button press in insercar.
function insercar_Callback(hObject, eventdata, handles)
% hObject    handle to insercar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
incar
close(edcar)

% --- Executes when entered data in editable cell(s) in tabelacar.
function tabelacar_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabelacar (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global tabcar dtTLM simu dl

tabnew = get(handles.tabelacar,'data');

switch simu
    case 1
        
        tabcar = tabnew;
        
    case 2
        
        tabcar(:,1) = tabnew(:,1);
        tabcar(:,2) = tabnew(:,2);
        tabcar(:,3) = tabnew(:,3);
        
    case 3
        
        tabcar(:,4) = tabnew(:,1);
        tabcar(:,5) = tabnew(:,2);
        tabcar(:,6) = tabnew(:,3);
        tabcar(:,7) = tabnew(:,4);
        tabcar(:,8) = tabnew(:,5);
        tabcar(:,9) = tabnew(:,6);
        tabcar(:,10) = tabnew(:,7);
        
end

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
    if simu == 3
        dtTLM = str2num(get(handles.eddt,'string'));
    end
    set(handles.dttexto,'string',['dt = ',num2str(dtTLM)])
end

%Verifica a convergência do modelo térmico
convBHE (handles)

% --- Executes when selected object is changed in painelsimu.
function painelsimu_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in painelsimu
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global tabcar simu dtTLM dl TEM dimenmalha

switch 1
    case get(handles.simuemter,'value')
        simu = 1;
        if  dimenmalha == 2
            set(handles.EMpainel,'visible','on')
            set(handles.TMbtn,'value',0)
            set(handles.TEbtn,'value',0)
        end
    case get(handles.simuem,'value')
        simu = 2;
        if  dimenmalha == 2
            set(handles.EMpainel,'visible','on')
            set(handles.TMbtn,'value',0)
            set(handles.TEbtn,'value',0)
        end
    case get(handles.simuter,'value')
        simu = 3;
        TEM = 0;
        set(handles.EMpainel,'visible','off')
        set(handles.TEbtn,'value',0)
        set(handles.TMbtn,'value',0)
end

mostra_tabela(handles)

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
    if simu == 3
        dtTLM = str2num(get(handles.eddt,'string'));
    end
    set(handles.dttexto,'string',['dt = ',num2str(dtTLM)])
end

% Verificação da convergência do modelo da BHE
convBHE (handles)


function eddt_Callback(hObject, eventdata, handles)
% hObject    handle to eddt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eddt as text
%        str2double(get(hObject,'String')) returns contents of eddt as a double
global dtTLM

dtTLM = str2num(get(handles.eddt,'string'));
set(handles.dttexto,'string',['dt = ',num2str(dtTLM)])

% Verificação da convergência do modelo da BHE
convBHE (handles)


% --- Executes during object creation, after setting all properties.
function eddt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eddt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edrosan_Callback(hObject, eventdata, handles)
% hObject    handle to edrosan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edrosan as text
%        str2double(get(hObject,'String')) returns contents of edrosan as a double
global rosan
rosan = str2num(get(hObject,'string'));
set(handles.txtvrosan,'string',num2str(rosan));

% --- Executes during object creation, after setting all properties.
function edrosan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edrosan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edcpsan_Callback(hObject, eventdata, handles)
% hObject    handle to edcpsan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edcpsan as text
%        str2double(get(hObject,'String')) returns contents of edcpsan as a double
global cpsan
cpsan = str2num(get(hObject,'string'));
set(handles.txtvcpsan,'string',num2str(cpsan));

% --- Executes during object creation, after setting all properties.
function edcpsan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edcpsan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtsan_Callback(hObject, eventdata, handles)
% hObject    handle to edtsan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtsan as text
%        str2double(get(hObject,'String')) returns contents of edtsan as a double
global tsan
tsan = str2num(get(hObject,'string'));
set(handles.txtvtsan,'string',num2str(tsan));

% --- Executes during object creation, after setting all properties.
function edtsan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtsan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbfluxconv.
function cbfluxconv_Callback(hObject, eventdata, handles)
% hObject    handle to cbfluxconv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbfluxconv
global valflux

a = get(handles.pupmeiosflux,'value');
if a ~= 1
    if valflux(a,1) == 0
        valflux(a,1) = 1;
    elseif valflux(a,1) == 1
        valflux(a,1) = 0;
    elseif valflux(a,1) == 2
        valflux(a,1) = 3;
    elseif valflux(a,1) == 3
        valflux(a,1) = 2;
    end
else
    set(hObject,'value',0)
end

% --- Executes on button press in cbfluxrad.
function cbfluxrad_Callback(hObject, eventdata, handles)
% hObject    handle to cbfluxrad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbfluxrad
global valflux

a = get(handles.pupmeiosflux,'value');
if a ~= 1
    if valflux(a,1) == 0
        valflux(a,1) = 2;
    elseif valflux(a,1) == 1
        valflux(a,1) = 3;
    elseif valflux(a,1) == 2
        valflux(a,1) = 0;
    elseif valflux(a,1) == 3
        valflux(a,1) = 1;
    end
else
    set(hObject,'value',0)
end



% --- Executes on selection change in pupmeiosflux.
function pupmeiosflux_Callback(hObject, eventdata, handles)
% hObject    handle to pupmeiosflux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pupmeiosflux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pupmeiosflux
global valflux

a = get(hObject,'value');

if valflux(a,1) == 0
    set(handles.cbfluxconv,'value',0)
    set(handles.cbfluxrad,'value',0)
elseif valflux(a,1) == 1
    set(handles.cbfluxconv,'value',1)
    set(handles.cbfluxrad,'value',0)
elseif valflux(a,1) == 2
    set(handles.cbfluxconv,'value',0)
    set(handles.cbfluxrad,'value',1)
elseif valflux(a,1) == 3
    set(handles.cbfluxconv,'value',1)
    set(handles.cbfluxrad,'value',1)
end

% --- Executes during object creation, after setting all properties.
function pupmeiosflux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pupmeiosflux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btfronteira.
function btfronteira_Callback(hObject, eventdata, handles)
% hObject    handle to btfronteira (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edfon
close(edcar)


% --- Executes when selected object is changed in EMpainel.
function EMpainel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in EMpainel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global TEM
switch 1
    case get(handles.TMbtn,'value')
        TEM = 1;
    case get(handles.TEbtn,'value')
        TEM = 2;
end


% --- Executes on button press in fluxextbtn.
function fluxextbtn_Callback(hObject, eventdata, handles)
% hObject    handle to fluxextbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fluxext
close(edcar)



function edAltitude_Callback(hObject, eventdata, handles)
% hObject    handle to edAltitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edAltitude as text
%        str2double(get(hObject,'String')) returns contents of edAltitude as a double
global Altitude
Altitude = str2num(get(hObject,'String'));
set(handles.txtvAltitude,'string',num2str(Altitude))

% --- Executes during object creation, after setting all properties.
function edAltitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edAltitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edLatitude_Callback(hObject, eventdata, handles)
% hObject    handle to edLatitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edLatitude as text
%        str2double(get(hObject,'String')) returns contents of edLatitude as a double
global Latitude
Latitude = str2num(get(hObject,'String'));
set(handles.txtvLatitude,'string',num2str(Latitude))

% --- Executes during object creation, after setting all properties.
function edLatitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edLatitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTa_Callback(hObject, eventdata, handles)
% hObject    handle to edTa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTa as text
%        str2double(get(hObject,'String')) returns contents of edTa as a double
global Ta
Ta = str2num((get(hObject,'string')));
set(handles.txtvTa,'string',num2str(Ta))

% --- Executes during object creation, after setting all properties.
function edTa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edTgn_Callback(hObject, eventdata, handles)
% hObject    handle to edTgn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edTgn as text
%        str2double(get(hObject,'String')) returns contents of edTgn as a double
global Tgn
Tgn = str2num((get(hObject,'string')));
set(handles.txtvTgn,'string',num2str(Tgn))

% --- Executes during object creation, after setting all properties.
function edTgn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edTgn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edVV_Callback(hObject, eventdata, handles)
% hObject    handle to edVV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edVV as text
%        str2double(get(hObject,'String')) returns contents of edVV as a double
global VV
VV = str2num((get(hObject,'string')));
set(handles.txtvVV,'string',num2str(VV))


% --- Executes during object creation, after setting all properties.
function edVV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edVV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edDgn_Callback(hObject, eventdata, handles)
% hObject    handle to edDgn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edDgn as text
%        str2double(get(hObject,'String')) returns contents of edDgn as a double
global Ggn
Ggn = str2num((get(hObject,'string')));
set(handles.txtvGgn,'string',num2str(Ggn))

% --- Executes during object creation, after setting all properties.
function edDgn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edDgn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
