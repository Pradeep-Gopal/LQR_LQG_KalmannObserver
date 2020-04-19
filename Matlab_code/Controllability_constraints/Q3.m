clc;
syms m1 m2 M g l1 l2

%l1


A = [0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1; 0 -(m1*g)/M -(m2*g)/M 0 0 0; 0 (-g*(M+m1))/(M*l1) -(m2*g)/(M*l1) 0 0 0; 0 (-m1*g)/(M*l2) -(g*(M+m2))/(M*l2) 0 0 0];
B = [0; 0; 0; 1/M; 1/(M*l1); 1/(M*l2)];

disp(A)
disp(B)

AB = A*B;
A2B = A*AB;
A3B = A*A2B;
A4B = A*A3B;
A5B = A*A4B;
 
%  disp(B)
%  disp(AB);
%  disp(A2B);
%  disp(A3B);
%  disp(A4B);
%  disp(A5B);

C = [B AB A2B A3B A4B A5B];
disp(C);

DET = det(C);
DET = simplify(DET);
disp(DET);