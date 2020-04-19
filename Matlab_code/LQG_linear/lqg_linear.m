syms m1 m2 l1 l2 g M

%Variables
m1 = 100;
m2 = 100;
M = 1000;
l1 = 20;
l2 = 10;
g = 9.8;

option= 2;

%Initial Conditions
%x0=[0.5,0.3,0.6,0.4,0.8,1];
x0 = [4;0.10;0.2;0;0;0;0;0;0;0;0;0];


%Matrices
A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -(m1*g)/M -(m2*g)/M 0 0 0; 0 (-g*(M+m1))/(M*l1) -(m2*g)/(M*l1) 0 0 0; 0 (-m1*g)/(M*l2) -(g*(M+m2))/(M*l2) 0 0 0];
Q = [1 0 0 0 0 0; 0 10 0 0 0 0; 0 0 150 0 0 0; 0 0 0 150 0 0; 0 0 0 0 10 0; 0 0 0 0 0 300];
B = [0; 0; 0; 1/M; 1/(M*l1); 1/(M*l2)];
C = [1,0,0,0,0,0];
D = 0;
R = 0.00001;

K =lqr(A,B,Q,R);
vd=0.3*eye(6);
vn=1;
KF=lqr(A',C',vd,vn);
KF=KF';

%Response with the Initial conditions & without LQR
if option == 1
    sys = ss([(A-B*K) B*K; zeros(size(A)) (A-KF*C)], [B;zeros(size(B))],[C zeros(size(C))], [0]);
    initial(sys,x0)
end

%Response with the Initial conditions & with LQR
if option == 2
    sys = ss([(A-B*K) B*K; zeros(size(A)) (A-KF*C)], [B;zeros(size(B))],[C zeros(size(C))], [0]);
    step(sys)
end
    
grid on
