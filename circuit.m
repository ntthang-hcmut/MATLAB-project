% circuit - Program to solve a simple circuit problem
%           shown in Fig. 28-9 and Ex. 28-5 of the textbook
clear; help circuit;  % Clear memory; print header

%@ Initialize variables (e.g., resistances, voltages)
fprintf('Enter resistances as [R(1), R(2), R(3)]\n');
R = input(': ');
E = input('Enter voltages as [E(1), E(2)]: ');

%@ Set up the matrix A on the left hand side
A = [ -1, 1, 1;   R(1),  R(2), 0;    0, -R(2), R(3)];
	   
%@ Set up the vector b on the right hand side
b = [  0;  E(1);  E(2)];
	  
%@ Solve for currents I where A*I = b
I = A\b;   % Use the MATLAB backslash operator

%@ Display currents
fprintf('Currents are \n');
for j=1:3
  fprintf('I(%g) = %g \n',j,I(j));
end

  
