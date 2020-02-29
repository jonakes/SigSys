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
 
 %%
 clc
 num = conv([1, 0.1],[1, 10]);
 den = conv([1, 1],[1, 1, 9]);
 G = tf(num,den);
 figure
 pzmap(G)
 grid on
 figure;
 bode(G)
 grid on
 %%
 clc
 Fs=100;
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
 %%
 clc
 Fs=100;
 Ts=1/Fs;
 N=2^13;
 w=[1 3 5];
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
     a=evalfr(G,j*w(n));
     axis([6*pi/w(n) 10*pi/w(n) -5 5]);
     amplitud=abs(a)
     vinkel=rad2deg(angle(a))
 end
 %% Uppg3
 clc
 Fs=100;
 N=2^13;
  w=[1 3 5];
 Tmax=(N-1)*Ts;
Ts=1/Fs;
t=0:Ts:Tmax;
 A_k=0;


 x = square(t); %Udda signal, 13 perioder
 plot(t,x)
 k = 0:1:N-1;
 w_k =2*pi*Fs*k/N;
 X = fft(x,N);
 figure
 plot(w_k, abs(X)) %k peak vid k = 13, eftersom vi har 13 perioder. Periodisk pga
%diskret signal som vi g?r FFT p?. Peak avtar varje 13e w_k eftersom k=13
%ger mest likhet med fyrkantssignalen.
%dvs 14+13*2*n eftersom wk*2 = peak.
 b_t1=4/pi - abs(X(14))*2/N
 b_t3=4/(pi*3) - abs(X(40))*2/N
 b_t5=4/(pi*5 - abs(X(66))*2/N %N?r k st?mmer ?verens s? att w_s ungef?r = w0
 %satter vi in sinus far vi att e delen blir 1 och da ar summan 1*N*B/2
 %=X[k] GOR EN TABELL.

