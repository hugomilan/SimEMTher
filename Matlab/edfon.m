function varargout = edfon(varargin)
% EDFON MATLAB code for edfon.fig
%      EDFON, by itself, creates a new EDFON or raises the existing
%      singleton*.
%
%      H = EDFON returns the handle to a new EDFON or the handle to
%      the existing singleton*.
%
%      EDFON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDFON.M with the given input arguments.
%
%      EDFON('Property','Value',...) creates a new EDFON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edfon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edfon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edfon

% Last Modified by GUIDE v2.5 31-Dec-2011 15:39:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @edfon_OpeningFcn, ...
    'gui_OutputFcn',  @edfon_OutputFcn, ...
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


% --- Executes just before edfon is made visible.
function edfon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edfon (see VARARGIN)

% Choose default command line output for edfon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes edfon wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global campfront

textoedfon(handles)
set(handles.txtavisos,'string',texto_aviso(campfront,1))


% --- Outputs from this function are returned to the command line.
function varargout = edfon_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lbopcoes.
function lbopcoes_Callback(hObject, eventdata, handles)
% hObject    handle to lbopcoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbopcoes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbopcoes
global campfront

set(handles.txtavisos,'string',texto_aviso(campfront,get(hObject,'Value')))

% --- Executes during object creation, after setting all properties.
function lbopcoes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbopcoes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btinserirop.
function btinserirop_Callback(hObject, eventdata, handles)
% hObject    handle to btinserirop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global campfront mostraopcao verifem verifther textoaviso fortabver ...
    fortabhor Tx Ty valorfronteira idioma

if campfront == 1
    if idioma == 1
        titulo = 'Coefficient';
        pergunta = 'Reflection Coefficient between -1 e 1:';
    elseif idioma == 2
        titulo = 'Coeficiente';
        pergunta = 'Coeficiente de Reflexão entre -1 e 1:';
    end
    
    
    novafront = inputdlg(pergunta,titulo,1);
    novafront = str2num(novafront{1,1});
    if novafront > 1 || novafront < -1
        if idioma == 1
            tituloerro = 'Invalid Value!';
            msgerro = ['You input a invalid value! (',...
                novafront,')'];
        elseif idioma == 2
            tituloerro = 'Valor Inválido!';
            msgerro = ['Você entrou com um valor inválido! (',...
                novafront,')'];
        end
        errordlg(msgerro,tituloerro)
    else
        verifem = verifem + 1;
        
        mostraopcao{1,campfront}{verifem,1} = [num2str(verifem) , ...
            ' - Boundary with T = ', num2str(novafront)];
        mostraopcao{1,campfront}{verifem,2} = [num2str(verifem) , ...
            ' - Fronteira com T = ', num2str(novafront)];
        
        textoaviso{1,campfront}{verifem,1} = ['Boundary made by the user ',...
            ' with reflection coefficient equals ',num2str(novafront)];
        textoaviso{1,campfront}{verifem,2} = ['Fronteira criada pelo ',...
            'usuário com coeficiente de reflexão igual a ',num2str(novafront)];
        
        valorfronteira(1,verifem,1) = novafront;
        
        for a1 = 1:Tx
            fortabver{campfront,a1}{1,verifem} = num2str(verifem);
        end
        
        for a1 = 1:Ty
            fortabhor{campfront,a1}{1,verifem} = num2str(verifem);
        end
        
    end
elseif campfront == 2
    if idioma == 1
        msg = 'Bondary with heat flux or with reflection coefficient?';
        titulo = 'Choose of boundary';
        flux = 'Flux';
        coe = 'Coefficient';
    elseif idioma == 2
        msg = 'Fronteira com fluxo de calor ou com Coeficiente de reflexão?';
        titulo = 'Escolha do Tipo de Fronteira';
        flux = 'Fluxo';
        coe = 'Coeficiente';
    end
    
    
    tipo = questdlg(msg,titulo,flux,coe,flux);
    switch tipo
        case flux
            if idioma == 1
                titulo = 'Flux';
                coe = 'nº of Material in the boundary (input 0 for air)';
                pergunta = 'Temperature in Kelvin (input 0 for air):';
                fluxop = ['Input one of this number: 1 - Convection; '...
                    '2 - Radiation, 3 - Convection and Radiation, 4 - '...
                    'Conduction, 5 - Conduction and Convection, 6 - Conduction and '...
                    'Radiation, 7 - Conduction, Convection and Radiation:'];
                diamec = 'Characteristic Diameter (m) (input 0 if no convection)';
                objgeo = ['1 - Horizontal Cylinder with parallel flux; 2 - Horizontal '...
                    'Cylinder with perpendicular flux; 3 - Vertical Cylinder with '...
                    'parallel flux; 4 - Vertical Cylinder with perpendicular flux; '...
                    '5 - Globe (input 0 if no convection)'];
            elseif idioma == 2
                titulo = 'Fluxo';
                coe = 'nº do Material da Fronteira (Insira 0 para Ar)';
                pergunta = 'Temperatura em Kelvin (Insira 0 para Ar):';
                fluxop = ['Insira um dos números: 1 - Convecção; '...
                    '2 - Radiação, 3 - Convecção e Radiação, 4 - Condução, '...
                    '5 - Condução e Convecção, 6 - Condução e Radiação, '...
                    '7 - Condução, Convecção e Radiação:'];
                diamec = 'Diâmetro Característico (m) (Insira 0 caso não haja convecção)';
                objgeo = ['1 - Cilindro Horizontal com fluxo paralelo; 2 - Cilindro '...
                    'Horizontal com fluxo perpendicular; 3 - Cilindro Vertical com '...
                    'fluxo paralelo; 4 - Cilindro Vertical com fluxo perpendicular; '...
                    '5 - Globo (Insira 0 caso não haja convecção)'];
            end
            
            tipo = inputdlg({coe pergunta fluxop diamec objgeo},titulo,1);
            matfront = str2num(tipo{1,1});
            tempfront = str2num(tipo{2,1});
            fluxfront = str2num(tipo{3,1});
            diamfront = str2num(tipo{4,1});
            objfront = str2num(tipo{5,1});
            
            
            if tempfront < 0
                if idioma == 1
                    tituloerro = 'Invalid Value!';
                    msgerro = ['You input a invalid value! (',...
                        num2str(tempfront),')'];
                elseif idioma == 2
                    tituloerro = 'Valor Inválido!';
                    msgerro = ['Você entrou com um valor inválido! (',...
                        num2str(tempfront),')'];
                end
                errordlg(msgerro,tituloerro)
            elseif ~sum(fluxfront == [1 2 3 4 5 6 7])
                if idioma == 1
                    tituloerro = 'Invalid Value!';
                    msgerro = ['You input a invalid value! (',...
                        num2str(fluxfront),')'];
                elseif idioma == 2
                    tituloerro = 'Valor Inválido!';
                    msgerro = ['Você entrou com um valor inválido! (',...
                        num2str(fluxfront),')'];
                end
                errordlg(msgerro,tituloerro)
            else
                verifther = verifther + 1;
                
               if matfront ~= 0 
                mostraopcao{1,campfront}{verifther,1} = [num2str(verifther) , ...
                    ' - Flux with temperature of ', num2str(tempfront),' K'];
                mostraopcao{1,campfront}{verifther,2} = [num2str(verifther) , ...
                    ' - Fluxo com Temperatura de ', num2str(tempfront),' K'];
               else
                   mostraopcao{1,campfront}{verifther,1} = [num2str(verifther) , ...
                    ' - Air Flux'];
                mostraopcao{1,campfront}{verifther,2} = [num2str(verifther) , ...
                    ' - Fluxo de Ar'];
               end
                
                
                if fluxfront == 1
                    msgfluxin = ' with convection.';
                    msgfluxpt = ' com convecção.';
                elseif fluxfront == 2
                    msgfluxin = ' with radiation.';
                    msgfluxpt = ' com radiação.';
                elseif fluxfront == 3
                    msgfluxin = ' with convection and radiation.';
                    msgfluxpt = ' com convecção e radiação.';
                elseif fluxfront == 4
                    msgfluxin = ' with conduction.';
                    msgfluxpt = ' com condução.';
                elseif fluxfront == 5
                    msgfluxin = ' with conduction and convection.';
                    msgfluxpt = ' com condução e convecção.';
                elseif fluxfront == 6
                    msgfluxin = ' with conduction and radiation.';
                    msgfluxpt = ' com condução e radiação.';
                elseif fluxfront == 7
                    msgfluxin = ' with conduction, convection and radiation.';
                    msgfluxpt = ' com condução, convecção e radiação.';
                end
                
                msgtipo{1,1} = ' (Horizontal Cylinder with parallel flux with ';
                msgtipo{2,1} = ' (Horizontal Cylinder with perpendicular flux with ';
                msgtipo{3,1} = ' (Vertical Cylinder with parallel flux with ';
                msgtipo{4,1} = ' (Vertical Cylinder with perpendicular flux with ';
                msgtipo{5,1} = ' (Globe with ';
                msgtipopt{1,1} = ' (Cilindro Horizontal com fluxo paralelo com ';
                msgtipopt{2,1} = ' (Cilindro Horizontal com fluxo perpendicular com ';
                msgtipopt{3,1} = ' (Cilindro Vertical com fluxo paralelo com ';
                msgtipopt{4,1} = ' (Cilindro Vertical com fluxo perpendicular com ';
                msgtipopt{5,1} = ' (Globo com ';
                msgmetro = ' m)';
                
                if matfront ~= 0 
                    if sum(fluxfront == [1, 3, 5, 7]) == 3
                    textoaviso{1,campfront}{verifther,1} = ['Boundary made by the user '...
                        ' with a temperature of ',num2str(tempfront),' K, characteristc',...
                        ' of medium ', num2str(matfront), msgfluxin, msgtipo{objfront},...
                        num2str(diamfront), msgmetro];
                    
                    textoaviso{1,campfront}{verifther,2} = ['Fronteira criada pelo '...
                        'usuário com temperatura de ',num2str(tempfront), ' K, características',...
                        ' do meio ', num2str(matfront), msgfluxpt, msgtipopt{objfront},...
                        num2str(diamfront), msgmetro];
                    else
                        textoaviso{1,campfront}{verifther,1} = ['Boundary made by the user '...
                        ' with a temperature of ',num2str(tempfront),' K, characteristc',...
                        ' of medium ', num2str(matfront), msgfluxin];
                    
                    textoaviso{1,campfront}{verifther,2} = ['Fronteira criada pelo '...
                        'usuário com temperatura de ',num2str(tempfront), ' K, características',...
                        ' do meio ', num2str(matfront), msgfluxpt];
                    end
                else
                    textoaviso{1,campfront}{verifther,1} = ['Boundary made by the user '...
                        'with a Air flux', msgfluxin, msgtipo{objfront},...
                        num2str(diamfront), msgmetro];
                    
                    textoaviso{1,campfront}{verifther,2} = ['Fronteira criada pelo '...
                        'usuário com fluxo de ar', msgfluxpt, msgtipopt{objfront},...
                        num2str(diamfront), msgmetro];
                end
                valorfronteira(2,verifther,1) = matfront;
                valorfronteira(2,verifther,2) = tempfront;
                valorfronteira(2,verifther,3) = 2;
                valorfronteira(2,verifther,4) = fluxfront;
                valorfronteira(2,verifther,5) = diamfront;
                valorfronteira(2,verifther,6) = objfront;
                
                for a1 = 1:Tx
                    fortabver{campfront,a1}{1,verifther} = num2str(verifther);
                end
                
                for a1 = 1:Ty
                    fortabhor{campfront,a1}{1,verifther} = num2str(verifther);
                end
            end
  
        case coe
            if idioma == 1
                titulo = 'Coefficient';
                pergunta = 'Reflection Coefficient between -1 e 1:';
            elseif idioma == 2
                titulo = 'Coeficiente';
                pergunta = 'Coeficiente de Reflexão entre -1 e 1:';
            end
            
            novafront = inputdlg(pergunta,titulo,1);
            novafront = str2num(novafront{1,1});
            if novafront > 1 || novafront < -1
                if idioma == 1
                    tituloerro = 'Invalid Value!';
                    msgerro = ['You input a invalid value! (',...
                        num2str(novafront),')'];
                elseif idioma == 2
                    tituloerro = 'Valor Inválido!';
                    msgerro = ['Você entrou com um valor inválido! (',...
                        num2str(novafront),')'];
                end
                errordlg(msgerro,tituloerro)
            else
                verifther = verifther + 1;
                
                mostraopcao{1,campfront}{verifther,1} = [num2str(verifem) , ...
                    ' - Boundary with T = ', num2str(novafront)];
                mostraopcao{1,campfront}{verifther,2} = [num2str(verifem) , ...
                    ' - Fronteira com T = ', num2str(novafront)];
                
                textoaviso{1,campfront}{verifther,1} = ['Boundary made by the user ',...
                    ' with reflection coefficient equals ',num2str(novafront)];
                textoaviso{1,campfront}{verifther,2} = ['Fronteira criada pelo ',...
                    'usuário com coeficiente de reflexão igual a ',num2str(novafront)];
                
                valorfronteira(2,verifther,1) = novafront;
                valorfronteira(2,verifther,2) = 0;
                valorfronteira(2,verifther,3) = 1;
                valorfronteira(2,verifther,4) = 0;
                
                for a1 = 1:Tx
                    fortabver{campfront,a1}{1,verifther} = num2str(verifther);
                end
                
                for a1 = 1:Ty
                    fortabhor{campfront,a1}{1,verifther} = num2str(verifther);
                end
            end
    end
end
%set no list box
set(handles.lbopcoes,'string',mostraopcao{1,campfront}(:,idioma))
%set na tabela
set(handles.tbvertical,'ColumnFormat',fortabver(campfront,:));
set(handles.tbhorizontal,'ColumnFormat',fortabhor(campfront,:));

% --- Executes on button press in btretirarop.
function btretirarop_Callback(hObject, eventdata, handles)
% hObject    handle to btretirarop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global campfront mostraopcao verifem verifther textoaviso fortabver ...
    fortabhor Tx Ty frontvertical fronthorizontal valorfronteira idioma

erro = 0;
if campfront == 1
    if verifem <= 3
        if idioma == 1
            warndlg('It not possible remove the standart boundary option.'...
                ,'It not possible remove the standart option!')
        elseif idioma == 2
            warndlg(['Não é possível retirar as opções ',...
                'de fronteiras padrão.'],'Não é possível eliminar as opções padrões!')
        end
        erro = 1;
    end
elseif campfront == 2
    if verifther <= 1
        if idioma == 1
            warndlg('It not possible remove the standart boundary option.'...
                ,'It not possible remove the standart option!')
        elseif idioma == 2
            warndlg(['Não é possível retirar as opções ',...
                'de fronteiras padrão.'],'Não é possível eliminar as opções padrões!')
        end
        erro = 1;
    end
end

if ~erro
    mostraopcao2 = mostraopcao;
    textoaviso2 = textoaviso;
    
    valorfronteira2 = valorfronteira;
    valorfronteira = ones(2,3,6);
    
    if campfront == 1
        mostraopcao{1,1} = cell(3,2);
        textoaviso{1,1} = cell(3,2);
        verifem = verifem - 1;
        for a1 = 1:verifem
            mostraopcao{1,campfront}(a1,1) = mostraopcao2{1,campfront}(a1,1);%ingles
            mostraopcao{1,campfront}(a1,2) = mostraopcao2{1,campfront}(a1,2);%portuges
            textoaviso{1,campfront}(a1,1) = textoaviso2{1,campfront}(a1,1);
            textoaviso{1,campfront}(a1,2) = textoaviso2{1,campfront}(a1,2);
            valorfronteira(campfront,a1,:) = valorfronteira2(campfront,a1,:);
        end
        
        
        for a1 = 1:Tx
            fortabver{campfront,a1} = cell(1,verifem);
            for a2 = 1:verifem
                fortabver{campfront,a1}{1,a2} = num2str(a2);
            end
            for a2 = 1:2
                if frontvertical(a2,a1,1) > verifem
                    frontvertical(a2,a1,1) = verifem;
                end
            end
        end
        
        for a1 = 1:Ty
            fortabhor{campfront,a1} = cell(1,verifem);
            for a2 = 1:verifem
                fortabhor{campfront,a1}{1,a2} = num2str(a2);
            end
            for a2 = 1:2
                if fronthorizontal(a2,a1,1) > verifem
                    fronthorizontal(a2,a1,1) = verifem;
                end
            end
        end
        
        
        
        
        
        
    elseif campfront == 2
        textoaviso{1,2} = cell(2,2);
        mostraopcao{1,2} = cell(2,2);
        verifther = verifther - 1;
        for a1 = 1:verifther
            mostraopcao{1,campfront}(a1,1) = mostraopcao2{1,campfront}(a1,1);%ingles
            mostraopcao{1,campfront}(a1,2) = mostraopcao2{1,campfront}(a1,2);%portuges
            textoaviso{1,campfront}(a1,1) = textoaviso2{1,campfront}(a1,1);
            textoaviso{1,campfront}(a1,2) = textoaviso2{1,campfront}(a1,2);
            valorfronteira(campfront,a1,:) = valorfronteira2(campfront,a1,:);
        end
        
        
        for a1 = 1:Tx
            fortabver{campfront,a1} = cell(1,verifther);
            for a2 = 1:verifther
                fortabver{campfront,a1}{1,a2} = num2str(a2);
            end
            for a2 = 1:2
                if frontvertical(a2,a1,2) > verifther
                    frontvertical(a2,a1,2) = verifther;
                end
            end
        end
        
        for a1 = 1:Ty
            fortabhor{campfront,a1} = cell(1,verifther);
            for a2 = 1:verifther
                fortabhor{campfront,a1}{1,a2} = num2str(a2);
            end
            
            for a2 = 1:2
                if fronthorizontal(a2,a1,2) > verifther
                    fronthorizontal(a2,a1,2) = verifther;
                end
            end
        end
        
        
        
        
    end
    
    %atualizando
    if campfront == 1
        set(handles.lbopcoes,'value',verifem)
    elseif campfront == 2
        set(handles.lbopcoes,'value',verifther)
    end
    set(handles.tbhorizontal,'data',fronthorizontal(:,:,campfront))
    set(handles.tbvertical,'data',frontvertical(:,:,campfront))
    set(handles.lbopcoes,'string',mostraopcao{1,campfront}(:,idioma))
    set(handles.tbhorizontal,'ColumnFormat',fortabhor(campfront,:))
    set(handles.tbvertical,'ColumnFormat',fortabver(campfront,:))
    
    
    
    set(handles.txtavisos,'string',texto_aviso(campfront,1))
end




% --- Executes on button press in btretornar.
function btretornar_Callback(hObject, eventdata, handles)
% hObject    handle to btretornar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
edcar
close(edfon)


% --- Executes when entered data in editable cell(s) in tbhorizontal.
function tbhorizontal_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tbhorizontal (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global fronthorizontal campfront

fronthorizontal(:,:,campfront) = get(handles.tbhorizontal,'data');

% --- Executes when entered data in editable cell(s) in tbvertical.
function tbvertical_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tbvertical (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global frontvertical campfront

frontvertical(:,:,campfront) = get(handles.tbvertical,'data');


% --- Executes when selected object is changed in bgCampo.
function bgCampo_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in bgCampo
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global mostraopcao campfront frontvertical fronthorizontal fortabhor ...
    fortabver idioma

switch get(hObject,'Tag')
    case 'rbem'
        campfront = 1;
    case 'rbter'
        campfront = 2;
end

set(handles.lbopcoes,'value',1)
set(handles.lbopcoes,'string',mostraopcao{:,campfront}(:,idioma))
set(handles.txtavisos,'string',texto_aviso(campfront,1))

set(handles.tbvertical,'data',frontvertical(:,:,campfront))
set(handles.tbvertical,'ColumnFormat',fortabver(campfront,:))
set(handles.tbhorizontal,'data',fronthorizontal(:,:,campfront))
set(handles.tbhorizontal,'ColumnFormat',fortabhor(campfront,:))


function msg = texto_aviso(campo, numero)
global textoaviso idioma

if isempty(textoaviso)
    
    textoaviso = cell(1,2);
    
    textoaviso{1,1} = cell(3,2);
    
    %Parede Elétrica
    textoaviso{1,1}{1,1} = ['The electric wall is physically characterized ' ...
        'as the complete reflection of the electric field. In TLM, the '...
        'reflection coefficient receives the unitary value (T = -1).'];
    
    textoaviso{1,1}{1,2} = ['A parede elétrica caracteriza-se fisicamente '...
        'como a reflexão completa do campo elétrico. No TLM, o '...
        'coeficiente de reflexão recebe o valor unitário (T = -1).'];
    
    %Parede Magnética
    textoaviso{1,1}{2,1} = ['The magnetic wall is physically characterized ' ...
        'as the complete reflection of the magnetic field. In TLM, the '...
        'reflection coefficient receives the negative unitary value (T = 1).'];
    
    textoaviso{1,1}{2,2} = ['A física da parede magnética é a reflexão ' ...
        'do campo magnético. O coeficiente de reflexão no TLM recebe '...
        'um valor negativo unitário (T = 1).'];
    
    %Absorção Completa
    textoaviso{1,1}{3,1} = ['In completes absorption, all energie that '...
        'happens on the boundary is absorbed. The reflection coefficient '...
        'receives the null value (T = 0).'];
    
    textoaviso{1,1}{3,2} = ['Na absorção completa, toda a energia que '...
        'incide sobre a fronteira é absorvida, de modo que não há '...
        'reflexão da onda. No TLM, o coeficiente de reflexão é nulo '...
        '(T = 0).'];
    
    textoaviso{1,2} = cell(2,2);
    
    %Adibática
    textoaviso{1,2}{1,1} = ['In Adiabatic boundary, all heat inserted '...
        'in the mesh is not lost in the boundary. In TLM, the reflection '...
        'coefficient receives the unitary value (T = 1).'];
    
    textoaviso{1,2}{1,2} = ['Com as fronteiras adiabáticas, todo calor '...
        'inserido na malha não se perde. Em TLM, o coeficiente de '...
        'reflexão recebe o valor unitário (T = 1).'];
    
    %Temperatura de 300 K
    textoaviso{1,2}{2,1} = ['In the simulation boundary it is put a node '...
        'with constant temperature of 300 K with characteristic of medium 1.'...
        ' In TLM, this is made with the '...
        'transmsision of this temperature to the mesh and with the refletion '...
        'of pulse that it in boundary ( (k+1)Vi = \tau*Vi_temp - \rho*(k)Vr )'];
    
    textoaviso{1,2}{2,2} = ['Na fronteira de simulação é posto um nó com '...
        'temperatura constante de 300 K com características do material 1.'...
        ' No TLM, isto é feito com a '...
        'transmissão dessa temperatura na malha e com a reflexão do pulso '...
        'que encontra fronteira ( (k+1)Vi = \tau*Vi_temp - \rho*(k)Vr )'];
end

msg = textoaviso{1,campo}{numero,idioma};



function edtno01_Callback(hObject, eventdata, handles)
% hObject    handle to edtno01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtno01 as text
%        str2double(get(hObject,'String')) returns contents of edtno01 as a double


% --- Executes during object creation, after setting all properties.
function edtno01_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtno01 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edtno02_Callback(hObject, eventdata, handles)
% hObject    handle to edtno02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtno02 as text
%        str2double(get(hObject,'String')) returns contents of edtno02 as a double


% --- Executes during object creation, after setting all properties.
function edtno02_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtno02 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pmfaces.
function pmfaces_Callback(hObject, eventdata, handles)
% hObject    handle to pmfaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pmfaces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pmfaces


% --- Executes during object creation, after setting all properties.
function pmfaces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pmfaces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbinno.
function pbinno_Callback(hObject, eventdata, handles)
% hObject    handle to pbinno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Tx Ty campfront fronthorizontal frontvertical

face = get(handles.pmfaces,'value');
no01 = str2num(get(handles.edtno01,'string'));
no02 = str2num(get(handles.edtno02,'string'));
valopc = get(handles.lbopcoes,'value');
if no01 > no02
    warndlg('Valor do nó 01 maior que do nó 02', ...
        'Valores incompatíveis.');
else
    if face == 1
        if no02 > Ty
            warndlg('Valor do nó 02 maior que da malha', ...
                'Valores incompatíveis.');
        else
            for a1 = no01:no02
                fronthorizontal(1,a1,campfront) = valopc;
            end
        end
    elseif face == 2
        if no02 > Ty
            warndlg('Valor do nó 02 maior que da malha', ...
                'Valores incompatíveis.');
        else
            for a1 = no01:no02
                fronthorizontal(2,a1,campfront) = valopc;
            end
        end
    elseif face == 3
        if no02 > Tx
            warndlg('Valor do nó 02 maior que da malha', ...
                'Valores incompatíveis.');
        else
            for a1 = no01:no02
                frontvertical(1,a1,campfront) = valopc;
            end
        end
    elseif face == 4
        if no02 > Tx
            warndlg('Valor do nó 02 maior que da malha', ...
                'Valores incompatíveis.');
        else
            for a1 = no01:no02
                frontvertical(2,a1,campfront) = valopc;
            end
        end
    end
end
set(handles.tbvertical,'data',frontvertical(:,:,campfront))
set(handles.tbhorizontal,'data',fronthorizontal(:,:,campfront))
