% intern - Slit interference computed as N point interference
clear; help intern;  % Clear memory; print header

%@ Initialize variables (e.g., wavelength, width of slit, screen distance)
Lambda = input('Enter wavelength of the light (in nm): ');
Lambda = Lambda * 1e-9;  % Convert nm to meters
aWidth = input('Enter width of slit (in mm): ');
aWidth = aWidth * 0.001;  % Convert mm to meters
RScreen = input('Enter distance from slit to screen (in m): ');
yScreenMax = 3*Lambda*RScreen/aWidth;
Ny = 51;          % Number of points on the screen
yScreen = linspace(-yScreenMax,yScreenMax,Ny);
NPoints = 51;     % Number of points in the slit
yPoint = linspace(-aWidth/2,aWidth/2,NPoints);

%@ Set up graphics
clf;  figure(gcf);   % Clear the figure; bring figure window forward
axis([-yScreenMax, yScreenMax, 0.0, 1.0]);
xlabel('Position on screen (m)'); 
ylabel('Intensity (normalized by max)');
title('Intensity pattern on the screen (normalized)');
hold on;

%@ Loop over the locations on the screen
for j=1:Ny
 
 %@ Loop over the points in the slit
 SumCos = 0.;  SumSin = 0.;
 for k=1:NPoints
 
   %@ Compute distance from slit point to screen location
   L = sqrt( (yScreen(j)-yPoint(k))^2 + RScreen^2 );
   
   %@ Compute phase difference relative to center of screen
   Phi = 2*pi*(L-RScreen)/Lambda;
   
   %@ Update running sum of cummulative components
   SumCos = SumCos + cos(Phi); 
   SumSin = SumSin + sin(Phi);
 end
  
 %@ Find intensity on screen (normalized by max value);
 Intensity = (SumCos^2 + SumSin^2)/NPoints^2; 
 
 %@ Graph intensity versus position on screen
 plot(yScreen(j),Intensity,'*','EraseMode','none');
 drawnow;
 
end
