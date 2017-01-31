%% Parameter Sweep of ODEs
% This is a parameter sweep study of a 2nd order ODE system.
%
% $m\ddot{x} + b\dot{x} + kx = 0$
%
% We solve the ODE for a time span of 0 to 25 seconds, with initial
% conditions $x(0) = 0$ and $\dot{x}(0) = 1$. We sweep the parameters $b$
% and $k$ and record the peak values of $x$ for each condition. At the end,
% we plot a surface of the results.
%
% Copyright 2009-2011 The MathWorks, Inc.

%% Initialize Problem
m     =                    5;  % mass
bVals = linspace(0.1, 5, 50);  % damping values
kVals = linspace(1.5, 5, 70);  % stiffness values
[bGrid, kGrid] = meshgrid(bVals, kVals);
peakVals = nan(size(kGrid));

%% Parameter Sweep (Serial)
% We'll first do the parameter sweep computation in a serial |for| loop.

disp('Computing in serial...');drawnow;

tic;
for idx = 1:numel(kGrid)
  % Solve ODE
  [T,Y] = ode45(@(t,y) odesystem(t, y, m, bGrid(idx), kGrid(idx)), ...
    [0, 25], ...  % simulate for 25 seconds
    [0, 1]) ;      % initial conditions
 
  % Determine peak value
  peakVals(idx) = max(Y(:,1));
end
t1 = toc;
fprintf('Elapsed time is %0.2f seconds.\n', t1);

%% Parameter Sweep (Parallel)
% Next, we convert the |for| loop to a |parfor| loop and start a pool or
% MATLAB workers.

disp('Computing in parallel...');drawnow;

%matlabpool open
p = gcp('nocreate');
if(isempty(p))
    p = parpool('local',4);
end

tic;
parfor idx = 1:numel(kGrid)
  % Solve ODE
  [T,Y] = ode45(@(t,y) odesystem(t, y, m, bGrid(idx), kGrid(idx)), ...
    [0, 25], ...  % simulate for 25 seconds
    [0, 1]) ;      % initial conditions
 
  % Determine peak value
  peakVals(idx) = max(Y(:,1));
end
t2 = toc;
fprintf('Elapsed time is %0.2f seconds.\n', t2);

% Close MATLAB Pool
delete(p);

%% Visualize

figure;
surf(bVals, kVals, peakVals);
xlabel('Damping (b)');
ylabel('Stiffness (k)');
zlabel('Peak Response');
view(50, 30)

%% Speed Up
% We can see that we get a very good speed up. Since this loop has very
% minimal overhead in terms of data transfer, we may see a super-linear
% speed up, which sometimes happens due to the Just In Time acceleration.

fprintf('\n\nSpeed up (time serial / time parallel): %0.2f\n', t1/t2);
