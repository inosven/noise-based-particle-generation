center = [0,0];
radius = 1;%defaut
theta =linspace(0,2*pi,1000);
x0 = radius*cos(theta)';
y0= radius*sin(theta)';
vertices = [x0 y0];

m = 60; f = 2; n = 1; eta = 1;
[x,y]=generation_2D(vertices,m,n,f,eta);
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

% s=Worleynoise2D(m,n,f);
% s=Perlinnoise2D(m,f);
s=Valuenoise2D(m,f);

xoff = vertices(:,1);
yoff = vertices(:,2);
Vq=interp2(X,Y,s,xoff,yoff);
    [theta,rho] = cart2pol(xoff,yoff);
    r = Vq*weights+rho;
    x = cos(theta).*r;
    y = sin(theta).*r;
end