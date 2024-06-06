function s=Perlinnoise2D(m,f)
[uxmat,uymat]=randxymat(f+2,f+2);% [uxmat,uymat] are the random gradient matrices, sized (f+2) x (f+2).
s=zeros(m,m);% Initialize a zero matrix s of size m x m to store the noise values.
j=0;% Initialize row index.
 for x=f/m:f/m:f
    j=j+1;% Update row index.
    k=0;% Initialize column index.
    for y=f/m:f/m:f
        k=k+1;% Update column index.
        
        ddx=x-floor(x);
        ddy=y-floor(y);
        % Get the gradient of the current point.
        ux=uxmat(floor(y)+1,floor(x)+1);
        uy=uymat(floor(y)+1,floor(x)+1);
        n00=dot([ux uy],[ddx ddy]);% Calculate the noise value at point (0,0).
        
        ddx=x-floor(x)-1;
        ddy=y-floor(y);
        % Get the gradient of the current point.
        ux=uxmat(floor(y)+1,floor(x)+2);
        uy=uymat(floor(y)+1,floor(x)+2);
        n10=dot([ux uy],[ddx ddy]);% Calculate the noise value at point (1,0).
        
        ddx=x-floor(x);
        ddy=y-floor(y)-1;
        % Get the gradient of the current point.
        ux=uxmat(floor(y)+2,floor(x)+1);
        uy=uymat(floor(y)+2,floor(x)+1);
        n01=dot([ux uy],[ddx ddy]);% Calculate the noise value at point (0,1).
        
        ddx=x-floor(x)-1;
        ddy=y-floor(y)-1;
        % Get the gradient of the current point.
        ux=uxmat(floor(y)+2,floor(x)+2);
        uy=uymat(floor(y)+2,floor(x)+2);
        n11=dot([ux uy],[ddx ddy]);% Calculate the noise value at point (1,1).
        
        % Perform linear interpolation in the x-direction.
        n0=lerp(n00,n10,x-floor(x));
        n1=lerp(n01,n11,x-floor(x));
        % Perform linear interpolation in the y-direction to get the final noise value.
        s(k,j)=lerp(n0,n1,y-floor(y));
    end
 end
% Normalize the noise matrix s so that its value range is between [0,1].
s = (s-min(min(s)))./(max(max(s))-min(min(s)));
end
% Apply a smoothing function to make the interpolation smoother.
function u=lerp(a,b,t)
    t=t^3*(t*(t*6-15)+10);
    u=(1-t)*a + t*b;
end
% Function randxymat generates random gradient matrices.
function [uxmat,uymat]=randxymat(numx,numy)
    num=numx*numy;
    uxmat=zeros(numy,numx);
    uymat=zeros(numy,numx);
    for j=1:num
        k=0;
        while k==0
            randxy=rand(1,2);
            % Check if the point is within the unit circle.
            if (randxy(1)-0.5)^2+(randxy(2)-0.5)^2<=0.25
                k=k+1;
                uxmat(j)=randxy(1);
                uymat(j)=randxy(2);
            end
        end
    end
    % Standardize the gradient to the interval [-1,1].
    uxmat=(uxmat-0.5)*2;
    uymat=(uymat-0.5)*2;
end