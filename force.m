% force - Program to compute force F(t) given position x(t) 
clear all;     % Clear memory
help force;    % Print header

%@ Enter displacement x(t) as a text string
fprintf('Enter x(t) as an equation; e.g., cos(t) \n');
x = input(': ','s');   % Read input as a text string

%@ Compute the velocity and acceleration
%  Use symbolic manipulator to perform derivatives        
v = diff(x,'t');       % v = dx/dt 
a = diff(v,'t');       % a = dv/dt = (d^2 x)/dt^2

%@ Compute and display expression for the force
% Use symop to symbolically compute F = m*a
F = symop('m','*',a);   
fprintf('Force (in the x-direction) = \n');
disp(F);           % Display the symbolic expression for F

%@ Loop over points to evaluate x and F
m = input('Enter mass, m : ');
NPoints = 100;     % Number of points to plot
dt = 0.1;          % Time increment
for iPoint=1:NPoints

  %@ Evaluate x(t) and F(t) for plotting
  t = (iPoint-1)*dt; 
  tPlot(iPoint) = t;         % Record time for plot
  xPlot(iPoint) = eval(x);   % Record x(t) for plot
  FPlot(iPoint) = eval(F);   % Record F(t) for plot
  
end

%@ Plot position and force versus time
clf;           % Clear graphics figure window
figure(gcf);   % Bring figure window forward
subplot(2,1,1) % Upper plot
  plot(tPlot,xPlot);   % Plot position vs. time
  xlabel('Time');      % X-axis label
  ylabel('Position');  % Y-axis label
subplot(2,1,2) % Lower plot
  plot(tPlot,FPlot);   % Plot force vs. time
  xlabel('Time');      % X-axis label
  ylabel('Force');     % Y-axis label
