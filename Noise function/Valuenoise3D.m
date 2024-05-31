function s=Valuenoise3D(m,f)
p=rand([f+2 f+2 f+2]);
%p=p*2-1;
s=zeros([m m m]);
i=0;
for x=f/m:f/m:f
    i=i+1;
    j=0;
    for y=f/m:f/m:f
        j=j+1;
        k=0;
        for z=f/m:f/m:f
            k=k+1;
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
s= (s-min(min(min(s))))./(max(max(max(s)))-min(min(min(s))));
end

function u=lerp(t,a,b)
t=t^3*(t*(t*6-15)+10);
u=a*(1-t)+b*t;
end