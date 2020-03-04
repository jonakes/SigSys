%% 4
clc
num = conv( conv( conv( [1 0],[1 1]), conv( [1 5],[1 7])), [1 9] );
den = conv( conv( conv( [1 5],[1 7]), conv( [1 9], [0 1])), [0 1]);



sys=tf(num,den);
figure    
bode(sys)
hold on

figure
pzmap(sys)
grid on