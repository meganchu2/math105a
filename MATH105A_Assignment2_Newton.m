% Megan Chu
% MATH 105A
% Week 2 Computer Assignment
% locate root of equation using Newton's method
% https://www.mathworks.com/help/matlab/matlab_prog/formatting-strings.html

% change function a, b, and tol(tolerance) depending on the problem
f = @(x)300 - (.25*32.17*x/.1) + ((.25^2)*32.17/(.1)^2)*(1-exp(-.1*x/.25)); % please define function with format '@(x)...'
% for finding a fixed point of a function g(x), define f to be '@(x)g(x)-x
a = 0;
b = inf;
tol = 0.01;

N = 300; % max iterations, can make value larger if function converges super slowly
p=zeros(N,1);

if isinf(a) && isinf(b)
    p0 = 0;
elseif isinf(a)
    p0 = b-1;
elseif isinf(b)
    p0 = a+1;
else
    p0 = (a+b)/2;
end

syms x; % temporary x variable
% check if function is constant
if diff(f(x)) ~= 0 % f is a non-constant function
        
    % check if function has constant derivative
    if diff(diff(f(x))) == 0 % f' is constant but not 0 since we checked previously for that
        z = diff(f(x));
        f1 = @(x)z; % 
    else % f' depends on x
        f1 = matlabFunction(diff(f(x))); % define derivative function of given function f
    end
    
    if f1(a)*f1(b) < 0 % derivatives at endpoints differ in sign => exists point f' = 0 in [a,b]
        disp(sprintf("\nNewton's method failed because f'(x) = 0 when x = %0.10f\n", fzero(f1,[1 2])))
        return; % end script
    end
    
    currP = p0;
    i = 1;
    while i <= N
        p(i) = currP - f(currP)/f1(currP);
        if abs(p(i)-currP) < tol
            if p(i) < a | p(i) > b
                disp(sprintf("\nThe function has a zero when x = %0.10f, but this is not in the range [%g,%g]\n",p(i),a,b))
                figure(1)   %create a frame called figure 1
                clf      % clear anything in the figure frame
                ezplot(f(x),[a b]);
                grid on;
                title(sprintf("Graph of f(x) = for x in [%g,%g]",a,b))
                xlabel('value of x')
                ylabel('value of f(x)')
            else
                disp(sprintf("\nApproximate solution for p is %0.10f\n",p(i)))
                figure(1)   %create a frame called figure 1
                clf      % clear anything in the figure frame
                plot(p(1:i));
                hold on;
                plot([0 1], [p0 p(1)],'Color',[0 .447 .741]);
                grid on;
                title(sprintf("Approximation of zero for x in [%g,%g]",a,b))
                xlabel('iteration number')
                ylabel('Approximate zero, p_i')
            end
            break
        end
        currP = p(i); % store current p
        i = i+1;
        if i > N
            disp(sprintf("The method failed after N iterations, N = %u\n", N))
            figure(1)   %create a frame called figure 1
            clf      % clear anything in the figure frame
            plot(p(1:N));
            grid on;
            title(sprintf("Approximation of zero for x in [%g,%g]",a,b))
            xlabel('iteration number')
            ylabel('Approximate zero, p_i')
            break
        end    
    end
    
    
else % f is a constant function
    
    figure(1)   %create a frame called figure 1
    clf      % clear anything in the figure frame
    ezplot(f);
    grid on;
    title(sprintf("Graph of constant function f(x)"))
    xlabel('value of x')
    ylabel('value of f(x)')
    
    f = str2num(extractAfter(func2str(f),4)); % gets numeric value of constant function f
    disp(sprintf("\nNewton's method fails since f'(x) = 0 for all real x of a constant function f(x) = %g",f))
    
    if f == 0 % there exist zeros of a constant function only if f(x) = 0
       disp(sprintf("We know all real x in [%g,%g] are zeros for function f(x) = %g\n",a,b,f))
    else % f(x) != 0
        disp(sprintf("We know no real numbers, x, exist such that f(x) = %g will equal zero\n",f))
    end
end