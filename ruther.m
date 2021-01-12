% ruther - Program to compute the scattering of alpha
%          particles by a nucleus (Rutherford scattering)
clear all;  help ruther;  % Clear memory and print header

%@ Initialize variables (e.g., particle position, energy, nucleus Z)
mass = 4.002603 * 1.66054e-27;    % Mass of alpha particle (kg)
y0 = input('Enter impact parameter (femtometers) - '); % TRY 100 fm
y0 = 1e-15 * y0;   % Convert to meters 
x0 = 5e-12;        % Initial horizontal distance (m)
r = [x0 y0];       % Initial position vector
normr0 = norm(r);  % Initial radial distance
e0 = input('Enter particle energy (MeV) - ');  % TRY 1 MeV
e0 = 1.6022e-19 * 1e6 * e0;      % Convert to Joules
v0 = sqrt(2*e0/mass);            % Initial speed (m/s)
v = [-v0 0];   % Initial velocity vector
Z1 = 79;       % Atomic number of nucleous (79 for gold)
Z2 = 2;        % Atomic number of particle (2 for alpha)
Delta_t = input('Enter time step, Delta t (attosec) - ');  % TRY 0.005
Delta_t = 1e-18 * Delta_t;             % Convert to seconds
% Magnitude of force = coeff * Z1 * Z2 /norm(r)^2
coeff = (1.602177e-19)^2/(4*pi*8.8542e-12);     
Constant = coeff*Z1*Z2/mass;

%@ Set up graphics
clf;  figure(gcf);            % Clear figure window and bring it forward
plot(1e15*r(1),1e15*r(2),'+','EraseMode','none');  % Mark initial position
plot(0,0,'r*','EraseMode','none');     % Mark origin with a red asterisk
rAxis = x0;                            % Initial axis scale
axis(1e15*rAxis*[-1, 1, -1, 1]);       % Fix axis min and max
grid;                                  % Put a grid on the plot
xlabel('x (fm)');   ylabel('y (fm)');  % Axis labels
title('Rutherford scattering');        % Plot title
hold on;                               % Hold graph as data is added
drawnow;

%@ Loop over maximum possible time steps (with option to break)
time = 0;            % Initial time
MaxSteps = 1000;     % Maximum number of steps
for istep=1:MaxSteps
  
  %@ Calculate new position and velocity from acceleration
  accel = Constant*r/norm(r)^3;   % Acceleration due to Coulomb repulsion
  v = v + Delta_t*accel;          % Use Euler-Cromer method to update
  r = r + Delta_t*v;              % velocity and position
  time = time + Delta_t;          % Increment the time
  
  %@ Stop computing positions if scattering is complete
  if( norm(r) > normr0 )
    break;  % Break out of loop if distance exceeds initial distance
  end

  %@ Add data point to the plot of position for alpha particle
  plot(1e15*r(1),1e15*r(2),'+','EraseMode','none');
  if( norm(r) < rAxis/3 )   % Zoom in as alpha particle approaches nucleus
    rAxis = rAxis/3;                    % Reduce axis limits
    axis(1e15*rAxis*[-1, 1, -1, 1]);    % Reset axis min and max
  elseif( norm(r) > rAxis ) % Zoom out as alpha particle moves outward
    rAxis = 3*rAxis;                    % Increase axis limits
    axis(1e15*rAxis*[-1, 1, -1, 1]);    % Reset axis min and max
  end	
  drawnow;                        % Redraw the plot
  
end
hold off;
