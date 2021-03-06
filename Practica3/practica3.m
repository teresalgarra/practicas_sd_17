clear all;
close all;

%ESTUDIO DE SISTEMAS LTI

%Vemos los coeficientes del filtro:
%y(n) = 1.52y(n-1) - 0.8y(n-2) + x(n) + 1.2x(n-1) + x(n-2)

b = [1 1.2 1];
a = [1 -1.52 0.8];

%1.- RESPUESTA AL IMPULSO

%Definimos el impulso:

A = 1;                  %Amplitud
L = 128;                %N�mero de periodos
xx = 0:(L-1);           %Eje X
impulso = zeros(L, 1);  %Vector total (OJO: ZEROS(L) DA UN VECTOR DE LxL)
impulso(1) = A;         %Delta

%Pasamos a calcular la respuesta al impulso mediante un filtro digital:

y_impulso = filter(b, a, impulso);

%2.- RESPUESTA AL ESCAL�N

%Definimos el escal�n:

escalon = ones(L,1);

%Pasamos a calcular la respuesta al escalon mediante un filtro digital:

y_escalon = filter(b, a, escalon);

%3.- TRANSITORIO

%Aislamos el transitorio:

y_transitorio = y_escalon - 11.45 * escalon;

%4.- FUNCI�N DE TRANSFERENCIA

%Usamos la funcion zplane para ver los ceros y los polos:

%Adem�s, buscamos los polos y los ceros anal�ticamente con tf2zp:

[zeros, poles, gain] = tf2zp(b, a);

%Intentamos resuperar la funci�n de transferencia con los polos y los
%ceros::

[b, a] = zp2tf(zeros, poles, gain);

%Si vemos las salidas, vemos que sale todo bien.

%En la circuenferencia no est�n los polos, pero s� los ceros, luego el
%sistema es estable.

%5.- RESPUESTA EN FRECUENCIA:

%Usamos la funci�n que nos da H y lo pasamos a m�dulo y fase:

[H, W] = freqz(b, a, L, 'WHOLE');

hh=1:length(H);
modulo = abs(H);
fase = angle(H);

%REPRESENTACION:

figure(1);

subplot(3, 1, 1);
zplane(b, a);

subplot(3, 1, 2);
plot(hh, modulo, 'g');

subplot(3, 1, 3);
plot(hh, fase, 'g');

%6.- CALCULOS PARA OTROS SISTEMAS

%Repetimos lo anterior con otros sistemas.

%%1.-

d = [0.64 1.02 1];
c = [1 1.02 0.64];

y_impulso1 = filter(d, c, impulso);
y_escalon1 = filter(d, c, escalon);

[H1, W1] = freqz(d, c, L, 'WHOLE');
hh1=1:length(H1);
modulo1 = abs(H1);
fase1 = angle(H1);

figure(2);

subplot(3, 1, 1);
zplane(d, c);

subplot(3, 1, 2);
plot(hh1, modulo1, 'g');

subplot(3, 1, 3);
plot(hh1, fase1, 'g');

%%2.-

f = [1 -0.74 1];
e = [1 -0.66 0.8];

y_impulso2 = filter(f, e, impulso);
y_escalon2 = filter(f, e, escalon);

[H2, W2] = freqz(f, e, L, 'WHOLE');
hh2=1:length(H2);
modulo2 = abs(H2);
fase2 = angle(H2);

figure(3);

subplot(3, 1, 1);
zplane(f, e);

subplot(3, 1,2);
plot(hh2, modulo2, 'g');

subplot(3, 1, 3);
plot(hh2, fase2, 'g');

%7.- CALCULO MEDIANTE LA RESOLUCION DE LA ECUACION EN DIFERENCIAS

[zeros2r, poles2r, gain2r] = residuez(f, e);

[zeros2, poles2, gain2] = tf2zp(f, e);

zeros2r
zeros2
poles2r
poles2
gain2r
gain2