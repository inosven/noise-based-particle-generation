function s=Worleynoise2D(m,n,f)
s = zeros(m);% Initialize a zero matrix s of size m x m to store the noise values.
seed=randi(2^32-1,f);% Generate a random seed matrix of size f x f.
j=0;
for x =f/m:f/m:f
    j=j+1;
    k=0;
    ux=floor(x);
    if ux==f
        ux=f-1;
    end
    for y =f/m:f/m:f
        k=k+1;
        uy=floor(y);
        if uy==f
            uy=f-1;
        end
        % Create a random stream object and generate n feature points.
        randobject=RandStream ('mt19937ar', 'Seed', seed (uy+1,ux+1));
        feature_points=rand(randobject,n,2)+[ux,uy];
        % Create a random stream object and generate n feature points.
        for di = -1:1 
            for dj = -1:1 
                % If the coordinates are out of bounds, skip.
                if ux+di==-1||uy+dj==-1||ux+di==f||uy+dj==f
                    continue;
                end
                if di == 0 && dj == 0
                    continue;
                end
                % Update feature point coordinates
                randobject=RandStream ('mt19937ar', 'Seed', seed (uy+dj+1,ux+di+1));
                feature_points=[feature_points;rand(randobject,n,2)+[ux+di,uy+dj]];
            end
        end
        % calculate the distance from the current point to the nearest feature point.
        tested_points=[x,y];
        ClosestDistance=min(pdist2 (feature_points, tested_points));
        % Store the closest distance to Worley noise.
        s(k,j)=ClosestDistance;
    end
end
% Normalize the noise matrix s so that its value range is between [0,1].
s=(s-min(min(s)))./(max(max(s))-min(min(s)));
end