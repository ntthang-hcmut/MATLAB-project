% golf - Program to compute the time of flight and range 
%        of a golf ball using bisection search
clear all;    % Clear memory 
help golf;    % Print header

%@ Initialize position and velocity; desired final height
x0 = 0;  y0 = 0;         % Initial position (meters)
vMag = input('Enter initial speed (m/s): '); 
vDir = input('Enter initial angle (deg): ');
vDir = vDir * (pi/180);  % Convert to radians
vx0 = vMag*cos(vDir);    % Compute initial vx and vy 
vy0 = vMag*sin(vDir);    % from magnitude and angle
grav = 9.81;             % Gravitational acceleration (m/s^2)
yFinal = input('Enter desired value for final height (m): ');

%@ Enter initial guesses for times t_a and t_b
t_a = input('Enter time t_a (such that y(t_a) > yFinal): ');
t_b = input('Enter time t_b (such that y(t_b) < yFinal): ');

%@ Loop for 10 iterations 
for istep=1:10

  %@ Compute and display current values for y_a and y_b
  y_a = y0 + vy0*t_a - 1/2*grav*t_a^2;
  y_b = y0 + vy0*t_b - 1/2*grav*t_b^2;
  fprintf('y(%g) = %g,  y(%g) = %g \n',t_a,y_a,t_b,y_b);
  
  %@ Compute midpoint time t_c and height y_c
  t_c = (t_a + t_b)/2;
  y_c = y0 + vy0*t_c - 1/2*grav*t_c^2;
  
  if( y_c > yFinal )  
    %@ If y_c > yFinal, then replace t_a with t_c
    t_a = t_c;
  else
    %@ Else replace t_b with t_c
	t_b = t_c;
  end
end

%@ Print time of flight and horizontal range
fprintf('Final estimates are: \n');
fprintf('  Time of flight is %g seconds\n',t_c)
x_c = x0 + vx0*t_c;   % Horizontal position at time t_c
fprintf('  Maximum range is %g meters\n',x_c)
