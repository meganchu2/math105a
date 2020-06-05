% Megan Chu
% MATH 105A
% Week 3 Computer Assignment
% perform gaussian elimination with row swapping

% change n and matrix depending on problem
% n and A are currently defined for the system of equations specified in the assignment
n = 4;
A=[ pi      -sqrt(2) -1        1        0;
    exp(1)  -1        1        2        1;
    1        1       -sqrt(3)  1        2;
   -1       -1        1       -sqrt(5)  3];
% My SOLUTION for the system of equations specified in the assignment is
% Unique solution is given by: 
%	[ x1 x2 x3 x4 ] = [ 6.294202081757  7.411230234135  3.295776169731  -5.996980539543  ]

% use gaussian elimination to get upper triangular matrix (echelon form)
for i = 1:n-1
    boolean = 0;
    for p = i:n
        a = A(p,i);
        if a ~= 0 % there exists api not equal to 0
            boolean = 1;
            break
        end
    end
    if boolean == 0
        disp(sprintf("no unique solution"))
        return;
    end
    if p ~= i
        tempRow = A(i,:);
        A(i,:) = A(p,:); % replace ith row with pth row
        A(p,:) = tempRow; % replace pth row with ith row
    end
    for j = i+1:n
        m = A(j,i)/A(i,i);
        A(j,:) = A(j,:) - m.*A(i,:);
    end
end
if A(n,n) == 0
    disp(sprintf("no unique solution exists"))
    return;
end

% backwards substitution
x=zeros(n,1);
x(n) = A(n,n+1)/A(n,n);
for i = n-1:-1:1
    sum = 0;
    for j = i+1:n
        sum = sum + A(i,j).*x(j);
    end
    x(i) = (A(i,n+1)-sum)/A(i,i);
end

% formatting string to display solution vector
output = sprintf("\nUnique solution is given by: \n\t[ ");
for i = 1:n
    output = output + "x" + num2str(i) + " ";
end  
disp(output + "] = [  " + sprintf("%g  ",x(:)) + sprintf("]\n"))
        
