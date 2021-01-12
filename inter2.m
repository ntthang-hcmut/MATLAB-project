% inter2 - Two point interference pattern
clear; help inter2;  % Clear memory; print header

%@ Initialize variables (e.g., wavelength, separation of points)
Lambda = input('Enter wavelength of the light (in nm): ');
Lambda = Lambda * 1e-9;   % Convert nm to meters
d = input('Enter separation between points (in mm): ');
d = d * 0.001;  % Convert mm to meters
RScreen = input('Enter distance from points to screen (in m): ');

%@ Set up graphics
yScreenMax = 5*Lambda*RScreen/d;        % Axis limits for graph
xScreenMax = 10*yScreenMax;             % of screen pattern
Nx = 11;  Ny = 101;       % Number of points in image
xScreen = linspace(-xScreenMax,xScreenMax,Nx);
yScreen = linspace(-yScreenMax,yScreenMax,Ny);

%@ Loop over all spots on the screen
for i=1:Ny
 for j=1:Nx
 
   %@ Compute distance from first light point to screen
   L1 = sqrt( xScreen(j)^2 + (yScreen(i)-d/2)^2 + RScreen^2 );
   %@ Compute distance from second light point to screen
   L2 = sqrt( xScreen(j)^2 + (yScreen(i)+d/2)^2 + RScreen^2 );
   %@ From path difference, compute the phase difference
   Phi = 2*pi*(L2-L1)/Lambda;  
   %@ Compute the intensity for this spot on the screen
   %% Note: Assume equal intensity for each of the two interfering rays
   Intensity(i,j) = 4 * cos(Phi/2)^2;
   
 end
end

%@ Plot the image on the screen
clf;  figure(gcf);   % Clear the figure; bring figure window forward
NGrayLevels = 255;   % Number of gray levels to use
% Rescale intensity so  maximum value equals top gray level (i.e., white)
IntenGray = (Intensity/4.0) * NGrayLevels;
image(xScreen,yScreen,IntenGray);  % Plot the image
colormap(gray(NGrayLevels));       % Use a gray-scale color map
xlabel('x (m)');  ylabel('y (m)');
title('Intensity pattern on the screen');

              
