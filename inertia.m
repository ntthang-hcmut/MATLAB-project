% inertia - Program to compute the rotational inertia of a nonuniform rod
%           by computing the integral numerically using trapezoidal rule
clear all;         % Clear memory 
help inertia;      % Print header

%@ Initialize variables
N = 1000;          % Number of points used in integration
% Read in the linear density function (kg/m)
fprintf('Enter the linear density lambda(x) as an equation \n');
fprintf('e.g.,  1/3 * x^2  \n');
lambda = input(':  ','s');   % Read input as a text string
L = input('Enter length of the rod (m): ');
dx = L/(N-1);      % Interval between points
SumMassInt = 0.;   % Initialize mass running sum to zero
SumInerInt = 0.;   % Initialize rotational inertia running sum to zero

%@ Loop over points to be summed to find the mass and rotational inertia
for i=2:N-1

  %@ Compute x and lambda(x)
  x = -L/2 + (i-1)*dx;     % Compute x
  lamx = eval(lambda);     % Evaluate lambda(x) from string
  
  %@ Augment the running sums
  SumMassInt = SumMassInt + lamx * dx;
  SumInerInt = SumInerInt + lamx * x^2 * dx;
  
end

%@ Separately include the contribution from each end point
x = -L/2;                % Left end point
lamx = eval(lambda);     % Evaluate lambda(x) from string
SumMassInt = SumMassInt + 0.5 * lamx * dx;
SumInerInt = SumInerInt + 0.5 * lamx * x^2 * dx;
x = L/2;                 % Right end point
lamx = eval(lambda);     % Evaluate lambda(x) from string
SumMassInt = SumMassInt + 0.5 * lamx * dx;
SumInerInt = SumInerInt + 0.5 * lamx * x^2 * dx;

%@ Print the mass and rotational inertia of the rod
fprintf('Mass of the rod = %g (kg)\n',SumMassInt);
fprintf('Rotational inertia = %g (kg m^2)\n',SumInerInt);
