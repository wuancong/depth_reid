function pointcloud = compute_person_pointcloud( depth, mask, depth_intrinsics )
% compute point cloud of a pedestrian, after 
%
% input:
% depth - depth image
% mask - mask image of pedestrian
% intrinsics - depth camera intrinsics (default is for BIWI)
%
% output:
% pointcloud - after mean filtering
%
%%%%%%%%%%% notice that output pointcloud may be empty if the person is not tracked %%%%%%%%%%%%%%%%%%%
%
range=400; %valid range of z 400mm
depth_image=double(depth);
mask_image=double(logical(mask));
depth_image1=depth_image.*mask_image;
depth_image1=medfilt2(depth_image1,[5 5]);
if nargin > 2
    pointcloud=pointcloudFromDepthImage(depth_image1,depth_intrinsics);
else
    pointcloud=pointcloudFromDepthImage(depth_image1);
end
mean_depth=mean(pointcloud(:,3));
pointcloud(pointcloud(:,3)<mean_depth-range & pointcloud(:,3)>mean_depth+range,:)=[];
%mean filtering
ind=knnsearch(pointcloud(:,1:2),pointcloud(:,1:2),'k',10);
z=pointcloud(:,3);
z=mean(z(ind),2);
pointcloud(:,3)=z;

end

