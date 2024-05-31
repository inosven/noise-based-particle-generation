m=400; n=1; f=10;
s0=rand(m);
s1=Valuenoise2D(m,f);
s2=Perlinnoise2D(m,f);
s3=Worleynoise2D(m,n,f);

subplot(2,2,1)
imagesc(s0)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("White noise")
axis image

subplot(2,2,2)
imagesc(s1)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Value noise")
axis image

subplot(2,2,3)
imagesc(s2)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Perlin noise")
axis image

subplot(2,2,4)
imagesc(s3)
colormap gray
xticks([0 m/2 m])
yticks([0 m/2 m])
title("Worley noise")
axis image