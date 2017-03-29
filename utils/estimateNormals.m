function [ normals ] = estimateNormals( points, kNN )
% Normals estimation using PCA.
%
% Input
% points: Nx3 matrix. N is the number of points, each row contains x,y,z
% coordinate of that point.
% kNN: The number of nearest points taken into account when estimating normals.
%
% Output
% Normals: Nx3 matrix. Each row contains nx,ny,nz coordinate of unit
% normal vector.

    if nargin < 2
        kNN=10;
    end
    points_count = size(points, 1);%number of points
    normals = zeros(points_count, 3);
    ind_nearest = knnsearch(points, points, 'k', kNN);%Get indices of nearest kNN points of each point.
    parfor i=1:points_count
        normals(i,:)=estimateNormals_one_point(points, ind_nearest, i);
    end
    
end

function normal = estimateNormals_one_point(points, ind_nearest, i)
    neighbors=points(ind_nearest(i,:),:);
    try
        coeff = princomp(neighbors);%compute PCA
        normal=coeff(:,3);
    catch
        normal=[0;0;1];
    end
    if normal(3)<0
        normal=-normal;
    end
end