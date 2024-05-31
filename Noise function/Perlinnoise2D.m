function s=Perlinnoise2D(m,f)
[uxmat,uymat]=randxymat(f+2,f+2);
s=zeros(m,m);
j=0;
 for x=f/m:f/m:f
    j=j+1;
    k=0;
    for y=f/m:f/m:f
        k=k+1;
        
        ddx=x-floor(x);
        ddy=y-floor(y);
        ux=uxmat(floor(y)+1,floor(x)+1);
        uy=uymat(floor(y)+1,floor(x)+1);
        n00=dot([ux uy],[ddx ddy]);
        
        ddx=x-floor(x)-1;
        ddy=y-floor(y);
        ux=uxmat(floor(y)+1,floor(x)+2);
        uy=uymat(floor(y)+1,floor(x)+2);
        n10=dot([ux uy],[ddx ddy]);
        
        ddx=x-floor(x);
        ddy=y-floor(y)-1;
        ux=uxmat(floor(y)+2,floor(x)+1);
        uy=uymat(floor(y)+2,floor(x)+1);
        n01=dot([ux uy],[ddx ddy]);
        
        ddx=x-floor(x)-1;
        ddy=y-floor(y)-1;
        ux=uxmat(floor(y)+2,floor(x)+2);
        uy=uymat(floor(y)+2,floor(x)+2);
        n11=dot([ux uy],[ddx ddy]);
        
        n0=lerp(n00,n10,x-floor(x));
        n1=lerp(n01,n11,x-floor(x));
        s(k,j)=lerp(n0,n1,y-floor(y));
    end
 end
 s = (s-min(min(s)))./(max(max(s))-min(min(s)));
end

function u=lerp(a,b,t)
    t=t^3*(t*(t*6-15)+10);
    u=(1-t)*a + t*b;
end

function [uxmat,uymat]=randxymat(numx,numy)
    num=numx*numy;
    uxmat=zeros(numy,numx);
    uymat=zeros(numy,numx);
    for j=1:num
        k=0;
        while k==0
            randxy=rand(1,2);
            if (randxy(1)-0.5)^2+(randxy(2)-0.5)^2<=0.25
                k=k+1;
                uxmat(j)=randxy(1);
                uymat(j)=randxy(2);
            end
        end
    end
    uxmat=(uxmat-0.5)*2;
    uymat=(uymat-0.5)*2;
end