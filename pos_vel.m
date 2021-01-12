% pos_vel - Program to compute velocity given x(t)
clear all;     % Clear memory
help pos_vel;  % Print header

%@ Enter displacement x(t)
fprintf('Enter x(t) as an equation; for example, \n');
fprintf('  5*t + 8*t^2 + 4*t^3 - 0.25*t^4  \n');
xFunction = input(': ','s');  % Read input as a text string

%@ Initialize variables
tMax = 10.0;      % Maximum value for time
NPoints = 100;    % Number of points to plot
DeltaT = 1.e-4;   % Delta t for estimating derivatives

%@ Loop over points to evaluate x and v
for iPoint=1:NPoints

  %@ Evaluate x(t) and x(t+DeltaT)
  t = (iPoint-1)/(NPoints-1)*tMax;  % Time t
  tPlot(iPoint) = t;                % Record time for plotting
  x_t = eval(xFunction);            % Compute x(t)
  t = t + DeltaT;                   % Time t+DeltaT
  x_tPlus = eval(xFunction);        % Compute x(t+DeltaT)
  
  %@ Estimate velocity as (x(t+DeltaT) - x(t))/DeltaT
  v = (x_tPlus - x_t)/DeltaT;   
  
  %@ Record displacement and velocity for plotting
  xPlot(iPoint) = x_t;          % Record x(t)
  vPlot(iPoint) = v;            % Record velocity
  
end

%@ Plot displacement and velocity versus time
clf;           % Clear graphics figure window
figure(gcf);   % Bring figure window forward
subplot(1,2,1)
  plot(tPlot,xPlot);
  xlabel('Time (s)');  
  ylabel('Displacement (m)');
subplot(1,2,2)
  plot(tPlot,vPlot);
  xlabel('Time (s)');  
  ylabel('Velocity (m/s)');


