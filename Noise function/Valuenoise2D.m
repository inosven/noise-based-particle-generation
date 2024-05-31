function s=Valuenoise2D(m,f)
p=rand(f+2);
%p=p*2-1;
s=zeros(m);
j=0;
 for x=f/m:f/m:f
    j=j+1;
    k=0;
    for y=f/m:f/m:f
        k=k+1;
         n00=p(floor(y)+1,floor(x)+1);
         n10=p(floor(y)+1,floor(x)+2);
         n11=p(floor(y)+2,floor(x)+2);
         n01=p(floor(y)+2,floor(x)+1);
         n0=lerp(n00,n10,x-floor(x));
         n1=lerp(n01,n11,x-floor(x));
         s(k,j)=lerp(n0,n1,y-floor(y));
    end
 end
s = (s-min(min(s)))./(max(max(s))-min(min(s)));
end

function u=lerp(a,b,t)
tw=t^3*(t*(t*6-15)+10);
u=a*(1-tw)+b*tw;
end