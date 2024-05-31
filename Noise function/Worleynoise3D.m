function s=Worleynoise3D(m,n,f)
s = zeros([m,m,m]);
seed=randi(2^32-1,[f,f,f]);
i=0;
for x=f/m:f/m:f
    i=i+1;
    j=0;
    ux=floor(x);
    if ux==f
        ux=f-1;
    end
    for y=f/m:f/m:f
        j=j+1;
        k=0;
        uy=floor(y);
        if uy==f
            uy=f-1;
        end
        for z=f/m:f/m:f
            k=k+1;
            uz=floor(z);
            if uz==f
                uz=f-1;
            end
            randobject= RandStream ('mt19937ar', 'Seed', seed (uy+1,ux+1,uz+1));
            feature_points =rand(randobject,n,3)+[ux,uy,uz];
            for di = -1:1
                for dj = -1:1
                    for dk = -1:1
                        if ux+di==-1||uy+dj==-1||uz+dk==-1||ux+di==f||uy+dj==f||uz+dk==f
                            continue;
                        end
                        if di == 0 && dj == 0 && dk == 0
                            continue;                                             
                        end
                        randobject= RandStream ('mt19937ar', 'Seed', seed (uy+dj+1,ux+di+1,uz+dk+1));
                        feature_points=[feature_points;rand(randobject,n,3)+[ux+di,uy+dj,uz+dk]];
                    end
                end
            end
            tested_points = [x,y,z];
            ClosestDistance = min(pdist2 (feature_points, tested_points));
            s(j,i,k)=ClosestDistance;
        end
    end
end
s= (s-min(min(min(s))))./(max(max(max(s)))-min(min(min(s))));
end





