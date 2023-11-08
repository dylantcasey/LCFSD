function p = FD_fit(x,y)
% log transforms data and then does a linear fit. Equivalent to a power law
% fit, which will give us the fractal dimension.
%
%INPUTS 
%   x == vector of box side lengths. min(x)=3
%   y == vector of neighborhood size for respective x
%
%OUTPUTS
%   p == 3x1 matrix with the structure [slope, intercept, r^2]. The first
%           entry is equivalent to the fractal dimension
%  
%%

%initialize
n=length(x);
p=zeros(3,1);

%logify
x_log = log10(x);
y_log = log10(y);
% linear fitting
[f,S]=polyfit(x_log,y_log,1); 
% calculated R^2
R_adj = 1 - (n-1)/(n-2)*(S.normr/norm(y_log - mean(y_log)))^2;
% package up values to return
p(1:2) = f;
p(3) = R_adj;

end