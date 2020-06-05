% Megan Chu
% MATH 105A
% Week 5 Computer Assignment
% implement Jacobi iterative method

% change n, A, b, tol, and x(:,1) depending on problem (Note that x(:,1) represents x^(0)).
% variables are currently defined for the system of equations specified in the assignment
n = 3;
A=[ 1  2 -2;
    1  1  1;
    2  2  1];
b=[7;
   2;
   5];
tol = [10^(-5);
       10^(-5);
       10^(-5)];
N_max = 25;
x = zeros(n,N_max+1);
x(:,1) = zeros(n,1);
% My SOLUTION for the system of equations specified in the assignment is
% x =
%     1
%     2
%    -1
% The Jacobi method converges because its spectral radius (p(T) = 1.23322e-05) is < 1.


% jacobi method
for k = 2:N_max+1
    for i = 1:n
        sum = 0;
        for j = 1:n
            if i ~= j
                sum = sum + A(i,j).*x(j,k-1);
            end
        end
        x(i,k) = (b(i) - sum)/A(i,i);
    end
    if abs(x(:,k)-x(:,k-1)) < tol
        x = x(:,k)
        break
    end
    if k == N_max
        disp(sprintf("\nMax number of iterations exceeded"));
    end  
end

% check for convergence
D = zeros(n,n);
L = zeros(n,n);
U = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i == j
            D(i,j) = A(i,j);
        elseif i < j % upper triangular
            U(i,j) = -A(i,j);
        elseif i > j % lower triangular
            L(i,j) = -A(i,j);
        end
    end
end
p = max(abs(eig(inv(D)*(L+U))));
if p >= 1
    disp(sprintf("The Jacobi method does not converge since its spectral radius (p(T) = %g) is >= 1.\n",p))
else
    disp(sprintf("The Jacobi method converges because its spectral radius (p(T) = %g) is < 1.\n",p))
end