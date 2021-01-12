% orbit - Program to compute solar system orbits
clear all;            % Clear memory
help orbit;           % Print header

%@ Initialize variables
r0 = input('Enter initial distance (in AU): ');
GM = 4*pi^2;          % (Constant G)*(Mass of Sun)
CircleV = sqrt(GM/r0);
fprintf('For circular orbit, v = %g AU/yr\n',CircleV);
v0 = input('Enter initial tangential velocity (AU/yr): ');
r = [r0 0];           % Initial position
v = [0 v0];           % Initial velocity

%@ Find the period of a circular orbit from Kepler's law
%  and use it to fix the time step
Period = sqrt(4*pi^2*r0^3/GM);  % Period of circular orbit (yr)
fprintf('Period of a circular orbit T = %g yr \n',Period);
TotalTime = 3*Period; % Compute for 3 periods
NInterStep = 20;      % Number of steps between snapshots
NShots = 100;         % Number of snapshots
dt = TotalTime/(NInterStep*NShots);     % Time step (yr)
fprintf('Time step dt = %g yr \n',dt);

%@ Set up for plotting the orbit
clf;  figure(gcf);    % Clear figure window and bring it forward
plot(0,0,'y*');       % Mark the origin with an *
AxisMax = 1.5*r0;     % Axis limits are -AxisMax to AxisMax
axis([-AxisMax, AxisMax, -AxisMax, AxisMax]);
axis('square');       % Make the graph square to avoid distortion
grid on;              % Place a hash grid on the graph
xlabel('x (AU)');     % X-axis label
ylabel('y (AU)');     % Y-axis label
title('Computing orbit ...');
hold on;              % Hold the graph on the screen as points added

%@ Loop over desired number of snapshots
for iShot = 1:NShots

  %@ Loop over the desired number of steps between snapshots
  for i = 1:NInterStep
    %@ Compute new position and velocity using Euler-Cromer method
    Accel = -GM*r/norm(r)^3;  % Compute acceleration
    v = v + dt*Accel;         % Compute new velocity
    r = r + dt*v;             % Compute new position
  end

  %@ Add data point to graph; expand axis limits if needed
  plot(r(1),r(2),'r+','EraseMode','none');
  if( norm(r) > AxisMax )   % If position is outside axis limits
    AxisMax = 2*AxisMax;    % then increase limits
	axis([-AxisMax, AxisMax, -AxisMax, AxisMax]);
  end
  drawnow;   % Redraw the graph

end
% Put the title on the graph
title(sprintf('Orbit for r0 = %g AU, v0 = %g AU/yr',r0,v0));
