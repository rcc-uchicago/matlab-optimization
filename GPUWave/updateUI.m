function updateUI(xx, yy, vv, vvold, n, N, hTopAxes, hBottomAxes, ...
    hIterationText, hElapsedTimeText, ticT)
% Copyright 2015 The MathWorks, Inc.

persistent sh sh2 xxx yyy

if n == 1  % initialization
    [xxx,yyy] = meshgrid(-1:1/16:1,-1:1/16:1); % grid for plotting
    ylim = 5e4*10^-(log2(N)); %ylim = 0.0002;
    
    sh  = surf(hTopAxes , xxx, yyy, zeros(size(xxx)));
    sh2 = surf(hBottomAxes, xxx, yyy, zeros(size(xxx)));
    axis(hTopAxes , [-1 1 -1 1 -0.1 1]);
    axis(hBottomAxes, [-1 1 -1 1 -ylim ylim]);
    
    caxis(hTopAxes, [-0.5 0.5]);
    caxis(hBottomAxes, [-ylim/5 ylim/5]);
end

vvv = interp2(xx,yy,vv,xxx,yyy);
vvvdiff = interp2(xx,yy,vv-vvold,xxx,yyy);
set(sh, 'ZData', vvv)
set(sh2, 'ZData', vvvdiff)

set(hIterationText,'String',num2str(n));
set(hElapsedTimeText, 'String', sprintf('Elapsed Time: %s', elapsedTimeDisplay(toc(ticT))));

drawnow;
