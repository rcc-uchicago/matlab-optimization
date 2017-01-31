function stop = plotFcn(x,itervals,flag, dimensions)

% plotFcn
%
% Plotting function for celltower problem.
% Plots the locations of cell towers.
%

% Copyright 2003-2013 The MathWorks, Inc.

% Get constants
R  = dimensions.R;
xL = dimensions.xL;
xU = dimensions.xU;
yL = dimensions.yL;
yU = dimensions.yU;

stop = false;

X = x(1:2:end, :);
Y = x(2:2:end, :);
N = length(R);

clrs=helper.myClrs;
Nclrs=size(clrs,1);

if isnumeric(itervals)
    iter = itervals;
else
    iter = itervals.iteration;
end


switch flag
    case {'iter', ''}
        
        t = 0:.1:2*pi+0.1;
        
        cla;
        for i = 1:N
            patch(R(i)*cos(t) + X(i), R(i)*sin(t) + Y(i), clrs(mod(i-1,Nclrs)+1,:), ...
                'FaceAlpha', 0.4, 'EdgeColor', [.2 .2 1]);
            text(X(i), Y(i), num2str(i), ...
                'horizontalalignment', 'center', ...
                'fontunits', 'normalized');
        end
        
        line([xL;xU;xU;xL;xL], [yL;yL;yU;yU;yL], ...
            'color', 'r', 'linestyle', '--', 'linewidth', 2);
        axis([xL-1, xU+1, yL-1, yU+1]);
        axis square;
        title(sprintf('Iteration: %d', iter));
        drawnow;
end

end
% Copyright 2015 The MathWorks, Inc.
