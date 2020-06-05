% Megan Chu
% MATH 105A
% Week 3 Computer Assignment
% perform gaussian elimination with row swapping

% change n and matrix depending on problem
% n and A are currently defined for the matrix specified in the assignment
n = 4;
A=[ 1 -1  2 -1;
    2 -2  3 -3;
    1  1  1  0;
    1 -1  4 -3];
% My SOLUTION for the matrix specified in the assignment is
% Row Reduced Echelon Form of [A I] is: 
% rreAI =
%    1.0000         0         0         0         0    0.5000    0.5000   -0.5000
%         0    1.0000         0         0   -0.7500         0    0.5000    0.2500
%         0         0    1.0000         0    0.7500   -0.5000         0    0.2500
%         0         0         0    1.0000    1.2500   -0.5000         0   -0.2500
%
% Row Reduced Echelon Form of A is: 
% rreA =
%     1     0     0     0
%     0     1     0     0
%     0     0     1     0
%     0     0     0     1
%
% Inverse of original matrix is: 
% AInv =
%         0    0.5000    0.5000   -0.5000
%   -0.7500         0    0.5000    0.2500
%    0.7500   -0.5000         0    0.2500
%    1.2500   -0.5000         0   -0.2500
%
% Checking if AxA^(-1) = I: 
% AxAInv =
%     1     0     0     0
%     0     1     0     0
%     0     0     1     0
%     0     0     0     1


A0 = A;
I = eye(n);
A =[A0 I];

% use gaussian elimination to get upper triangular matrix (echelon form)
for i = 1:n
    boolean = 0;
    for p = i:n
        a = A(p,i);
        if a ~= 0 % there exists api not equal to 0
            boolean = 1;
            break
        end
    end
    if boolean == 0
        disp(sprintf("not invertible"))
        return;
    end
    if p ~= i
        tempRow = A(i,:);
        A(i,:) = A(p,:); % replace ith row with pth row
        A(p,:) = tempRow; % replace pth row with ith row
    end
    for j = 1:n 
        if j ~= i
            m = A(j,i)/A(i,i);
            A(j,:) = A(j,:) - m.*A(i,:);
        end
    end
end
if A(n,n) == 0
    disp(sprintf("Matrix not invertible"))
    return;
end


for j = 1:n
    A(j,:) = A(j,:)/A(j,j);
end

% formatting string to display solution vector

rreA = A(1:n,1:n);
AInv = A(1:n,n+1:n+n);
rreAI = A;
A = A0;

disp("Original matrix is: ")
A
disp("Row Reduced Echelon Form of [A I] is: ")
rreAI
disp("Row Reduced Echelon Form of A is: ")
rreA
disp("Inverse of original matrix is: ")
AInv
disp("Checking if AxA^(-1) = I: ")
AxAInv = A*AInv