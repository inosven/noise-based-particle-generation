fv=stlread('Sphere_L6.stl');
% rng(10)
m=60; eta=1; f=3; n=1; q=0.5; N=5;
[x,y,z]=G3D_fractal(fv.vertices,m,n,f,eta,q,N);
vertices = [x y z];

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

function [x, y, z] =G3D_fractal(vertices,m,n,f,scalar,q,t)
s = zeros([m,m,m]);
[X,Y,Z] = meshgrid(-1:2/(m-1):1);
for i=0:t
    f=f+i;
%     s0=Worleynoise3D(m,n,f);
    s0=Valuenoise3D(m,f);
%     s0=Perlinnoise3D(m,f);
    s=s+s0*q^i;
end
xoff = vertices(:,1);
yoff = vertices(:,2);
zoff = vertices(:,3);
Vq=interp3(X,Y,Z,s,xoff,yoff,zoff);
[az,el,rho] = cart2sph(xoff,yoff,zoff);
r = rho+Vq*scalar;
x = cos(el).*cos(az).*r;
y = cos(el).*sin(az).*r;
z= (sin(el)).*r;
end