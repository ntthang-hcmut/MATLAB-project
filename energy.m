% energy - Program to compute kinetic and potential energy
%          for a particle acted on by a conservative force
clear all;      % Clear memory
help energy;    % Print header

%@ Initialize variables
kCoeff = 1.0;   % Kappa coefficient (N/m)
qCoeff = 0.1;   % q coefficient (N/m^3)
x = input('Enter initial displacement (m): ');
v = 0.;         % Initial velocity (m/s)
mass = 1.0;     % Mass of particle
dt = 0.05;      % Time step (s)
KEnergy = 0.5*mass*v^2;                  % Kinetic energy
UEnergy = -0.5*kCoeff*x^2 + qCoeff*x^4;  % Potential energy
TEnergy = KEnergy + UEnergy;             % Initial total energy
t = 0;                   % Time
Nstep = 300;             % Number of time steps
  
%@ Set up plot of kinetic and potential energy versus time
clf;                              % Clear the figure window
figure(gcf);                      % Bring figure window forward
EnergyLimit = 2*abs(TEnergy);     % Estimate y-axis limit
axis([0, Nstep*dt, -EnergyLimit, EnergyLimit]);    % Set axis limits
xlabel('Time (s)');               % x-axis label
ylabel('Energy (J)');             % y-axis label
title('Kinetic (*)  Potential (+)');
hold on;                          % Hold the plot on screen

%@ Loop for desired number of steps
for istep=1:Nstep

  %@ Compute kinetic and potential energy
  KEnergy = 0.5*mass*v^2;  % Kinetic energy
  UEnergy = -0.5*kCoeff*x^2 + qCoeff*x^4;
  t = (istep-1)*dt;   % Time
  
  %@ Update the plot by adding new values to the graph
  plot(t, KEnergy,'r*','EraseMode','none');
  plot(t, UEnergy,'b+','EraseMode','none');
  while( abs(KEnergy) > EnergyLimit | abs(UEnergy) > EnergyLimit )
    EnergyLimit = 2*EnergyLimit;
    axis([0, Nstep*dt, -EnergyLimit, EnergyLimit]);    % Set axis limits
  end
  drawnow;  % Update the figure now

  %@ Compute force and acceleration
  Force = kCoeff*x - 4*qCoeff*x^3;   % Force
  accel = Force/mass;                % Acceleration

  %@ Update position and velocity using Euler-Cromer
  v = v + accel*dt;    % Compute new position and velocity
  x = x + v*dt;        % using Euler-Cromer
end
