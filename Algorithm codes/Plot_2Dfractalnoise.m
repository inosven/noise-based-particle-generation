% % This MATLAB code is used to generate and display 2D fractal noise.

% % Set parameters:
% m: resolution of 2D noise image (size).
% f0: frequency of 2D noise.
% n: the number of feature points in each cell (only in Worley noise).
% q: decay factor for fractal noise.
% N: number of fractal iterations (number of superimposed high-frequency noise).
m=400; f0=10; N=4; q=0.5; n=1;
s=zeros(m);
% rng(11)

% % Noise superposition
% % Visualization of 2D frctal noises.
for i=0:N
    figure
    f=f0*2^i;% The frequency doubling strategy.

    % % Fractal noise based on Perlin noise.
    % % Other noise can be used for noise superposition.
    % % For example, here you can replace Perlinnoise2D(m,f) with Worleynoise2D(m,n,f).
%     s0=Worleynoise2D(m,n,f);
%     s0=Valuenoise2D(m,f);
    s0=Perlinnoise2D(m,f);
    s=s+s0*q^i;
    imagesc(s)
    axis image
    axis off
    colormap gray
    colorbar
    xticks([0 m/2 m])
    yticks([0 m/2 m])
end