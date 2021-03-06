clc
T=1;
w=2*pi/T;
 M=200;
 t=T*(0:M-1)/M;
 y=sin(w*t);

 a_0=0;
 a_t=0;
 stot = a_0;
 
 for n=1:2:50
     
     b_t=4/(pi*n);
     stot = stot + a_t*cos(n*w*t)+b_t*sin(n*w*t);
 end
 hold on
 plot(t,stot)
 plot(t,y)
 hold off
 
 %% 3.2a
 clc
 num = conv([1, 0.1],[1, 10]);
 den = conv([1, 1],[1, 1, 9]);
 G = tf(num,den);
 figure
 pzmap(G)
 grid on
 
 figure
 bode(G)
 grid on
 
 %uppskattning av asymptoter
 figure
 subplot(2,1,1)
 semilogx([10^-3 0.1],[-20 -20])
 hold on
 semilogx([0.1 1],[-20 0])
 semilogx([1 3],[0 0])
 semilogx([3 3],[0 10])
 semilogx([3 10],[0 -20])
 semilogx([10 1000],[-20 -60])
 axis([10^-3 1000 -60 15])
 
 subplot(2,1,2)
 semilogx([10^-3 0.1],[0 0])
 hold on
 semilogx([0.01 1],[0 45])
 semilogx([0.1 10],[45 0])
 semilogx([0.3 13],[0 -180])
 semilogx([1 100],[-180 -90])
 semilogx([100 1000],[-90 -90])
 axis([10^-3 1000 -185 90])

 %% 3.2b
 clc
 Fs=100;
 w=[1 3 5];
 Ts=1/Fs;
 N=2^13;
 Tmax=(N-1)*Ts;
 t=0:Ts:Tmax;
 for n=1:1:3
     figure;
 x=sin(w(n)*t);
 plot(t,x);
 hold on
 end
 
%% 3.2c
 clc
 close all
 Fs=100;
 Ts=1/Fs;
 N=2^13;
 Tmax=(N-1)*Ts;
 num = conv([1, 0.1],[1, 10]);
 den = conv([1, 1],[1, 1, 9]);
 G = tf(num,den);
 t=0:Ts:Tmax;
 w=[1 3 5];
 for n=1:1:3
     figure
     x=sin(w(n)*t);
     lsim(G,x,t) 
     %a=evalfr(G,j*w(n));
     axis([6*pi/w(n) 10*pi/w(n) -5 5]);
     %amplitud=abs(a)
     %vinkel=rad2deg(angle(a))
 end
 %% Uppg3
 clc
 close all
 Fs=100;
 N=2^13;
  w=[1 3 5];
  Ts=1/Fs;
 Tmax=(N-1)*Ts;

t=0:Ts:Tmax;
 A_k=0;


 x = square(t); %Udda signal, 13 perioder
 hold on
 plot(t,x)
xlabel('time')
ylabel('amp')
hold off
 figure
 k = 0:1:N-1;
 w_k =2*pi*Fs*k/N;
 X = fft(x,N);
 plot(w_k, abs(X)) %k peak vid k = 13, eftersom vi har 13 perioder. Periodisk pga
%diskret signal som vi g?r FFT p?. Peak avtar varje 13e w_k eftersom k=13
%ger mest likhet med fyrkantssignalen.
%dvs 14+13*2*n eftersom wk*2 = peak.
figure
 b_t1=4/pi;
 b_t3=4/(pi*3);
  b_t5=4/(pi*5);
abs(X(14))*2/N
abs(X(40))*2/N
abs(X(66))*2/N %N?r k st?mmer ?verens s? att w_s ungef?r = w0
 %satter vi in sinus far vi att e delen blir 1 och da ar summan 1*N*B/2
 %=X[k] GOR EN TABELL.


% Uppg e
num = conv([1, 0.1],[1, 10]);
 den = conv([1, 1],[1, 1, 9]);
 G = tf(num,den);
 y=lsim(G,x,t);
plot(w_k,y)
figure
s = evalfr(G,j);
 g1= abs(evalfr(G,j))*4/pi
 g3= abs(evalfr(G,3*j))*4/(pi*3)
 g5= abs(evalfr(G,5*j))*4/(pi*5)
 yfft = fft(y);
 greal1 = 2*abs(yfft(14))/N %Since k starts at 0, and k=13 = w0
 greal3 = 2*abs(yfft(40))/N %k=26=2w0, even so zero. k=39 = 3w0 so odd.
 greal5 = 2*abs(yfft(66))/N %Same as before, add 26 for next odd number.
%y(1) = 0 so A_0 is zero.
hold on
plot(w_k, abs(yfft))
plot(w_k, abs(X))
hold off
%Bodefiltret har filtrerat ner h?ga frekvenser och s?nkt 3e, vilket st?mmer
%med bodediagrammet.

%%
%% 4
clc
close all
w0=4;
Fs=100;
N=2^13;
Ts=1/Fs; 
Tmax=(N-1)*Ts;
t=0:Ts:Tmax;
x = square(t);

%Skapar signalen y fr�n 3.3
numG = conv([1, 0.1],[1, 10]);
denG = conv([1, 1],[1, 1, 9]);
G = tf(numG,denG);
y=lsim(G,x,t);
w=[1 5 7 9];

%Skapar t�ljarpolynomet, b�rjar med S^2
num=[1 0];
for n=1:length(w)
    %Notchar l�ggs till f�r udda frekvenser (s^2+w^2), w=(1 5 7 9)
    num= conv(num,[1 0 w(n)^2]);
end
%Skapar n�mnarpolynomet
den=[1 w0];
for n=1:11
    %Poler l�ggs till f�r (s+4)
    den=conv(den,[1 w0]);
end

%Systemet skapas
sys=tf(num,den);
%Faktor f�r att "h�ja" �verf�ringsfunktionen ber�knas
H0=1/abs(evalfr(sys,3j));
%�verf�ringsfunktionen h�j upp till r�tt f�rst�rkning f�r w=3
num=H0*num;
sys=tf(num,den);
%Filtrerar signalerna
xx = lsim(sys,x,t);
yy = lsim(sys,y,t);

figure    
bode(sys)
hold on

figure
pzmap(sys)
grid on

k = 0:1:N-1;
w_k =2*pi*Fs*k/N;
figure
%Plottar signalerna i frekvensplanet
plot(w_k,abs(fft(yy)));
hold on
plot(w_k,abs(fft(xx)));
axis([0 40 0 5500])

figure
plot(t,yy);
hold on
plot(t,xx);
axis([4*2*pi/3 8*2*pi/3 -1.5 1.5])
 
