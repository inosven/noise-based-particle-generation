function s=Perlinnoise3D(m, f)
[uxmat,uymat,uzmat]=randxyzmat(f+2,f+2,f+2);% Three random gradient matrices are generated, each of size (f+2) x (f+2) x (f+2).
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
            n000=dot([uxmat(z0 + 1, y0 + 1, x0 + 1) uymat(z0 + 1, y0 + 1, x0 + 1) uzmat(z0 + 1, y0 + 1, x0 + 1)], [dx, dy, dz]);
            n100=dot([uxmat(z0 + 1, y0 + 1, x0 + 2) uymat(z0 + 1, y0 + 1, x0 + 2) uzmat(z0 + 1, y0 + 1, x0 + 2)], [dx - 1, dy, dz]);
            n010=dot([uxmat(z0 + 1, y0 + 2, x0 + 1) uymat(z0 + 1, y0 + 2, x0 + 1) uzmat(z0 + 1, y0 + 2, x0 + 1)], [dx, dy - 1, dz]);
            n110=dot([uxmat(z0 + 1, y0 + 2, x0 + 2) uymat(z0 + 1, y0 + 2, x0 + 2) uzmat(z0 + 1, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz]);
            n001=dot([uxmat(z0 + 2, y0 + 1, x0 + 1) uymat(z0 + 2, y0 + 1, x0 + 1) uzmat(z0 + 2, y0 + 1, x0 + 1)], [dx, dy, dz - 1]);
            n101=dot([uxmat(z0 + 2, y0 + 1, x0 + 2) uymat(z0 + 2, y0 + 1, x0 + 2) uzmat(z0 + 2, y0 + 1, x0 + 2)], [dx - 1, dy, dz - 1]);
            n011=dot([uxmat(z0 + 2, y0 + 2, x0 + 1) uymat(z0 + 2, y0 + 2, x0 + 1) uzmat(z0 + 2, y0 + 2, x0 + 1)], [dx, dy - 1, dz - 1]);
            n111=dot([uxmat(z0 + 2, y0 + 2, x0 + 2) uymat(z0 + 2, y0 + 2, x0 + 2) uzmat(z0 + 2, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz - 1]);

            % Use the lerp function to perform linear interpolation in each dimension.
            n00=lerp(n000, n100, dx);
            n01=lerp(n001, n101, dx);
            n10=lerp(n010, n110, dx);
            n11=lerp(n011, n111, dx);

            n0=lerp(n00, n10, dy);
            n1=lerp(n01, n11, dy);

            % Get the finally noise value.
            s(y, x, z) = lerp(n0, n1, dz);
        end
    end
end
% Normalize the noise matrix s so that its value range is between [0,1].
s = (s - min(s(:))) / (max(s(:)) - min(s(:)));
end
% Apply a smoothing function to make the interpolation smoother.
function u = lerp(a, b, t)
t = t^3 * (t * (t * 6 - 15) + 10);
u = (1 - t) * a + t * b;
end
% Function randxyzmat generates three random gradient matrices.
function [uxmat, uymat, uzmat] = randxyzmat(numx, numy, numz)
uxmat = zeros(numz, numy, numx);
uymat = zeros(numz, numy, numx);
uzmat = zeros(numz, numy, numx);
for j = 1:numz * numy * numx
    k = 0;
    while k == 0
        randxyz = rand(1, 3);
        % Check if the random vector is within the unit sphere.
        if norm(randxyz - 0.5 * ones(1, 3)) <= 0.5
            k = k + 1;
            [indz, indy, indx] = ind2sub([numz, numy, numx], j);
            uxmat(indz, indy, indx) = randxyz(1);
            uymat(indz, indy, indx) = randxyz(2);
            uzmat(indz, indy, indx) = randxyz(3);
        end
    end
end
% Standardize the gradient matrices to the interval [-1,1].
uxmat = (uxmat - 0.5) * 2;
uymat = (uymat - 0.5) * 2;
uzmat = (uzmat - 0.5) * 2;
end

