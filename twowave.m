% twowave - Compute superposition of two waves
clear all;        % Clear memory and figure
help twowave;     % Print header

%@ Initialize variables
WaveSpeed = 1.0;              % Wave speed (m/s)
fprintf('Wave speed = %g m/s \n',WaveSpeed);
fprintf('Enter values as [Wave1, Wave2] \n');
A = input('Amplitudes [A1, A2]: ');
omega = input('Frequencies [omega1, omega2]: ');
phi = input('Phases (in degrees) [phi1, phi2]: ');
k(1) = omega(1)/WaveSpeed;    % Wave number (m^-1)
k(2) = omega(2)/WaveSpeed;    % Wave number (m^-1)
phi(1) = phi(1) * pi/180;     % Convert phase 1 to radians
phi(2) = phi(2) * pi/180;     % Convert phase 2 to radians
xMax = 2;                     % Maximum value for x (m)

%@ Set up for plotting
clf;  figure(gcf);            % Clear figure and bring window forward
Nx = 200;                     % Number of values for x
for i=1:Nx
  x(i) = (i-1)/(Nx-1) * xMax; % Compute values of x for plotting
end
zMax = abs(A(1))+abs(A(2));   % Maximum value for wave sum
tIncrement = 0.1;             % Time increment between plots

%@ Loop over the number of frames to display
NPlots = 11;        % Number of plots
for iPlot=1:NPlots

  %@ Compute each wave and their sum
  t = (iPlot-1)*tIncrement;                               % Time
  for i=1:Nx
    z1(i) = A(1)*sin( k(1)*x(i) - omega(1)*t + phi(1) );  % Wave 1
    z2(i) = A(2)*sin( k(2)*x(i) - omega(2)*t + phi(2) );  % Wave 2
    zSum(i) = z1(i) + z2(i);                              % Sum of waves
  end
  
  %@ Plot each wave and their sum
  plot(x,z1,'r-',x,z2,'b-',x,zSum,'g-');   % Plot each wave and sum
  text(x(Nx/3),z1(Nx/3),'1');              % Label first wave
  text(x(2*Nx/3),z2(2*Nx/3),'2');          % Label second wave
  text(x(Nx/2),zSum(Nx/2),'Sum');          % Label sum of waves
  axis([0 xMax -zMax zMax]);               % Fix axis limits on plots
  xlabel('x (m)');                         % X-axis label
  ylabel('Wave displacement');             % Y-axis label
  title(sprintf('Time = %g s',t));         % Graph title
  drawnow;                                 % Draw the graph
  
end

