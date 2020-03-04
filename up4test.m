%% 4
clc
w04=4;
w09=9;
t=0:Ts:Tmax;
x = square(t);
Ts=1/Fs; 
Tmax=(N-1)*Ts;

numG = conv([1, 0.1],[1, 10]);
denG = conv([1, 1],[1, 1, 9]);
G = tf(numG,denG);
y=lsim(G,x,t);
w=[1 5 7 9];
num=[1 0];

for n=1:length(w)
    num= conv(num,[1 0 w(n)^2]);
end
den=[1 w04];
for n=1:9
    den=conv(den,[1 w04]);
end
for n=1:4
    den=conv(den,[1 w09]);
end
sys=tf(num,den);
H0=1/abs(evalfr(sys,3j));
num=H0*num;
sys=tf(num,den);
xx = lsim(sys,x,t);
yy = lsim(sys,y,t);

figure    
bode(sys)
hold on

figure
pzmap(sys)
grid on

figure
plot(w_k,abs(fft(yy)));
hold on
plot(w_k,abs(fft(xx)));

figure
plot(t,yy);
hold on
plot(t,xx);
 
