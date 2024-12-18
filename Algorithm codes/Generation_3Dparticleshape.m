% % This MATLAB code is used to generate 3D particle shapes based on 3D nosie algorithms.

fv=stlread('Sphere_L6.stl');% Using a sphere as the base geometry.
% % The following line is commented out. 
% % It sets the seed for the random number generator to ensure repeatability of results.
% rng(22)

% % Parameters for 3D noise-based particle generation:
% m: the number of pixel points in each dimension of the cubic (length, width, and height) noise space.
% n: the number of feature points in each cell (only in Worley noise).
% f: the cubic noise space is partitioned into f × f × f cells, with f cells along each dimension respectively.
% eta: the degree of influence exerted by the noise algorithms.

m=60; f=2; n=1; eta=1;
[x,y,z]=generation_3D(fv.vertices,m,n,f,eta);
vertices = [x y z];% Vertex coordinates of the triangular mesh vertices of the generated particles.

% % Visualization of generated 3D particle shape.
% Use the patch function to create a 3D graphic
figure
fcolor=[0.69 0.608 0.518];
h = patch('faces', fv.faces, 'vertices',vertices,'FaceColor',[0.69 0.608 0.518], ...
    'EdgeColor',       'none',        ...
    'FaceLighting',    'gouraud',     ...   %flat gouraud
    'EdgeLighting',  'gouraud',     ...   %flat gouraud
    'FaceAlpha', 1,...
    'Clipping', 'off');
light('Position',[ 1  0 0],'Style','infinite', 'Color', fcolor);
light('Position',[-1  0 0],'Style','infinite', 'Color', fcolor);
light('Position',[ 0  1 0],'Style','infinite', 'Color', fcolor);
light('Position',[ 0 -1 0],'Style','infinite', 'Color', fcolor);
lighting flat ;
% lighting none ;
lighting gouraud ;
axis image
xlim([-2 2])
ylim([-2 2])
zlim([-2 2])
xlabel('X(mm)','FontName', 'Times', 'FontSize', 18);
ylabel('Y(mm)','FontName', 'Times', 'FontSize', 18);
zlabel('Z(mm)','FontName', 'Times', 'FontSize', 18);
set(gca,'LineWidth',1);
set(gca, 'FontSize', 18,'FontName', 'Times');
grid on
view(3);

function [x, y, z] =generation_3D(vertices,m,n,f,scalar)
s = zeros([m,m,m]);
[X,Y,Z] = meshgrid(-1:2/(m-1):1);

% % Value noise-based algorithm for 3D particle generation.
% % Other noise algorithms can be used for 3D particle generation.
% % For example, here you can replace Valuenoise3D(m,f) with Perlinnoise3D(m,f).
s=Worleynoise3D(m,n,f);
% s=Perlinnoise3D(m,f);
% s=Valuenoise3D(m,f);

xoff = vertices(:,1);
yoff = vertices(:,2);
zoff = vertices(:,3);

% % Noise value affects particle vertex coordinates.
Vq=interp3(X,Y,Z,s,xoff,yoff,zoff);
[az,el,rho] = cart2sph(xoff,yoff,zoff);
r = rho+Vq*scalar;
x = cos(el).*cos(az).*r;
y = cos(el).*sin(az).*r;
z= (sin(el)).*r;
end