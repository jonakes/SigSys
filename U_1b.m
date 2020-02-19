clc
clf

T=1;
w=2*pi/T;
M=200;
t=T*(0:M-1)/M;
y=sin(w*t);
plot(t,y);