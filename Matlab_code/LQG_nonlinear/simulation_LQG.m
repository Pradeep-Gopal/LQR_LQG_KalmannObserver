clc;
clear all;

x0 = [4;0.10;0.2;0;0;0;0;0;0;0;0;0];
t=0:0.1:100;

[t,x] = ode45(@nonlinear_lqg,t,x0);
plot(t,x(:,:))