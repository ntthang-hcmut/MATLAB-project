% intgrl - Program to compute integrals numerically using
%          the simple approximation of a sum
clear all;        % Clear memory 
help intgrl;      % Print header

%@ Read integrand f(x) and integral limits
fprintf('Enter the integrand f(x) as an equation \n');
fprintf('e.g.,   3*(1+x)^2  \n');
integrand = input(':  ','s');    % Read input as text string
xLow = input('Enter lower limit: ');
xHigh = input('Enter upper limit: ');

%@ Initialize variables
N = 100;        % Number of points used in integration
dx = (xHigh - xLow)/(N-1);      % Interval between points
SumInt = 0.;    % Initialize running sum to zero

%@ Loop over points to be summed
for i=1:N

  %@ Compute x and f(x)
  x = xLow + (i-1)*dx;       % Compute x
  fun = eval(integrand);     % Evaluate f(x) from string
  
  %@ Augment the running sum
  SumInt = SumInt + fun*dx;     
  
end

%@ Compute the integral analytically
%  Note: IntExact is a text string, not a numerical value
IntExact = int(integrand,xLow,xHigh);

%@ Print the estimated and exact values of integral
fprintf(['Integral of ',integrand,' from %g to %g \n'] ...
                                        ,xLow,xHigh);
fprintf('Numerical estimate: %g \n',SumInt);
fprintf(['Analytical value:   ',IntExact,' \n']);
