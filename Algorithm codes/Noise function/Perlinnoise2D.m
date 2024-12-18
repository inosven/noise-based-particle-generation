function s=Perlinnoise2D(m,f)
[Gx,Gy]=gradient(f+2,f+2);% [uxmat,uymat] are the random gradient matrices, sized (f+2) x (f+2).
s=zeros(m,m);% Initialize a zero matrix s of size m x m to store the noise values.
for x=1:m
    for y=1:m
        % Calculate the actual noise coordinates.
        rx=f*x/m;
        ry=f*y/m;
        % Calculate the integer part of each dimension.
        x0=floor(rx);
        y0=floor(ry);
        % Calculate the fractional part of each dimension.
        dx=rx-x0;
        dy=ry-y0;
        % Calculate the noise value at each corner point
        n00=dot([Gx(y0 + 1, x0 + 1) Gy(y0 + 1, x0 + 1)], [dx, dy]);
        n10=dot([Gx(y0 + 1, x0 + 2) Gy(y0 + 1, x0 + 2)], [dx - 1, dy]);
        n01=dot([Gx(y0 + 2, x0 + 1) Gy(y0 + 2, x0 + 1)], [dx, dy - 1]);
        n11=dot([Gx(y0 + 2, x0 + 2) Gy(y0 + 2, x0 + 2)], [dx - 1, dy - 1]);
        % Use the lerp function to perform linear interpolation in each dimension.
        n0=lerp(n00, n10, dx);
        n1=lerp(n01, n11, dx);
        % Get the final noise value.
        s(y,x)=lerp(n0, n1, dy);
    end
end

% Normalize the noise matrix s so that its value range is between [0,1].
s=(s - min(s(:))) / (max(s(:)) - min(s(:)));
end
% Apply a smoothing function to make the interpolation smoother.
function u=lerp(a,b,t)
    t=t^3*(t*(t*6-15)+10);
    u=(1-t)*a+t*b;
end
% Function randxymat generates random gradient matrices.
function [Gx,Gy]=gradient(Lx,Ly)
    num=Lx*Ly;
    Gx=zeros(Ly,Lx);
    Gy=zeros(Ly,Lx);
    % Generate random vectors in the unit circle using polar coordinates
    theta=2*pi*rand(num, 1);  % Random angles
    r=sqrt(rand(num, 1));         % Random radii (uniform distribution in unit circle)    
    % Convert polar to Cartesian coordinates
    Gx(:)=r.*cos(theta);        % X component of gradients
    Gy(:)=r.*sin(theta);        % Y component of gradients
end