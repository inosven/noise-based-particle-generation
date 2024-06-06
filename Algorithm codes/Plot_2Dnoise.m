% % This MATLAB code is used to generate and display four different types of 2D noise: 
% % White noise, Value noise, Perlin noise, and Worley noise. 

% % Set parameters:
% m: resolution of 2D noise image (size)./the number of pixel points in each dimension of the square (length, and width) noise space.
% f: frequency  of 2D noise./the square noise space is partitioned into f × f cells, with f cells along each dimension respectively.
% n: the number of feature points in each cell (only in Worley noise).
m=400; n=1; f=10;

% % Generate different types of 2D noise.
s0=rand(m);
s1=Valuenoise2D(m,f);
s2=Perlinnoise2D(m,f);
s3=Worleynoise2D(m,n,f);

% % Visualization of 2D noises.
% White nosie
subplot(2,2,1)
imagesc(s0)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("White noise")
axis image

% Value noise
subplot(2,2,2)
imagesc(s1)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Value noise")
axis image

% Perlin noise
subplot(2,2,3)
imagesc(s2)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Perlin noise")
axis image

% Worley noise
subplot(2,2,4)
imagesc(s3)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Worley noise")
axis image