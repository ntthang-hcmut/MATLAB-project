% mirror - Program to compute simple reflection from a
%          spherical convex mirror
clear all;  help mirror;   % Clear memory and print header

%@ Initialize variables (e.g., mirror radius, number of rays)
Radius = 10.0;         % Radius of the mirror
fprintf('Radius of the mirror is %g \n',Radius);
x0 = -Radius;          % X-coordinate of source rays
y0Max = input('Enter the max initial height of rays: ');
NRays = input('Enter the number of rays to draw: ');

%@ Set up for plotting rays
clf;  figure(gcf);    % Clear figure window and bring it forward
plot(0.0,0.0,'ro');   % Mark the origin
axis([-Radius, Radius, -Radius, Radius]);
axis('equal');        % Use square aspect ratio
xlabel('x');  ylabel('y');
title(sprintf('Spherical mirror; radius = %g',Radius));
hold on;

%@ Draw the mirror surface
NMirror = 100;
for i=1:NMirror
  yMirror(i) = -y0Max + (i-1)/(NMirror-1)*(2*y0Max);
  xMirror(i) = sqrt(Radius^2 - yMirror(i)^2);  
end
plot(xMirror,yMirror,'b--','Erasemode','none');
drawnow;

%@ Loop over the rays to be drawn
for iRay=1:NRays

  %@ Determine starting point of the ray
  y0 = -y0Max + (iRay-1)/(NRays-1)*(2*y0Max);
  xRay(1) = x0;  yRay(1) = y0;        % First point
  
  %@ Find the ray's point of intersection with the mirror
  y1 = y0;      % Ray enters horizontally
  x1 = sqrt(Radius^2 - y1^2);  
  xRay(2) = x1;  yRay(2) = y1;        % Second point
  
  %@ Compute incident and reflection angles (relative to x-axis)
  ThetaI = atan2(y1,x1);             
  ThetaR = 2*ThetaI;
  
  %@ Compute ray's final point back on vertical plane to the left
  x2 = x0;   
  y2 = (x2-x1)*tan(ThetaR) + y0;
  xRay(3) = x2;  yRay(3) = y2;        % Third point
  
  %@ Draw the ray using its three points
  plot(xRay,yRay,'-','EraseMode','none');
  drawnow;
  pause(1);  % Pause 1 second between rays

end
hold off;

