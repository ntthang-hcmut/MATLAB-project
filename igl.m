% igl - Compute pressure, volume or temperature curves
%       using the ideal gas law
clear all;  help igl;  % Clear memory; print header

%@ Initialize variables
nMoles = input('Enter the number of moles of gas: ');
R = 8.314;      % Ras constant (J/mole)

%@ Set up graphics
clf;  figure(gcf);  % Clear figure window; Bring it forward
NPoints = 200;  % Number of points per curve
NCurves = 5;    % Number of curves
TMax = 1000;    % Maximum temperature to plot (K)
TMin = 0;       % Minimum temperature to plot (K)
VMax = 1.0;     % Maximum volume to plot (m^3)
VMin = 0.1;     % Minimum volume to plot (m^3)
GraphType = menu('Select type of graph to plot:', ...
  'Pressure vs. Volume', 'Pressure vs. Temperature');

%@ If pressure vs. volume is to be plotted
if( GraphType == 1 )
  %@ Compute values of volume to use
  for i=1:NPoints
    V(i) = VMin + (i-1)/(NPoints-1) * (VMax - VMin);
  end
  %@ For each temperature curve
  for iCurve=1:NCurves
    T(iCurve) = TMin + (iCurve-1)/(NCurves-1) * (TMax - TMin);
	%@ Compute the pressure
	for j=1:NPoints
	  P(iCurve,j) = nMoles*R*T(iCurve)/V(j);
	end
  end
  %@ Graph the pressure versus volume
  plot(V,P);
  xlabel('Volume (m^3)');  ylabel('Pressure (Pa)');
  title(sprintf('Number of moles = %g',nMoles));
  %@ Label the temperature for each curve on the graph
  for iCurve=1:NCurves
    iText = iCurve/NCurves*NPoints;    % Location to place text
    text(V(iText),P(iCurve,iText),sprintf('T = %g K',T(iCurve)));
  end
  
%@ If pressure vs. temperature is to be plotted
elseif( GraphType == 2 )
  %@ Compute values of temperature to use
  for i=1:NPoints
    T(i) = TMin + (i-1)/(NPoints-1) * (TMax - TMin);
  end
  %@ For each volume curve
  for iCurve=1:NCurves
    V(iCurve) = VMin + (iCurve-1)/(NCurves-1) * (VMax - VMin);
	%@ Compute the pressure
	for j=1:NPoints
	  P(iCurve,j) = nMoles*R*T(j)/V(iCurve);
	end
  end
  %@ Graph the pressure versus temperature
  plot(T,P);
  xlabel('Temperature (K)');  ylabel('Pressure (Pa)');
  title(sprintf('Number of moles = %g',nMoles));
  %@ Label the volume for each curve on the graph
  for iCurve=1:NCurves
    iText = iCurve/NCurves*NPoints;    % Location to place text
    text(T(iText),P(iCurve,iText),sprintf('V = %g m^3',V(iCurve)));
  end
else
  error('ERROR: Illegal value for GraphType');
end

	


