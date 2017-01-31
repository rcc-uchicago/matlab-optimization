function [x,fval,exitflag,output,lambda,grad,hessian] = myOptim(x0,lb,ub,dimensions,varargin)
% This is an auto generated M-file to do optimization with the Optimization Toolbox.
% Optimization Toolbox is required to run this M-file.

% Copyright 2006-2013 The MathWorks, Inc.

% See if parallel option is set

if nargin > 4
    parallel = varargin{1};
else
    parallel = 0;  % default is to run in serial
end

% Start with the default options
options = optimset;

% Modify options setting
options = optimset(options,'Display' ,'none');
options = optimset(options,'TolFun' ,0.01);
options = optimset(options,'OutputFcn' ,{ @helper.myOutputFcn });
options = optimset(options,'PlotFcns' ,{  @optimplotfval @(x,itervals,flag) helper.plotFcn(x,itervals,flag,dimensions) });
options = optimset(options,'LargeScale' ,'off');

if parallel == 1
    options = optimset(options,'UseParallel','always');
else
    options = optimset(options,'UseParallel','never');
end

options = optimset(options,'Algorithm', 'active-set');

[x,fval,exitflag,output,lambda,grad,hessian] = ...
  fmincon(@(x) helper.objFcn(x,dimensions.R),x0,[],[],[],[],lb,ub,[],options);
% Copyright 2015 The MathWorks, Inc.
