% Megan Chu
% MATH 105A
% Week 1 Computer Assignment
% locate root of equation using bisection method

% functions are defined at the end for equation we are finding root of

tol = 10^(-6);
N_max = 300;

% step 1
p=zeros(N_max,1);
e=zeros(N_max,1);
a=zeros(N_max,1);
b=zeros(N_max,1);
a(1) = -1; % initial x lower bound
b(1) = 1; % initial y lower bound
i = 1; % count iteration
while 1 % run forever until break
    p(i) = a(i) + ((b(i)-a(i))/2); % midpoint b/w a and b
    e(i) = abs(b(i)-a(i));
    
    if e(i) < tol
        break % we found a solution!
    end
    
    fp = f(p(i));
    
    if fp == 0
        break % we found a solution!
    end
        
    fa = f(a(i));
    
    if fa*fp > 0 % f(a) and f(p) have same sign
        a(i+1) = p(i);
        b(i+1) = b(i); % b stays = to b
    else % f(a) and f(p) different sign
        a(i+1) = a(i); % a stays = to a
        b(i+1) = p(i);
    end
    
    i = i + 1;
    
    % if we have reached end of last iteration
    if i > N_max
        fprintf("MAX ITERATION REACHED NO SOLUTION FOUND")
        break % break after max iterations reached!!
    end
end

format long e;
approximate_zero = p(1:i-1)


% display answer and plot only if found within N_max iterations
if i < N_max + 1
    fprintf(strcat("\n\tRoot of 6(e^x−x) = 7+3x^2+2x^3 between [-1,1] is \n\t\tx = ",num2str(p(i)),"\n\twith \n\t\terror = ",num2str(e(i)),"\n\n"))
    
    figure(1)   %create a frame called figure 1
    clf      % clear anything in the figure frame
    plot(p(1:i-1));
    grid on;
    title('Approximation of zeros')
    xlabel('iteration number')
    ylabel('Approximate zero, p_i')
    
    figure(2)   %create a frame called figure 2
    clf
    semilogy(e(1:i-1))
    grid on;
    title('Error')
    xlabel('iteration number')
    ylabel('error in log scale')

    x = -1 : 0.01: 1;
    y = f(x);
    
    figure(3);  %create a frame called figure 2
    clf
    plot(x,y);
    title('The graph of the function')
    xlabel('x')
    ylabel('function values')
    hold on      % do not get rid of the graph (x,y)
    plot(x,0*y,'r-')  % the x-axis; the zero is the intersection of the graph and the x-axis
    grid on;
    
end


% equation to find root of
function y = f(x)
    y = h(x) - g(x);
end

function y = g(x) % LHS of equation
    y = 6*(exp(x) - x);
end

function y = h(x) % RHS of equation
    y = 7 + 3.*x.*x + 2.*x.*x.*x;
end