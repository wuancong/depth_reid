function pointcloud_torso = segment_torso( vertex, Pos )
% segment torso of pedestrian whole body point cloud by skeleton joints
%
% input:
% vertex - Nx3 matrix, points of whole body
% Pos - position of skeleton joints, obtained by dlmread('skeleton.txt');
%
% output:
% pointcloud_torso - pointcloud of torso
if isempty(vertex)
    pointcloud_torso=[];
    return;
end
joints=Pos(1:20,2:4);
joints(:,2)=-joints(:,2);
joints=joints*1000;
l_shoulder_x=joints(9,1);

r_shoulder_x=joints(5,1);
l_hip_y=joints(17,2);
r_hip_y=joints(13,2);

vertex_x_range=[r_shoulder_x l_shoulder_x];
[vertex_min_y]=min(vertex(:,2));
vertex_y_range=[vertex_min_y (l_hip_y+r_hip_y)/2];

vertex_x=vertex(:,1);
vertex_y=vertex(:,2);
vertex_z=vertex(:,3);
is_vertex_valid=( vertex_x>=vertex_x_range(1) & vertex_x<=vertex_x_range(2) & vertex_y>=vertex_y_range(1) & vertex_y<=vertex_y_range(2) );
vertex_x=vertex_x(is_vertex_valid);
vertex_y=vertex_y(is_vertex_valid);
vertex_z=vertex_z(is_vertex_valid);

pointcloud_torso=[vertex_x vertex_y vertex_z];

end

