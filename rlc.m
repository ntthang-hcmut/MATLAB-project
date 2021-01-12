% rlc - Program to compute oscillations in an RLC circuit
clear; help rlc;   % Clear the memory; print header

%@ Initialize variables (e.g., resistance, inductance, capacitance)
R = input('Enter the resistance (ohms): ');
L = input('Enter the inductance (Henries): ');
C = input('Enter the capacitance (Farads): ');
Period = 2*pi*sqrt(L*C);
fprintf('Period is %g s \n',Period);
I_Initial = 0;     % Initial current (A)
q_Initial = 1;     % Initial charge (C)

%@ Define the matrix DMatrix 
DMatrix = [ (-R/L), (-1/(L*C));  1, 0 ];
			   
%@ Define the column vector f0			   
f0 = [ I_Initial;  q_Initial];    % Initial values of [Current; Charge]

%@ Loop over the times to plot the current and charge
TMax = 2*Period;   % Maximum time to compute values
Nplot = 100;       % Number of values to compute for plotting
for iplot=1:Nplot

  %@ Use exponential matrix solution to find current and charge
  t(iplot) = (iplot-1)/(Nplot-1) * TMax;    % Time
  f = expm( DMatrix*t(iplot) ) * f0;
  
  %@ Record current and charge for plotting
  I(iplot) = f(1);     % Record the current for plotting
  Q(iplot) = f(2);     % Record the charge for plotting
  
end

%@ Plot charge and current versus time
clf;  figure(gcf);  % Clear figure; bring figure window forward

subplot(2,1,1)  % Top figure
  plot(t,Q);
  xlabel('Time (s)');  ylabel('Charge (C)');
  
subplot(2,1,2)  % Bottom figure
  plot(t,I);
  xlabel('Time (s)');  ylabel('Current (A)');


  
  
