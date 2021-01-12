% refract - Program to compute refraction at a plane surface
clear all;  help refract;     % Clear memory and print header

%@ Initialize variables (e.g., indices of refraction)
x0 = 0.0;  y0 = 1.0;   % Position of light source
y1 = 0.0;              % Y-coordinate of first surface
x1Max = 2.0;           % Max value for x1
y2 = -1.0;             % Y-coordinate of bottom of figure
fprintf('Enter the index of refraction for each surface \n');
nIndexI = input('Incident:   ');
nIndexR = input('Refracting: ');

%@ Initialize plot routines
clf;  figure(gcf);    % Clear figure window and bring it forward
xSurface = [-2*x1Max, 2*x1Max];
ySurface = [y1 y1];
plot(x0,y0,'*')     % Mark the point source
axis([xSurface(1), xSurface(2), y2, y0]);
xlabel('x');  ylabel('y');
title(sprintf('Indicies of refraction are %g (top) and %g (bottom)', ...
                                       nIndexI,nIndexR));
hold on;  % Hold the graph so rays may be drawn
plot(xSurface,ySurface,'r--','EraseMode','none');  % Draw surface
drawnow;

%@ Loop over the number of rays to draw
NRays = 20;            % Number of rays to draw
for iRay=1:NRays

  %@ First point of ray is at light source
  xRay(1) = x0;  yRay(1) = y0;        % First point
  
  %@ Second point of ray is on the surface
  x1 = -x1Max + (iRay-1)/(NRays-1)*(2*x1Max);
  xRay(2) = x1;  yRay(2) = y1;        % Second point
  
  %@ Compute location of third point using Snell's law
  ThetaI = atan( (x0-x1)/(y0-y1) );   % Incident angle
  % Refraction angle (Snell's law)
  ThetaR = asin( nIndexI/nIndexR * sin(ThetaI) );
  x2 = (y2-y1)*tan(ThetaR) + x1;
  xRay(3) = x2;  yRay(3) = y2;        % Third point
  
  %@ Plot the ray using the three points
  plot(xRay,yRay,'-','EraseMode','none');
  drawnow;
  
end
hold off;
