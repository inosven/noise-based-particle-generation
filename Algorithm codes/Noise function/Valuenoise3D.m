function s=Valuenoise3D(m,f)
p=rand([f+2 f+2 f+2]);% Generate a random noise value matrix of size (f+2) x (f+2) x (f+2) and range [0, 1]
%p=p*2-1;
s=zeros([m m m]);% Initialize a zero matrix s of size m x m to store the noise values.
i=0;
for x=f/m:f/m:f
    i=i+1;
    j=0;
    for y=f/m:f/m:f
        j=j+1;
        k=0;
        for z=f/m:f/m:f
            k=k+1;
            % Recursively perform cubic linear interpolation in each dimension using the lerp function.
         s(j,i,k)=lerp(z-floor(z), lerp(y-floor(y), lerp(x-floor(x), p(floor(y)+1,floor(x)+1,floor(z)+1), ...
                                                                     p(floor(y)+1,floor(x)+2,floor(z)+1)), ... 
                                                    lerp(x-floor(x), p(floor(y)+2,floor(x)+1,floor(z)+1), ...
                                                                     p(floor(y)+2,floor(x)+2,floor(z)+1))), ...
                                   lerp(y-floor(y), lerp(x-floor(x), p(floor(y)+1,floor(x)+1,floor(z)+2), ...
                                                                     p(floor(y)+1,floor(x)+2,floor(z)+2)), ...
                                                    lerp(x-floor(x), p(floor(y)+2,floor(x)+1,floor(z)+2), ...
                                                                     p(floor(y)+2,floor(x)+2,floor(z)+2))));
        end
    end
end
% Normalize the noise matrix s so that its value range is between [0,1].
s=(s - min(s(:))) / (max(s(:)) - min(s(:)));
end

function u=lerp(t,a,b)
% Apply a smoothing function to make the interpolation smoother.
t=t^3*(t*(t*6-15)+10);
u=a*(1-t)+b*t;
end