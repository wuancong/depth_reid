function [ output_cloud ] = pointcloudFromDepthImage( depth_image, depth_intrinsics )
% convert depth image to point cloud
%
% input:
% depth_image - each pixel is the depth value
% depth_intrinsics - intrinsic matrix of the camera (default intrinsics for BIWI)
%
% output:
% output_cloud - Nx3 matrix, each row is a point
if nargin<2
    depth_intrinsics=[575.8, 0.0, 319.5; 0.0, 575.8, 239.5; 0.0, 0.0, 1.0];
end
depth_focal_inverted_x = 1/depth_intrinsics(1,1);
depth_focal_inverted_y = 1/depth_intrinsics(2,2);
[rows_depth_image, cols_depth_image] = size(depth_image);
output_cloud=zeros(rows_depth_image*cols_depth_image,3);
num=0;
for i=1:rows_depth_image
    for j=1:cols_depth_image
        depth_value=depth_image(i,j);
        if depth_value > 0
            new_point.z = depth_value;
            new_point.x = (j-1 - depth_intrinsics(1,3)) * new_point.z * depth_focal_inverted_x;
            new_point.y = (i-1 - depth_intrinsics(2,3)) * new_point.z * depth_focal_inverted_y;
            num=num+1;
            output_cloud(num,:)=[new_point.x new_point.y new_point.z];
        end
    end
end
output_cloud(num+1:end,:)=[];
end

