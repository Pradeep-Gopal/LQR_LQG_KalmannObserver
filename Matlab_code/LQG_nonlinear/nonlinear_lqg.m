function dx=nonlinear_lqg(t,x)
% syms m1 m2 l1 l2 g M F U

%Variables
m1 = 100;
m2 = 100;
M = 1000;
l1 = 20;
l2 = 10;
g = 9.8;


%Matrices
A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -(m1*g)/M -(m2*g)/M 0 0 0; 0 (-g*(M+m1))/(M*l1) -(m2*g)/(M*l1) 0 0 0; 0 (-m1*g)/(M*l2) -(g*(M+m2))/(M*l2) 0 0 0];
Q = [1 0 0 0 0 0; 0 10 0 0 0 0; 0 0 150 0 0 0; 0 0 0 150 0 0; 0 0 0 0 10 0; 0 0 0 0 0 300];
B = [0; 0; 0; 1/M; 1/(M*l1); 1/(M*l2)]
C = [1 0 0 0 0 0];
D = 0;
R = 0.0001;

K =lqr(A,B,Q,R);
vd=0.3*eye(6);
vn=1;
KF=lqr(A',C',vd,vn);
KF=KF';
U=-K*x(1:6);


sigma_dot=(A-KF*C)*x(7:12);
dx=zeros(12,1);
dx(1)= x(4);
dx(2)= x(5);
dx(3)= x(6);
dx(4)=((1/(M+m1+m2-m1*(cos(x(2))^2)-m2*(cos(x(3))^2)))*(U-(m1*l1*sin(x(2))*(x(5)^2))-(m2*l2*sin(x(3))*(x(6)^2))-m1*cos(x(2))*g*sin(x(2))-m2*cos(x(3))*g*sin(x(3))));
dx(5)=(1/l1)*((cos(x(2))*(((1/(M+m1+m2-m1*(cos(x(2))^2)-m2*(cos(x(3))^2)))*(U-(m1*l1*sin(x(2))*(x(5)^2))-(m2*l2*sin(x(3))*(x(6)^2))-m1*cos(x(2))*g*sin(x(2))-m2*cos(x(3))*g*sin(x(3))))))-g*sin(x(2)));
dx(6)=(1/l2)*((cos(x(3))*(((1/(M+m1+m2-m1*(cos(x(2))^2)-m2*(cos(x(3))^2)))*(U-(m1*l1*sin(x(2))*(x(5)^2))-(m2*l2*sin(x(3))*(x(6)^2))-m1*cos(x(2))*g*sin(x(2))-m2*cos(x(3))*g*sin(x(3))))))-g*sin(x(3)));
dx(7)= x(4)-x(10);
dx(8)= x(5)-x(11);
dx(9)= x(6)-x(12);
dx(10)= dx(4)-sigma_dot(4);
dx(11)= dx(5)-sigma_dot(5);
dx(12)= dx(6)-sigma_dot(6);


















