% lorentz - Program to compute the motion of an electron in
%           an E and B field using the Euler-Cromer method
clear all; help lorentz;  % Clear memory and print header

%@ Initialize variables (e.g., electric and magnetic fields)
r = [0 0 0];       % Initial position
v = input('Enter initial velocity [vx vy vz] (m/s) - ');
B = [0 0 1];       % B field (points in z-direction);
fprintf('Magnetic induction B = [%g %g %g] tesla\n',...
                              B(1),B(2),B(3));
E = input('Enter electric field, [Ex Ey Ez] (V/m) - ');
dt = 1e-13;             % Time step (sec)
mass = 9.10939e-31;     % Mass of electron (kg)
q = 1.602177e-19;       % Charge of electron (C)
q_over_m = q/mass;

%@ Set up for plotting the electron's motion
clf;  figure(gcf);    % Clear figure window and bring it forward
plot(0,0,'bo');       % Mark the origin with a blue circle
XMax = 1.0e-11;  XMin = -XMax;   % Axis limits
YMin = XMin;     YMax = XMax;       
axis([XMin, XMax, YMin, YMax]);
grid on;              % Place a hash grid on the graph
xlabel('x (m)');      % X-axis label
ylabel('y (m)');      % Y-axis label
title('Computing motion ...');
hold on;              % Hold the graph on the screen as points are added

%@ Loop over time steps to compute the motion
time = 0.0;
nstep = 1000;
for istep=1:nstep

  %@ Compute acceleration on electron as a = q/m (E + v X B)
  v_cross_B = [ (v(2)*B(3)-B(2)*v(3)) ...
               -(v(1)*B(3)-B(1)*v(3)) ...
                (v(1)*B(2)-B(1)*v(2)) ];
  accel = q_over_m * (E + v_cross_B);
  
  %@ Calculate new position and velocity using Euler-Cromer
  v = v + dt*accel;     % Update the velocity
  r = r + dt*v;         % Update the position
  time = time + dt;     % Increment the time
  
  %@ Add data point to graph; expand axis limits if needed
  plot(r(1),r(2),'.','EraseMode','none');
  if( r(1) > XMax )       % If position is outside axis limits
    XMax = 2*XMax;        % then increase limits
	axis([XMin, XMax, YMin, YMax]);
  elseif( r(1) < XMin )   % If position is outside axis limits
    XMin = 2*XMin;        % then increase limits
	axis([XMin, XMax, YMin, YMax]);
  elseif( r(2) > YMax )   % If position is outside axis limits
    YMax = 2*YMax;        % then increase limits
	axis([XMin, XMax, YMin, YMax]);
  elseif( r(2) < YMin )   % If position is outside axis limits
    YMin = 2*YMin;        % then increase limits
	axis([XMin, XMax, YMin, YMax]);
  end
  drawnow;   % Redraw the graph
   
end
% Write final title to show that calculation is complete
title(sprintf('Motion of an electron for %g seconds',time));

