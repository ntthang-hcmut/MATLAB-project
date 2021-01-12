% chrgrod - Compute electric field for a charged rod
clear all; help chrgrod;  % Clear memory; print header

%@ Initialize variables (e.g., charge density, rod size)
LRod = 1;                      % Length of the rod is 2*LRod (m)
fprintf('Rod extends between y= %g and %g m\n', -LRod, LRod);
Lambda = 1.0;                  % Charge density of rod (C/m)
epsilon0 = 8.85e-12;           % Permittivity of free space
NMeasure = 25;                 % Number of points to measure
xObsMax = 5.0*LRod;            % Maximum x value for xObsPoint
DeltaX = xObsMax/NMeasure;     % Increment for x values
yObsPoint = input('Enter y distance from center (m): ');
NPieces = 100;                 % Number of pieces used in summation
DeltaY = 2*LRod/NPieces;       % Size of rod pieces
for iPiece=1:NPieces
  yRod(iPiece) = -LRod + iPiece*DeltaY; % Location of pieces
end
xObsPoint = DeltaX;            % x coordinate of observation point

%@ Loop over the observation points
for iMeasure=1:NMeasure
  fprintf('Computing field at x = %g m \n',xObsPoint);
  
  %@ Compute summation to find x-component of electric field
  RunSum = 0;  % Set running sum to zero
  for iPiece=1:NPieces   % Sum over pieces
    RunSum = RunSum + DeltaY*xObsPoint/   ...
    sqrt( (yObsPoint-yRod(iPiece))^2 + xObsPoint^2 )^3;
  end
  % Estimated x-component of the electric field
  Ex(iMeasure) = Lambda/(4*pi*epsilon0) * RunSum;
  
  %@ Compute theoretical x-component of electric field for y=0
  ExTheory(iMeasure) = Lambda/(2*pi*epsilon0) * ...
    LRod/(xObsPoint*sqrt(LRod^2 + xObsPoint^2));
	
  %@ Record location of observation point; go to next point
  xObsPlot(iMeasure) = xObsPoint;  % Record for plot
  xObsPoint = xObsPoint + DeltaX;  % Increment xObsPoint
  
end

%@ Plot electric field using semilog graph
clf;  figure(gcf);   % Clear figure; bring figure window forward
semilogy(xObsPlot,Ex,'*',xObsPlot,ExTheory,'-');
xlabel( sprintf('x (m)          y = %g m',yObsPoint) );  
ylabel('Electric field; x-component (N/C)');
title('Points are computed; solid line is field at y = 0');

