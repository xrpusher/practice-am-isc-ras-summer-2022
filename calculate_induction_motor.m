% Выбрать асинхронный двигатель средней мощности (10-50 кВт). Произвести расчет его основных параметров.

% Двигатель российского производства АИР160S6 с короткозамкнутым ротором.
% Сайты с характеристиками: 
% https://nasoselprom.ru/air160s6
% https://tech-privod.com/index.pl?act=PRODUCT&id=1303

% Мощность данного двигателя (P)  - 11 кВт
% Частота вращения - 970 об/мин
% Ток статора при 380В - 24,5 А
% КПД - 87,5%
% Cos φ - 0,78
% Iп/Iн - 6,5
% Синхронная частота вращения (ближайшая) N_s - 1000 об/мин

% R0 и X0 образуют потери, их не учитываем.
% Рассчитаем Т-образную схему замещения АД

Up = 380

% Фазное напряжение
U = vpa(Up / sqrt(3),4)

P = 11000

N = 0.875

% Мощность номинальная
Pn = vpa(P / N, 4)

Cosq = 0.78

% Ток номинальный
In = vpa(Pn / (sqrt(3)*Up*Cosq),4)

% Ток холостого хода
Ip = vpa(6.5 * In, 4)

n1 = 1000

n2 = 970

% Номинальное скольжение
S = vpa((1000 - 970) / 1000,2)

% Примем значение отношения активного сопротивления статора к приведенному активному сопротивлению ротора 
B = 2.2

% Критическое скольжение можно определить, выразив его из уточнённой формулы Клосса:
Km = 2.1

Sk = vpa(S * (Km+sqrt(power(Km,2)-(1-2*S*B*(Km-1))))/(1-2*S*B*(Km-1)),15)

Ki = 6.5

C1 = vpa(1 + Ip/(2*Ki*In),10)

m = 3

A1 = m * power(U,2) * (1-S)/(2*C1*Km*P)

%Величина приведённого активного сопротивления ротора 𝑅2
R2 = A1/((B+1/Sk)*C1)

%Определим активное сопротивления обмотки статора 𝑅1
R1 = R2*C1*B

%Найдём значение индуктивного сопротивления короткого замыкания
Y = +(sqrt((1/(power(Sk,2)) - power(B,2))))

Xk = Y*R2*C1

%Приведенное индуктивное сопротивление рассеяния ротора
X2 = 0.58*Xk/C1

%Индуктивное сопротивления рассеяния обмотки статора
X1 = 0.42*Xk

%Эдс фазы статора для номинального режима

E =vpa(sqrt(power((U*Cosq- R1*In),2)+power((U*sqrt(1-power(Cosq,2)) -X1*In),2)),10)

%Индуктивное сопротивление цепи намагничивания
Xm = E/Ip

% Берем для симулинка 15.814
fn = 50

%Индуктивность рассеивания обмотки статора
L1q = vpa(X1/(2*pi*fn),10)

%Индуктивность обмотки ротора:
L2q = vpa(X2/(2*pi*fn),10)

%Индуктивность цепи намагничивания
%Берем для симулинка 0.1495
Lm = vpa(Xm/(2*pi*fn),10)

%Приведенное ротора
Lprivedr = Lm + L2q

%Приведенное статора
Lpriveds = Lm + L1q

%Конец первой задачи
%Данные будут нужны для второй задачи
