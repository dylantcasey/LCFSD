function p = LCFSD(Z)
%function takes a square subsection and breaks it into nesting boxes to 
% calculate the neighborhood. Sends neighborhood size and box size to be 
% log-log fit and returns the fractal dimension.
%
%INPUTS 
%   Z == hxh sub-matrix  of an image with 0's in empty space and
%           postive values elsewhere
%
%OUTPUTS
%   p == 3x1 matrix wwith the structure [slope, intercept, r^2]. The first
%           entry is equivalent to the fractal dimension
%  
%%

% get parameters back
h=length(Z);
c=(h+1)/2;
%initialize
x=3:2:h; %box sizes
y=zeros(length(x),1);

% loops through each box size
for i=1:length(x)
    % side length
    s=(x(i)-1)/2;
    % get the planar sub-subsection
    box=Z(c-s:c+s,c-s:c+s);
    % cap the height of each point at x(i)
    box(box>x(i))=x(i);
    % sum the neighborhood
    y(i)= sum(box(:));
end
% fit that pixel's scaling
p = FD_fit(x, y);
end