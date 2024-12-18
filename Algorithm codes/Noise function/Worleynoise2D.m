function s=Worleynoise2D(m,n,f)
s = zeros(m);% Initialize a zero matrix s of size m x m to store the noise values.
seed=randi(2^32-1,f,f);% Generate a random seed matrix of size f x f.

% Coordinates of n feature points
feature_points_map=cell(f,f);
for ux=0:f-1
    for uy=0:f-1
        randobject= RandStream('mt19937ar', 'Seed', seed(uy+1, ux+1));
        feature_points_map{uy+1, ux+1}= rand(randobject, n, 2) + [ux, uy];
    end
end

j=0;
for x=f/m:f/m:f
    j=j+1;
    k=0;
    ux=floor(x);
    if ux==f
        ux=f-1;
    end
    for y=f/m:f/m:f
        k=k+1;
        uy=floor(y);
        if uy==f
            uy=f-1;
        end
        % Find the feature_points in the cells closest to the tested_points
        feature_points= feature_points_map{uy+1, ux+1};
        for di= -1:1
            for dj= -1:1
                nx= ux + di;
                ny= uy + dj;
                if nx < 0 || ny < 0 || nx >= f || ny >= f
                    continue;
                end
                if di ~= 0 || dj ~= 0
                    feature_points= [feature_points; feature_points_map{ny+1, nx+1}];
                end
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
s=(s - min(s(:))) / (max(s(:)) - min(s(:)));
end