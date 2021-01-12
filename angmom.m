% angmom - Program to compute angular momentum vector 
%          given x(t) and y(t)
clear all;     % Clear memory
help angmom;   % Print header

%@ Enter displacement components x(t) and y(t)
fprintf('Enter x(t) as an equation; e.g., t*cos(t) \n');
x = input(': ','s');   % Read input as a text string
fprintf('Enter y(t) as a string; e.g., t*sin(t) \n');
y = input(': ','s');

%@ Compute components of the linear momentum (mass M=1)
%  Use symbolic manipulator to perform derivatives        
p_x = diff(x,'t');    % p_x = M dx/dt 
p_y = diff(y,'t');    % p_y = M dy/dt 

%@ Compute angular momentum (z-component), L_z = x*p_y - y*p_x
%  Notice that symop is used to perform this symbolic operation
L_z = symop(x, '*', p_y, '-', y, '*', p_x);
fprintf('Angular momentum (z-component) = \n');
disp(L_z);   % Display the symbolic expression for L_z

%@ Loop over points to evaluate x, y and L_z
NPoints = 100;
dt = 0.1;       % Time increment
for iPoint=1:NPoints

  %@ Evaluate x(t), y(t) and L_z(t) for plotting
  t = (iPoint-1)*dt; 
  tPlot(iPoint) = t;         % Record time for plot
  xPlot(iPoint) = eval(x);   % Record x(t) for plot
  yPlot(iPoint) = eval(y);   % Record y(t) for plot
  LPlot(iPoint) = eval(L_z); % Record L_z(t) for plot
  
end

%@ Plot trajectory and angular momentum versus time
clf;           % Clear graphics figure window
figure(gcf);   % Bring figure window forward
subplot(1,2,1)
  plot(xPlot,yPlot);
  xlabel('x');    
  ylabel('y');
  axis('equal');    % Make axis scales equal
subplot(1,2,2)
  plot(tPlot,LPlot);
  xlabel('Time');  
  ylabel('Ang. Momentum');
  axis('normal');   % Use normal (auto-scaling) axes


