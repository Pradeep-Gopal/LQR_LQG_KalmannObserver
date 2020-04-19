clc
clear

x_0=[4;0.10;0.2;0;0;0];
t=0:0.01:100;

[t,y]=ode45(@non_linear,t,x_0)
plot(t,y);




