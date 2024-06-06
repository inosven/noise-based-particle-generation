% % This MATLAB code is used to generate 3D realistic particles based on a scanned particle using noise superposition.

fv=stlread('Quartz sand.stl');% Using a scanned soil particle as the base geometry (a quartz sand particle).

% % Normalize the scanned particle size.
centeredVertices=fv.vertices-mean(fv.vertices);
scaleFactor=1/(max(max(abs(centeredVertices))));
fv.vertices=centeredVertices*scaleFactor;

% % The following line is commented out. 
% % It sets the seed for the random number generator to ensure repeatability of results.
% rng(22)

% % Parameters for particle generation by noise superposition method:
% m: the number of pixel points in each dimension of the cubic (length, width, and height) noise space.
% n: the number of feature points in each cell (only in Worley noise).
% f: the cubic noise space is partitioned into f × f × f cells, with f cells along each dimension respectively.
% eta: the degree of influence exerted by the noise algorithms.
% q: decay factor for fractal noise.
% N: number of fractal iterations (number of superimposed high-frequency noise).

m=60; eta=1; f=2; n=1; q=0.5; N=5;
[x,y,z]=G3D_fractal_scanned(fv.vertices,m,n,f,eta,q,N);
vertices = [x y z];% Vertex coordinates of the triangular mesh vertices of the generated particles.

% % Visualization of generated particles.
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

function [x, y, z] =G3D_fractal_scanned(vertices,m,n,f,scalar,q,t)
s = zeros([m,m,m]);
[X,Y,Z] = meshgrid(-1:2/(m-1):1);
% % Noise superposition.
for i=0:t
    f=f+i;% The frequency increment strategy.

    % % Noise superposition based on Value noise algorithm to generate particles.
    % % Other noise algorithms can be used for noise superposition.
    % % For example, here you can replace Valuenoise3D(m,f) with Perlinnoise3D(m,f).

%     s0=Worleynoise3D(m,n,f);
    s0=Valuenoise3D(m,f);
%     s0=Perlinnoise3D(m,f);
    s=s+s0*q^i;
end
xoff = vertices(:,1);
yoff = vertices(:,2);
zoff = vertices(:,3);

% % Noise value affects particle vertex coordinates.
Vq=interp3(X,Y,Z,s,xoff,yoff,zoff);
[az,el,rho] = cart2sph(xoff,yoff,zoff);
r = rho+Vq*scalar.*(rho/max(rho));% The radius weights likewise affect the degree of influence exerted by the noise algorithms.
x = cos(el).*cos(az).*r;
y = cos(el).*sin(az).*r;
z= (sin(el)).*r;
end