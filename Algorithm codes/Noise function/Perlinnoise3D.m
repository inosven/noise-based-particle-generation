function s=Perlinnoise3D(m, f)
[Gx,Gy,Gz]=gradient3D(f+2,f+2,f+2);% Three random gradient matrices are generated, each of size (f+2) x (f+2) x (f+2).
s=zeros(m,m,m);% A zero matrix s of size m x m x m is initialized to store the noise values.
for x=1:m
    for y=1:m
        for z=1:m
            % Calculate the actual noise coordinates.
            rx=f*x/m;
            ry=f*y/m;
            rz=f*z/m;  
            % Calculate the integer part of each dimension.
            x0=floor(rx);
            y0=floor(ry);
            z0=floor(rz);
            % Calculate the fractional part of each dimension.
            dx=rx-x0;
            dy=ry-y0;
            dz=rz-z0;          
            % Calculate the noise value at each corner point
            n000=dot([Gx(z0 + 1, y0 + 1, x0 + 1) Gy(z0 + 1, y0 + 1, x0 + 1) Gz(z0 + 1, y0 + 1, x0 + 1)], [dx, dy, dz]);
            n100=dot([Gx(z0 + 1, y0 + 1, x0 + 2) Gy(z0 + 1, y0 + 1, x0 + 2) Gz(z0 + 1, y0 + 1, x0 + 2)], [dx - 1, dy, dz]);
            n010=dot([Gx(z0 + 1, y0 + 2, x0 + 1) Gy(z0 + 1, y0 + 2, x0 + 1) Gz(z0 + 1, y0 + 2, x0 + 1)], [dx, dy - 1, dz]);
            n110=dot([Gx(z0 + 1, y0 + 2, x0 + 2) Gy(z0 + 1, y0 + 2, x0 + 2) Gz(z0 + 1, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz]);
            n001=dot([Gx(z0 + 2, y0 + 1, x0 + 1) Gy(z0 + 2, y0 + 1, x0 + 1) Gz(z0 + 2, y0 + 1, x0 + 1)], [dx, dy, dz - 1]);
            n101=dot([Gx(z0 + 2, y0 + 1, x0 + 2) Gy(z0 + 2, y0 + 1, x0 + 2) Gz(z0 + 2, y0 + 1, x0 + 2)], [dx - 1, dy, dz - 1]);
            n011=dot([Gx(z0 + 2, y0 + 2, x0 + 1) Gy(z0 + 2, y0 + 2, x0 + 1) Gz(z0 + 2, y0 + 2, x0 + 1)], [dx, dy - 1, dz - 1]);
            n111=dot([Gx(z0 + 2, y0 + 2, x0 + 2) Gy(z0 + 2, y0 + 2, x0 + 2) Gz(z0 + 2, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz - 1]);
            % Use the lerp function to perform linear interpolation in each dimension.
            n00=lerp(n000, n100, dx);
            n01=lerp(n001, n101, dx);
            n10=lerp(n010, n110, dx);
            n11=lerp(n011, n111, dx);

            n0=lerp(n00, n10, dy);
            n1=lerp(n01, n11, dy);
            % Get the finally Perlin noise value.
            s(y, x, z)=lerp(n0, n1, dz);
        end
    end
end
% Normalize the noise matrix s so that its value range is between [0,1].
s = (s - min(s(:))) / (max(s(:)) - min(s(:)));
end
% Apply a smoothing function to make the interpolation smoother.
function u=lerp(a, b, t)
t=t^3*(t*(t*6-15)+10);
u=(1-t)*a+t*b;
end
% Function randxyzmat generates three random gradient matrices.
function [Gx,Gy,Gz]=gradient3D(Lx,Ly,Lz)
    % Total number of gradients
    num=Lx*Ly*Lz;
    % Preallocate arrays for the gradients
    Gx=zeros(Lz, Ly, Lx);
    Gy=zeros(Lz, Ly, Lx);
    Gz=zeros(Lz, Ly, Lx);
    % Generate random azimuth angles (0 to 2*pi)
    azimuth=2*pi*rand(num, 1);
    % Generate random polar angles (0 to pi)
    polar=pi*rand(num, 1);
    % Generate random radii (0 to 1)
    r=sqrt(rand(num, 1)); 
    % Convert spherical coordinates (r, polar, azimuth) to Cartesian coordinates (Gx, Gy, Gz)
    Gx(:)=r.*sin(polar).*cos(azimuth);   % X component of gradients
    Gy(:)=r.*sin(polar).*sin(azimuth);   % Y component of gradients
    Gz(:)=r.*cos(polar);                   % Z component of gradients
end