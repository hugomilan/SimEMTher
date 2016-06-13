function criaglobais ()
% Objetivo de criar todas as vari�veis globais que ser�o utilizadas no
% decorrer do programa. Obs.: Essas vari�veis s�o sujeitas � altera��es

global dimenmalha dtTLM k Tx Ty Tz idioma camposimu quantcampo dl ent tabcar ...
    corcar fronthorizontal frontvertical simu rosan cpsan tsan msgflux valflux ...
    mostraopcao valorfronteira campfront fortabhor fortabver verifem verifther ...
    quantfonte fonteimg campfonte fontedk saltosimu TEM carregar versao fluxosext ...
    Pressao Altitude Latitude Ta Tgn VV Dgn




% Dimens�o Inicial da Malha
dimenmalha = 2;
%1 - Unidimensional; 2 - Bidimensional; 3 - Tridimensional



% Passo-de-tempo inicial
e0 = 8.854e-12;
u0 = 4*pi*1e-7;
dtTLM = sqrt(e0*u0/2);



% Quantidade de passos-de-tempo inicial
k = 1;



% Tamanho Inicial da Malha bidimensional
Ty = 1;
Tx = Ty;
Tz = Tx;



% Lingua para mostrar os textos do programa
idioma = 1;
%1 - Ingl�s; 2 - Portugues



% Campos que ser�o simulados
camposimu = 2*3*7*11*13;
%2 - Campo em x; 3 - Campo em y; 7 - Campo em z; 11 - SAR; 13 - Temperatura



% Quantidade de Campos que ser�o simulados
quantcampo = 5;



% Comprimento do n�
dl = 1;



% Malha Inicial
ent = 1;



% Tabela Inicial dos valores
tabcar = [1 0 1 1.2 1000 0.023 273 0 0 0];
% 1 - Permissividade Relativa; 2 - Condutividade El�trica;
% 3 - Permeabilidade Relativa; 4 - Densidade (kg/m�);
% 5 - Calor Espec�fico (J/(kg*K)); 6 - Condutividade T�rmica (W/(m*K));
% 7 - Temperatura Inicial (K); 8 - Perfus�o do Sangue (m�/(m�*s));
% 9 - Gera��o de Calor metab�lico (W/m�); 10 - Emssividade;


% Valor da cor inicial
corcar = 1;



% Vari�vel que contem o valor das fronteiras escohidas
fronthorizontal = ones(2,1,2);
% 1 - 1: Lado Direito, 2: Lado Esquerdo; 2 - Tamanho em y da malha;
% 3 - Op��es Dispon�veis para o meio f�sico, 1: EM, 2: T�rmico

frontvertical = ones(2,1,2);
% 1 - 1: Lado Cima, 2: Lado Baixo; 2 - Tamanho em x da malha;
% 3 - Op��es Dispon�veis para o meio f�sico, 1: EM, 2: T�rmico



% Vari�vel que dita o que ser� simulado
simu = 1;
%1 - EM e T�rmico; 2 - EM; 3 - T�rmico



% Caracter�sticas do Sangue
rosan = 1058;
cpsan = 3960;
tsan = 301.8;



% Vari�veis para verificar o fluxo
msgflux = cell(1,2);
msgflux{1,1} = 'Flux among Environment';
msgflux{1,2} = 'Fluxo entre os Meios';
valflux = 0;



% Vair�vel que mostra os nomes das op��es de fronteira
mostraopcao = cell(1,2);
% EM
mostraopcao{1,1} = cell(3,2);
mostraopcao{1,1}{1,1} = '1 - Electric Wall';
mostraopcao{1,1}{1,2} = '1 - Parede El�trica';
mostraopcao{1,1}{2,1} = '2 - Magnetic Wall';
mostraopcao{1,1}{2,2} = '2 - Parede Magn�tica';
mostraopcao{1,1}{3,1} = '3 - Complete Absorption';
mostraopcao{1,1}{3,2} = '3 - Completa Absor��o';

% T�rmico
mostraopcao{1,2} = cell(2,2);
mostraopcao{1,2}{1,1} = '1 - Adiabatic';
mostraopcao{1,2}{1,2} = '1 - Adiab�tica';



% Vari�vel que contem as op��es escolhidas para as fronteira
valorfronteira = zeros(2,3,6);
% EM
valorfronteira(1,1,1) = -1; % Coeficiente de Reflex�o

valorfronteira(1,2,1) = 1; % Coeficiente de Reflex�o

valorfronteira(1,3,1) = 0; % Coeficiente de Reflex�o


% T�rmico
valorfronteira(2,1,1) = 1; % Coeficiente de Reflex�o, Material
valorfronteira(2,1,2) = 0; % Coeficiente de Transmiss�o, Temperatura
valorfronteira(2,1,3) = 1; % 1 - Coeficiente de Reflex�o, 2 - Temperatura fixa
valorfronteira(2,1,4) = 0; % Para fluxo entre as fronteiras
valorfronteira(2,1,5) = 0; % Dimens�o Caracter�stica
valorfronteira(2,1,6) = 0; % 1 - Cil. hori. par; 2- Cil. hori. perp.;
%3 - Cil. Ver. para.; 4 - Cil. Ver. Perp. ; 5 - Globo

% Quando na terceira dimens�o tiver o valor 1, significa que � baseado no 
% coeficiente de reflex�o. Com o valor 2, significa que � baseado na
% temperatura.
% Se em 1, 5 e 6 tiver 0, temos condu��o.



% Vari�vel que indica em qual meio f�sico se est� analisando a fronteira
campfront = 1;
% 1 - EM; 2 - T�rmico;



% Vari�vel que mostra as op��es de fronteira na tabela horizontal
fortabhor = cell(2,Ty);
% Na linha: 1 - EM; 2 - T�rmico; Na coluna: Tamanho da malha na vertical; 
fortabhor{1,1} = cell(1,3);
fortabhor{1,1}{1,1} = '1';
fortabhor{1,1}{1,2} = '2';
fortabhor{1,1}{1,3} = '3';
fortabhor{2,1} = cell(1,2);
fortabhor{2,1}{1,1} = '1';

fortabhor{1,2} = cell(1,3);
fortabhor{1,2}{1,1} = '1';
fortabhor{1,2}{1,2} = '2';
fortabhor{1,2}{1,3} = '3';
fortabhor{2,1} = cell(1,2);
fortabhor{2,2}{1,1} = '1';



% Vari�vel que mostra as op��es de fronteira na tabela vertical
fortabver = cell(2,Tx);
% Na linha: 1 - EM; 2 - T�rmico; Na coluna: Tamanho da malha na horizontal;
fortabver{1,1} = cell(1,3);
fortabver{1,1}{1,1} = '1';
fortabver{1,1}{1,2} = '2';
fortabver{1,1}{1,3} = '3';
fortabver{2,1} = cell(1,2);
fortabver{2,1}{1,1} = '1';

fortabver{1,2} = cell(1,3);
fortabver{1,2}{1,1} = '1';
fortabver{1,2}{1,2} = '2';
fortabver{1,2}{1,3} = '3';
fortabver{2,1} = cell(1,2);
fortabver{2,2}{1,1} = '1';




% Vari�veis para saber as op��es dispon�veis para as fronterias
verifem = 3;
verifther = 1;



% Vari�vel que diz quantas fontes foram inseridas pelo usu�rio
quantfonte = 0;



% Vari�vel do tamanho da malha que informa onde ficam as fontes
fonteimg = zeros(Tx,Ty);


% Vari�vel que indica o campo de excita��o
campfonte = 1;
% 1 - Campo em x; 2 - Campo em y; 3 - Campo em z; 4 - Calor em W;



% Var�avel que cont�m os lugares onde a fonte situa-se
fontedk = cell(1,4);
fontedk{1,1} = 0;           % Malha
fontedk{1,2} = 0;           % Campo de excita��o
fontedk{1,3} = zeros(1,6);  % 2 - Fun��o; 3-6 - Caracter�sticas da funcao
fontedk{1,3}(1) = 0;        % 1 - Forma da Antena
fontedk{1,4} = 0;           % Fun��o Gen�rica


% Vari�vel que indica quantos passos-de-tempo para salvar uma vari�vel
saltosimu = 1;


%Vari�vel que indica o modo de propaga��o bidimensional
TEM = 1;
%0 - Somente T�rmico; 1 - Modo TM; 2 - Modo TE


%Vari�vel que determina se vai carregar o resultado anterior
carregar = 0;
%0 - n�o carrega; 1 - carrega;


%Vari�vel que fornece a vers�o atual do programa
versao = 'SimEMTher 1.53a';


%Vari�vel que mostra os fluxos externos atuando na malha
fluxosext = zeros(1,4);



%Vari�vel que guarda a press�o atmosf�rica em (kPa)
Pressao = 101;



%Vari�vel que guarda a altitude (m)
Altitude = 595;



%Vari�vel que guarda a Latitude (�Dec)
Latitude = 21.508;



%Vari�vel que guarda a Temperatura da Atmosfera (K)
Ta = 293.15;



%Vari�vel que guarda a Temperatura do Globo Negro (K)
Tgn = 293.15;



%Vari�vel que guarda a Velocidade do Vento (m/s)
VV = 0.5;



%Vari�vel que guarda o di�metro do globo negro(m)
Dgn = 0.15;