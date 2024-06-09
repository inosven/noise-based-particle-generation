% % This MATLAB code is used to generate 2D particle shapes based on 2D nosie algorithms.

% % Using a circle as the base geometry.
center = [0,0];% Initialize the center of the circle.
radius = 1;% Set the radius of the circle, default is 1
% % Create a linear space from 0 to 2π for generating points on the circle.
% % These points divide the circle evenly.
theta =linspace(0,2*pi,1000);
% % Get the coordinates of the points on the circle.
x0=radius*cos(theta)';
y0= radius*sin(theta)';
vertices=[x0 y0];% Coordinates of points on a 2D particle shape.

% % Parameters for 2D noise-based particle generation:
% m: the number of pixel points in each dimension of the square (length, and width) noise space.
% n: the number of feature points in each cell (only in Worley noise).
% f: the square noise space is partitioned into f × f cells, with f cells along each dimension respectively.
% eta: the degree of influence exerted by the noise algorithms.

m=60; f=3; n=1; eta=1;
[x,y]=generation_2D(vertices,m,n,f,eta);

% % Visualization of generated 2D particle shape.
figure
plot(x,y,'LineWidth',1.25,'color','r');
axis image
xlim([-2,2])
ylim([-2,2])
xticks([-2 -1 0 1 2])
yticks([-2 -1 0 1 2])
set(gca,'LineWidth',1);
set(gca, 'FontSize', 20,'FontName', 'Times');

function [x,y]=generation_2D(vertices,m,n,f,weights)
s = zeros(m);
[X,Y] = meshgrid(-1:2/(m-1):1);

% % Value noise-based algorithm for 2D particle generation.
% % Other noise algorithms can be used for 2D particle generation.
% % For example, here you can replace Valuenoise2D(m,f) with Perlinnoise2D(m,f).
% s=Worleynoise2D(m,n,f);
% s=Perlinnoise2D(m,f);
s=Valuenoise2D(m,f);

% % Noise value affects particle vertex coordinates.
xoff = vertices(:,1);
yoff = vertices(:,2);
Vq=interp2(X,Y,s,xoff,yoff);
    [theta,rho] = cart2pol(xoff,yoff);
    r = Vq*weights+rho;
    x = cos(theta).*r;
    y = sin(theta).*r;
end