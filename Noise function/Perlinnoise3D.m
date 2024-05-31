function s = Perlinnoise3D(m, f)
[uxmat, uymat, uzmat] = randxyzmat(f + 2, f + 2, f + 2);
s = zeros(m, m, m);
for x = 1:m
    for y = 1:m
        for z = 1:m
            rx = f * x / m;
            ry = f * y / m;
            rz = f * z / m;

            x0 = floor(rx);
            y0 = floor(ry);
            z0 = floor(rz);

            dx = rx - x0;
            dy = ry - y0;
            dz = rz - z0;

           
            n000 = dot([uxmat(z0 + 1, y0 + 1, x0 + 1) uymat(z0 + 1, y0 + 1, x0 + 1) uzmat(z0 + 1, y0 + 1, x0 + 1)], [dx, dy, dz]);
            n100 = dot([uxmat(z0 + 1, y0 + 1, x0 + 2) uymat(z0 + 1, y0 + 1, x0 + 2) uzmat(z0 + 1, y0 + 1, x0 + 2)], [dx - 1, dy, dz]);
            n010 = dot([uxmat(z0 + 1, y0 + 2, x0 + 1) uymat(z0 + 1, y0 + 2, x0 + 1) uzmat(z0 + 1, y0 + 2, x0 + 1)], [dx, dy - 1, dz]);
            n110 = dot([uxmat(z0 + 1, y0 + 2, x0 + 2) uymat(z0 + 1, y0 + 2, x0 + 2) uzmat(z0 + 1, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz]);
            n001 = dot([uxmat(z0 + 2, y0 + 1, x0 + 1) uymat(z0 + 2, y0 + 1, x0 + 1) uzmat(z0 + 2, y0 + 1, x0 + 1)], [dx, dy, dz - 1]);
            n101 = dot([uxmat(z0 + 2, y0 + 1, x0 + 2) uymat(z0 + 2, y0 + 1, x0 + 2) uzmat(z0 + 2, y0 + 1, x0 + 2)], [dx - 1, dy, dz - 1]);
            n011 = dot([uxmat(z0 + 2, y0 + 2, x0 + 1) uymat(z0 + 2, y0 + 2, x0 + 1) uzmat(z0 + 2, y0 + 2, x0 + 1)], [dx, dy - 1, dz - 1]);
            n111 = dot([uxmat(z0 + 2, y0 + 2, x0 + 2) uymat(z0 + 2, y0 + 2, x0 + 2) uzmat(z0 + 2, y0 + 2, x0 + 2)], [dx - 1, dy - 1, dz - 1]);

            n00 = lerp(n000, n100, dx);
            n01 = lerp(n001, n101, dx);
            n10 = lerp(n010, n110, dx);
            n11 = lerp(n011, n111, dx);

            n0 = lerp(n00, n10, dy);
            n1 = lerp(n01, n11, dy);

            s(y, x, z) = lerp(n0, n1, dz);
        end
    end
end

s = (s - min(s(:))) / (max(s(:)) - min(s(:)));
end

function u = lerp(a, b, t)
t = t^3 * (t * (t * 6 - 15) + 10);
u = (1 - t) * a + t * b;
end

function [uxmat, uymat, uzmat] = randxyzmat(numx, numy, numz)
uxmat = zeros(numz, numy, numx);
uymat = zeros(numz, numy, numx);
uzmat = zeros(numz, numy, numx);
for j = 1:numz * numy * numx
    k = 0;
    while k == 0
        randxyz = rand(1, 3);
        if norm(randxyz - 0.5 * ones(1, 3)) <= 0.5
            k = k + 1;
            [indz, indy, indx] = ind2sub([numz, numy, numx], j);
            uxmat(indz, indy, indx) = randxyz(1);
            uymat(indz, indy, indx) = randxyz(2);
            uzmat(indz, indy, indx) = randxyz(3);
        end
    end
end
uxmat = (uxmat - 0.5) * 2;
uymat = (uymat - 0.5) * 2;
uzmat = (uzmat - 0.5) * 2;
end

