function [P, R] = LCFSD_img(Z, h, k)
%function takes an image and breaks every pixel into its hxh subsections
%and passes it to LCFSD to get the fractal dimension for that pixel. Cuts
%off borders.
%
%INPUTS 
%   Z == MxN matrix representation of an image with 0's in empty space and
%           postive values elsewhere
%   h == neighborhood parameter. The fractal dimension will be calculated
%           in an hxh pixel neighborhood of a chosen pixel with it at its 
%           center
%   k == (optional, default=5) the size of pixel clusters to be deleted. 
%           All pixel cluster k and smaller will be removed
%
%OUTPUTS
%   P == (M-h)x(N-h) matrix with the exact same structure as Z. Z values are
%           replaced with the respective pixel's fractal dimension
%   R == similar to P, but holds the r^2 values instead of frctal dimension
%           to check goodness-of-fit
%  
%%

% initialize output matrices and indices
p = 0*Z;
r = 0*Z;
s=(h-1)/2; % side length on either side of the center
c=s+1; % center index

% check for common errors
if ~mod(h,2)
    error('h must be odd')
end
if h<5
    error('h must be 5 or greater and odd')
end
if 2*c>length(Z)
    error('use a larger matrix or a smaller h')
end
if min(Z(:))<0
    error('Z must be a positive-valued matrix')
end
if nargin < 3
    k=5;
end

% remove small groups of pixels
Z = Z.*bwareaopen(Z,k,4);
% makes it discrete
Z=ceil(Z);

% W is used to select only the inner most pixels that the metric can be
% used for e.g. for center (1,1) there would be an artificial amount of
% zeros.
W=0*Z;
W(c:end-c+1,c:end-c+1)=1;
% get indicies of pixels
[u,v] = find(Z.*W);

% this loops through every valid pixel
l = length(v);
for i=1:l
    %cut out h neighborhood centered at pixel
    subsection = Z(u(i)-s:u(i)+s, v(i)-s:v(i)+s);
    % pass to calculate FD
    fd_sub = LCFSD(subsection);
    % insert in same location
    p(u(i),v(i)) = fd_sub(1);
    r(u(i),v(i)) = fd_sub(3);
end

% cut out the W locations to be returned
P=p(c:end-c+1, c:end-c+1);
R=r(c:end-c+1, c:end-c+1);

end