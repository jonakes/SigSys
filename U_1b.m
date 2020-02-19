clc
clf

T=1;
w=2*pi/T;
M=200;
t=T*(0:M-1)/M;
y=sin(w*t);
plot(t,y);

a_0=0;
a_k=0;
stot=a_0;

for k=1:2:20
    b_k=4/(pi*k);
    stot=stot+a_k*cos(k*w*t)+b_k*sin(k*w*t);
end
hold on;
plot(t,stot);

