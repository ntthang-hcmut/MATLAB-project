% lortran - Program to compute time and place of events in two
%           frames of reference using Lorentz transformations
clear all; help lortran;   % Clear memory; print header

%@ Initialize variables (e.g., speed of moving frame)
u = input('Enter velocity (as fraction of c): ');
gamma = 1/sqrt(1-u^2);
tMax = 10;     % In unprimed frame, time goes from 0 to tMax
xMax = tMax;   % In unprimed frame, events occur between -xMax and xMax

%@ Set up graphics for plotting the events
clf;  figure(gcf);    % Clear figure window and bring it forward
FirstChar = abs('a'); % First character for marking events is 'a'
subplot(2,1,1)  % First (top) plot in 2x1 tile of graphics
  axis([0, tMax, -xMax, xMax]);
  grid on;              % Place a hash grid on the graph
  xlabel('t (yr)');     % Horizontal axis label
  ylabel('x (lt-yr)');  % Vertical axis label
  title('Unprimed frame of reference');
  hold on;              % Hold the graph as events are added
subplot(2,1,2)  % Second (bottom) plot in 2x1 tile of graphics
  axis(2*gamma*[-tMax, tMax, -xMax, xMax]);
  grid on;              % Place a hash grid on the graph
  xlabel('t (yr)');     % Horizontal axis label
  ylabel('x (lt-yr)');  % Vertical axis label
  title('Primed frame of reference');
  hold on;              % Hold the graph as events are added

%@ Loop over desired number of events
NEvents = tMax+1;
for iEvent = 1:NEvents

  %@ Compute the time and place of event in unprimed frame
  x = (2*rand(1)-1)*xMax;           % Event occurs at random location
  t = (iEvent-1)/(NEvents-1)*tMax;  % Events uniformly spaced in time
  
  %@ Use Lorentz transformation to compute the time and place 
  %% of the same event in primed frame
  xp = gamma*(x - u*t);
  tp = gamma*(t - u*x);
  
  %@ Mark the event on the t-x graphs for each frame of reference
  EventName = setstr(iEvent-1+FirstChar);  % Event names are a,b,c,...
  subplot(2,1,1)  % Top plot (unprimed frame)
  h = text(t,x,EventName);  
  subplot(2,1,2)  % Bottom plot (primed frame)
  h = text(tp,xp,EventName);
  
end
drawnow;     % Draw the graphs

