% oildrag - Program to compute motion of a marble falling
%           in a jar of oil (Example 5-9)
clear all;        % Clear memory 
help oildrag;     % Print header

%@ Initialize variables
mass = 0.005;   % Mass of the marble (kg)
grav = -9.81;   % Gravitational acceleration (m/s^2)
bCoeff = input('Enter drag coefficient b (kg/s): ');
cCoeff = input('Enter drag coefficient c (kg/m): ');
dt = 0.002;     % Time step (s)
Nstep = 100;    % Number of steps
v = 0.;         % Initial velocity (m/s)

%@ Loop over number of steps to be evaluated
for istep=1:Nstep

  %@ Record time and velocity for plotting
  tPlot(istep) = (istep-1)*dt;    % Time
  vPlot(istep) = v;               % Velocity
  
  %@ Compute the drag force
  DragForce = -sign(v)*(bCoeff*abs(v) + cCoeff*v^2);
  
  %@ Compute the net acceleration from drag and gravity
  accel = DragForce/mass + grav; 

  %@ Compute new velocity using Euler method
  v = v + accel*dt;     
  
end

%@ Plot velocity versus time
clf;                                 % Clear figure window
figure(gcf);                         % Bring figure window forward
plot(tPlot,vPlot,'+');               % Plot velocity versus time
xlabel('Time (s)');                  % x-axis label
ylabel('Vertical velocity (m/s)');   % y-axis label
title('Marble falling in oil');      % Title of the graph
  
