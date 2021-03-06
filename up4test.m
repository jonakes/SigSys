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
 
