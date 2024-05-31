m=400; f0=10; N=4; q=0.5; n=1;
s=zeros(m);
% rng(11)
for i=0:N
    figure
    f=f0*2^i;
%     s0=worleynoise2D(m,n,f);q
%     s0=valuenoise2D(m,f);
    s0=perlinnoise2D(m,f);
    s=s+s0*q^i;
    imagesc(s)
    axis image
    axis off
    colormap gray
    colorbar
    xticks([0 m/2 m])
    yticks([0 m/2 m])
end