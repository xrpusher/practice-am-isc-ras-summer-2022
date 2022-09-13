% Двигатель российского производства АИР160S6 с короткозамкнутым ротором.
% Сайты с характеристиками: 
% https://nasoselprom.ru/air160s6
% https://tech-privod.com/index.pl?act=PRODUCT&id=1303

%  Произвести расчет параметров ПИД-регулятора с использованием приведенного примера
%  Из прошлой задачи
Lm = 0.00401758485 

L1q = 0.00196627699

L2q = 0.00181047161

R2 = 0.14416453132

R1 = 0.47567769389

%  ПИД из 3 частей (составной)

%  Регулятор тока

%  Малая некомпенсируемая постоянная времени рассчитывается по дефолту
TkI = 8.45 / 100000

kpl1 = (Lm+L1q)/(2*TkI)

%  Значение коэффициента интегрирования
kiI = R1/(2*TkI)

%  Регулятор потокосцепления
%  Малая некомпенсируемая постоянная времени контура потокосцепления
Tne = 0.014

% Постоянная времени ПИ-регулятора
Tip = 0.029

% Электромагнитная постоянная времени ротора
T2 = (Lm+L2q)/R2

% Коэффициент усиления пропорциональной части рассматриваемого регулятора 
Krp = T2/Tip

% Коэффициент усиления интегральной части
Kip = 1/(Tip*Lm)

% Регулятор скорости мотора
J = 0.0700 

Zp = 3

% Малая некомпенсируемая постоянная времени
Tkc = 0.001269

Kwi = (J*(Lm+L2q)*pi)/(12*Zp*Lm*Tkc*Tkc*30)

% Коэффициент пропорциональной части 
Kwp = (J*(Lm+L2q)*pi)/(3*3*Lm*Tkc*30)
