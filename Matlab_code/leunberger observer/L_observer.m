syms m1 m2 l1 l2 g M

%Variables
m1 = 100;
m2 = 100;
M = 1000;
l1 = 20;
l2 = 10;
g = 9.8;
poles=[-2,-1,-4,-5,-6,-3];
poles=transpose(poles);

%Initial Conditions
%x0=[0.5,0.3,0.6,0.4,0.8,1];
x0=[0,10,20,0,0,0,0,0,0,0,0,0];

option = 2
%1 for response of the system with initial conditions
%2 for response of the system with step input


%Matrices
A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -(m1*g)/M -(m2*g)/M 0 0 0; 0 (-g*(M+m1))/(M*l1) -(m2*g)/(M*l1) 0 0 0; 0 (-m1*g)/(M*l2) -(g*(M+m2))/(M*l2) 0 0 0];
Q = [1 0 0 0 0 0; 0 10 0 0 0 0; 0 0 150 0 0 0; 0 0 0 150 0 0; 0 0 0 0 10 0; 0 0 0 0 0 300];
B = [0; 0; 0; 1/M; 1/(M*l1); 1/(M*l2)];
C = [1 0 0 0 0 0];
D = 0;
R = 0.0001;

K=lqr(A,B,Q,R);
L = place(A',C',poles)'

%Response with the Initial conditions & without LQR
if option == 1
    sys = ss([(A-B*K) B*K; zeros(size(A)) (A-L*C)], [B;zeros(size(B))],[C zeros(size(C))], [0]);
    initial(sys,x0)
end

%Response with the Initial conditions & with LQR
if option == 2
    sys = ss([(A-B*K) B*K; zeros(size(A)) (A-L*C)], [B;zeros(size(B))],[C zeros(size(C))], [0]);
    step(sys)
end
    
grid on



