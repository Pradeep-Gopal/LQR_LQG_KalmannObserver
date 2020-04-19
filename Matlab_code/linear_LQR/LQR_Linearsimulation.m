syms m1 m2 l1 l2 g M

%Variables
m1 = 100;
m2 = 100;
M = 1000;
l1 = 20;
l2 = 10;
g = 9.8;

%Initial Conditions
%x0=[0.5,0.3,0.6,0.4,0.8,1];
x0=[0,10,20,0,0,0];

option = 2
%1 for response of the system with Initial conditions & without LQR
%2 for response of the system with Initial conditions & with LQR
%3 for The step response without the LQR controller
%4 for The step response with the LQR controller

%Matrices
A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -(m1*g)/M -(m2*g)/M 0 0 0; 0 (-g*(M+m1))/(M*l1) -(m2*g)/(M*l1) 0 0 0; 0 (-m1*g)/(M*l2) -(g*(M+m2))/(M*l2) 0 0 0];
Q = [1 0 0 0 0 0; 0 10 0 0 0 0; 0 0 150 0 0 0; 0 0 0 150 0 0; 0 0 0 0 10 0; 0 0 0 0 0 300];
B = [0; 0; 0; 1/M; 1/(M*l1); 1/(M*l2)];
C = eye(6);
D = 0;
R = 0.00001;



%Response with the Initial conditions & without LQR
if option == 1
    sys = ss(A,B,C,D);
    initial(sys,x0)
end

%Response with the Initial conditions & with LQR
if option == 2
    [K,P,poles] = lqr(A,B,Q,R);
    poles
    sys = ss(A-(B*K),(B*K),C,D);
    initial(sys,x0)
end
    
%The step response without the LQR controller
if option == 3
    sys = ss(A,B,C,D);
    t=0:0.01:250;
    step(sys,t) 
    hold on;
end

%The step response with the LQR controller
if option == 4
    [K,P] = lqr(A,B,Q,R);
    sys = ss(A-(B*K),B,C,D);
    t=0:0.01:250;
    step(sys,t)
    
end
grid on



