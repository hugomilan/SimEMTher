function criaglobais ()
% Objetivo de criar todas as variáveis globais que serão utilizadas no
% decorrer do programa. Obs.: Essas variáveis são sujeitas à alterações

global dimenmalha dtTLM k Tx Ty Tz idioma camposimu quantcampo dl ent tabcar ...
    corcar fronthorizontal frontvertical simu rosan cpsan tsan msgflux valflux ...
    mostraopcao valorfronteira campfront fortabhor fortabver verifem verifther ...
    quantfonte fonteimg campfonte fontedk saltosimu TEM carregar versao fluxosext ...
    Pressao Altitude Latitude Ta Tgn VV Dgn




% Dimensão Inicial da Malha
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
%1 - Inglês; 2 - Portugues



% Campos que serão simulados
camposimu = 2*3*7*11*13;
%2 - Campo em x; 3 - Campo em y; 7 - Campo em z; 11 - SAR; 13 - Temperatura



% Quantidade de Campos que serão simulados
quantcampo = 5;



% Comprimento do nó
dl = 1;



% Malha Inicial
ent = 1;



% Tabela Inicial dos valores
tabcar = [1 0 1 1.2 1000 0.023 273 0 0 0];
% 1 - Permissividade Relativa; 2 - Condutividade Elétrica;
% 3 - Permeabilidade Relativa; 4 - Densidade (kg/m³);
% 5 - Calor Específico (J/(kg*K)); 6 - Condutividade Térmica (W/(m*K));
% 7 - Temperatura Inicial (K); 8 - Perfusão do Sangue (m³/(m³*s));
% 9 - Geração de Calor metabólico (W/m³); 10 - Emssividade;


% Valor da cor inicial
corcar = 1;



% Variável que contem o valor das fronteiras escohidas
fronthorizontal = ones(2,1,2);
% 1 - 1: Lado Direito, 2: Lado Esquerdo; 2 - Tamanho em y da malha;
% 3 - Opções Disponíveis para o meio físico, 1: EM, 2: Térmico

frontvertical = ones(2,1,2);
% 1 - 1: Lado Cima, 2: Lado Baixo; 2 - Tamanho em x da malha;
% 3 - Opções Disponíveis para o meio físico, 1: EM, 2: Térmico



% Variável que dita o que será simulado
simu = 1;
%1 - EM e Térmico; 2 - EM; 3 - Térmico



% Características do Sangue
rosan = 1058;
cpsan = 3960;
tsan = 301.8;



% Variáveis para verificar o fluxo
msgflux = cell(1,2);
msgflux{1,1} = 'Flux among Environment';
msgflux{1,2} = 'Fluxo entre os Meios';
valflux = 0;



% Vairável que mostra os nomes das opções de fronteira
mostraopcao = cell(1,2);
% EM
mostraopcao{1,1} = cell(3,2);
mostraopcao{1,1}{1,1} = '1 - Electric Wall';
mostraopcao{1,1}{1,2} = '1 - Parede Elétrica';
mostraopcao{1,1}{2,1} = '2 - Magnetic Wall';
mostraopcao{1,1}{2,2} = '2 - Parede Magnética';
mostraopcao{1,1}{3,1} = '3 - Complete Absorption';
mostraopcao{1,1}{3,2} = '3 - Completa Absorção';

% Térmico
mostraopcao{1,2} = cell(2,2);
mostraopcao{1,2}{1,1} = '1 - Adiabatic';
mostraopcao{1,2}{1,2} = '1 - Adiabática';



% Variável que contem as opções escolhidas para as fronteira
valorfronteira = zeros(2,3,6);
% EM
valorfronteira(1,1,1) = -1; % Coeficiente de Reflexão

valorfronteira(1,2,1) = 1; % Coeficiente de Reflexão

valorfronteira(1,3,1) = 0; % Coeficiente de Reflexão


% Térmico
valorfronteira(2,1,1) = 1; % Coeficiente de Reflexão, Material
valorfronteira(2,1,2) = 0; % Coeficiente de Transmissão, Temperatura
valorfronteira(2,1,3) = 1; % 1 - Coeficiente de Reflexão, 2 - Temperatura fixa
valorfronteira(2,1,4) = 0; % Para fluxo entre as fronteiras
valorfronteira(2,1,5) = 0; % Dimensão Característica
valorfronteira(2,1,6) = 0; % 1 - Cil. hori. par; 2- Cil. hori. perp.;
%3 - Cil. Ver. para.; 4 - Cil. Ver. Perp. ; 5 - Globo

% Quando na terceira dimensão tiver o valor 1, significa que é baseado no 
% coeficiente de reflexão. Com o valor 2, significa que é baseado na
% temperatura.
% Se em 1, 5 e 6 tiver 0, temos condução.



% Variável que indica em qual meio físico se está analisando a fronteira
campfront = 1;
% 1 - EM; 2 - Térmico;



% Variável que mostra as opções de fronteira na tabela horizontal
fortabhor = cell(2,Ty);
% Na linha: 1 - EM; 2 - Térmico; Na coluna: Tamanho da malha na vertical; 
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



% Variável que mostra as opções de fronteira na tabela vertical
fortabver = cell(2,Tx);
% Na linha: 1 - EM; 2 - Térmico; Na coluna: Tamanho da malha na horizontal;
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




% Variáveis para saber as opções disponíveis para as fronterias
verifem = 3;
verifther = 1;



% Variável que diz quantas fontes foram inseridas pelo usuário
quantfonte = 0;



% Variável do tamanho da malha que informa onde ficam as fontes
fonteimg = zeros(Tx,Ty);


% Variável que indica o campo de excitação
campfonte = 1;
% 1 - Campo em x; 2 - Campo em y; 3 - Campo em z; 4 - Calor em W;



% Varíavel que contém os lugares onde a fonte situa-se
fontedk = cell(1,4);
fontedk{1,1} = 0;           % Malha
fontedk{1,2} = 0;           % Campo de excitação
fontedk{1,3} = zeros(1,6);  % 2 - Função; 3-6 - Características da funcao
fontedk{1,3}(1) = 0;        % 1 - Forma da Antena
fontedk{1,4} = 0;           % Função Genérica


% Variável que indica quantos passos-de-tempo para salvar uma variável
saltosimu = 1;


%Variável que indica o modo de propagação bidimensional
TEM = 1;
%0 - Somente Térmico; 1 - Modo TM; 2 - Modo TE


%Variável que determina se vai carregar o resultado anterior
carregar = 0;
%0 - não carrega; 1 - carrega;


%Variável que fornece a versão atual do programa
versao = 'SimEMTher 1.53a';


%Variável que mostra os fluxos externos atuando na malha
fluxosext = zeros(1,4);



%Variável que guarda a pressão atmosférica em (kPa)
Pressao = 101;



%Variável que guarda a altitude (m)
Altitude = 595;



%Variável que guarda a Latitude (ºDec)
Latitude = 21.508;



%Variável que guarda a Temperatura da Atmosfera (K)
Ta = 293.15;



%Variável que guarda a Temperatura do Globo Negro (K)
Tgn = 293.15;



%Variável que guarda a Velocidade do Vento (m/s)
VV = 0.5;



%Variável que guarda o diâmetro do globo negro(m)
Dgn = 0.15;