% decay - Simulation of radioactive decay
clear; help decay;  % Clear memory; print header

%@ Initialize variables (e.g., decay probability, number of atoms)
NRow = 30;                 % Number of rows of atoms
NCol = 50;                 % Number of columns of atoms
Atom = ones(NRow,NCol);    % Fill array of atoms with ones
NAtoms = NRow*NCol;		   % Number of atoms
NActive = NAtoms;          % Number of undecayed atoms
ProbDecay = input('Enter probability of a decay per year: ');
NYears = input('Enter the number of years: ');

%@ Prepare for plotting; plot the initial state
clf;  figure(gcf);          % Clear figure; bring window forward
image(Atom+1);              % Plot values as an image (adding offset of 1)
axis('ij');                 % Set up axis parameters
colormap(hot(3));           % Color map used by image
title('Initial state');
drawnow;

%@ Loop over the desired number of years
for iYear=1:NYears
  
  %@ Loop over all atoms
  for i=1:NRow
   for j=1:NCol
 
     %@ Generate array of random numbers between 0 and 1
     RandomNumber = rand(1); 
	 
	 %@ If RandomNumber < ProbDecay, atom decays
     if( RandomNumber < ProbDecay )
	   Atom(i,j) = 0;
	 end
	 
   end
  end
  
  %@ Count the number of active atoms
  NActive = sum(sum(Atom));
    
  %@ Plot a tableau showing the sites and their values
  image(Atom+1);               % Plot values as an image (adding offset of 1)
  axis('ij');                  % Set up axis parameters
  title(sprintf('Year %g      %g Active %g Decayed', ...
                iYear,NActive,NAtoms-NActive));
  drawnow;
  
  %@ If all atoms have decayed, don't continue
  if( NActive == 0 )
    break;           % Program stops if all atoms have decayed
  end
end
