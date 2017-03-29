function patch = segment_patch( vertex, normals, x_patch_num, y_patch_num  )
% get patches of points and normals
%
% input:
% vertex - Nx3 matrix, each row is a point
% normals - Nx3 matrix, each row is a unit normal vector
% x_patch_num - the number of columns of divided point cloud (default 2, 50% overlap)
% y_patch_num - the number of rows of divided point cloud (default 6, 50% overlap)
%
% output:
% patch - (y_patch_num*2-1)*(x_patch_num*2-1) cell, each cell contains Nx6
% feature vectors

if nargin<3
    x_patch_num=2;
    y_patch_num=6;
end
patch=cell((y_patch_num*2-1),(x_patch_num*2-1));
if isempty(vertex)
    patches=[];
    return;
end
[vertex_max_x]=max(vertex(:,1));
[vertex_min_x]=min(vertex(:,1));
vertex_x_range=[vertex_min_x vertex_max_x];
[vertex_max_y]=max(vertex(:,2));
[vertex_min_y]=min(vertex(:,2));
vertex_y_range=[vertex_min_y vertex_max_y];

vertex_x=vertex(:,1);
vertex_y=vertex(:,2);

patch_size_x = (vertex_x_range(2)-vertex_x_range(1))/x_patch_num;
patch_size_y = (vertex_y_range(2)-vertex_y_range(1))/y_patch_num;

for i=1:x_patch_num*2-1
    for j=1:y_patch_num*2-1
        patch_x_range = [vertex_x_range(1)+(i-1)*patch_size_x/2, vertex_x_range(1)+(i-1)*patch_size_x/2+patch_size_x];
        patch_y_range = [vertex_y_range(1)+(j-1)*patch_size_y/2, vertex_y_range(1)+(j-1)*patch_size_y/2+patch_size_y];
        is_vertex_valid=( vertex_x>=patch_x_range(1) & vertex_x<=patch_x_range(2) & vertex_y>=patch_y_range(1) & vertex_y<=patch_y_range(2) );
        sub_normal_vector=normals(is_vertex_valid,:);
        sub_vertex=vertex(is_vertex_valid,:);
        
        if size(sub_normal_vector,1)==0
            continue;
        else
            patch{j,i}=[sub_vertex sub_normal_vector];
        end
    end
end

end

