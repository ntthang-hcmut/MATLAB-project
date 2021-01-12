% shuffle - Simulation of two dimensional shuffling
clear; help shuffle;  % Clear memory; print header

%@ Initialize variables
NSide = input('Enter the number of sites on a side: ');
NSites = NSide*NSide;      % Total number of sites
% Assign half the sites to have value 1 ('up')
for i=1:NSide
  for j=1:(NSide/2)
    Site(i,j) = 1;
  end
end
% Assign the other half to have value 0 ('down')
for i=1:NSide
  for j=(NSide/2 + 1):NSide
    Site(i,j) = 0;
  end
end
NRounds = input('Enter the number of rounds: ');
NShuffle = input('Enter number of site shuffles per round: ');
epsilon = 1e-100;   % Small value used to avoid log(0) problems

%@ Prepare for plotting; plot the initial state
clf;  figure(gcf);           % Clear figure; bring window forward
image(Site+1);               % Plot values as an image (adding offset of 1)
axis('ij');  axis('square'); % Set up axis parameters
colormap(hot(3));            % Color map used by image
title('Initial state, Disorder = 0');
drawnow;

%@ Loop over the desired number of rounds of shuffling
for iRound=1:NRounds

  %@ Loop over the number of shuffles for this round
  for iShuffle=1:NShuffle
    %@ Select two site at random
    iSite1 = ceil(rand(1)*NSide);   % Index i of first site
	jSite1 = ceil(rand(1)*NSide);   % Index j of first site
    iSite2 = ceil(rand(1)*NSide);   % Index i of second site
	jSite2 = ceil(rand(1)*NSide);   % Index j of second site
	%@ Exchange the values at the two sites
	Copy1 = Site(iSite1,jSite1);
	Site(iSite1,jSite1) = Site(iSite2,jSite2);
	Site(iSite2,jSite2) = Copy1;
  end
  
  %@ Sum over the columns to compute disorder
  Disorder(iRound) = 0.0;
  for j=1:NSide
    TotalUp = 0.0;
	%@ Sum within a column to find fraction of sites that are up
	for i=1:NSide
	  TotalUp = TotalUp + Site(i,j);  % Running tally of up sites
	end
	FractionUp = TotalUp/NSide;       % Fraction up in this column
	%@ Compute disorder as sum of f*log(f) 
	%  Add epsilon in logarithm to avoid problems with log(0)
	Disorder(iRound) = Disorder(iRound) ...
	                 - FractionUp*log(FractionUp + epsilon);
  end
  TotalShuffles(iRound) = iRound*NShuffle;  % Record total shuffles for plot
  
  %@ Plot a tableau showing the sites and display the disorder
  image(Site+1);   % Plot values as an image (adding offset of 1 for colors)
  axis('ij');  axis('square'); % Set up axis parameters
  title(sprintf('Round %g,  Disorder = %g',iRound,Disorder(iRound)));
  drawnow;

end

% Pause before continuing
text(NSide/3,NSide/2,'Strike any key to continue');
pause;

%@ Plot the disorder as a function total shuffles
clf; figure (gcf);   % Clear the figure; bring window forward
plot(TotalShuffles,Disorder,'*');
xlabel('Total Shuffles');
ylabel('Disorder');
