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
     
 end