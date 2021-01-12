% e_energy - Compute energy density in the electric field
clear all; help e_energy;  % Clear memory; print header

%@ Initialize variables (e.g., potential V(x,y), graphics)
epsilon0 = 8.85e-12;   % Permittivity of free space
fprintf('Enter potential V(x,y) as an equation \n');
fprintf('For example:  log(x^2 + y^2) \n');
V = input(': ','s');   % Read in V(x,y) as text string
NGrid = 20;            % Number of grid points for plots
xMax = 5;              % Values plotted from x= -xMax to x= xMax
yMax = xMax;           % Values plotted from y= -yMax to y= yMax
for i=1:NGrid
  xPlot(i) = -xMax + (i-1)/(NGrid-1)*(2*xMax); % x values to plot
  yPlot(i) = -yMax + (i-1)/(NGrid-1)*(2*yMax); % y values to plot
end

%@ Evaluate electric field as Ex = (-1)*dV/dx and Ey = (-1)*dV/dy
%  Note use of symop command to perform symbolic multiplication by -1
Ex = symop( '-1', '*', diff(V,'x') );
Ey = symop( '-1', '*', diff(V,'y') );
fprintf('Electric field components are \n');
disp(['x component : ', Ex]);
disp(['y component : ', Ey]);

%@ Loop over all grid points and evaluate V and E
for i=1:NGrid
 y = yPlot(i);
 for j=1:NGrid
   x = xPlot(j);   
 
   %@ Compute potential at the grid point
   VPlot(i,j) = eval( V );    % Potential V(x,y)
   
   %@ Compute square magnitude of the electric field
   E_Mag2 = eval( Ex )^2 + eval( Ey )^2;
   
   %@ Compute energy density
   E_Energy(i,j) = 0.5*epsilon0*E_Mag2;
   
 end
end

%@ Plot potential and energy density
clf;  figure(gcf);    % Clear figure; bring figure window forward

subplot(1,2,1)        % First (left) plot in 1x2 plot window
surf(xPlot,yPlot,VPlot);  % Plot potential in contour/mesh plot
xlabel('x');  ylabel('y'); zlabel('Potential (V)');
title('Potential');
shading interp        % Set interpolation method for drawing wiremesh

subplot(1,2,2)        % Second (right) plot in 1x2 plot window
surf(xPlot,yPlot,E_Energy);  % Plot energy density in contour/mesh plot
xlabel('x');  ylabel('y'); zlabel('Energy density (J/m^3)');
title('Energy density');
shading interp        % Set interpolation method for drawing wiremesh

% Set color scale 
colormap(bone);       % Note: instead of bone, try hsv, gray, hot or cool

   



