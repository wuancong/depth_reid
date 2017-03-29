function [cov_within, cov_between, ed_within, ed_between]=dvcov_and_eigen_depth_extraction(vertex, normals, para)
% extract dvcov and eigen-depth feature
%
% input:
% vertex - Nx3 matrix, each row is a point
% normals - Nx3 matrix, each row is a unit normal vector
% para.n_col - the number of columns of divided point cloud (default 2, 50% overlap)
% para.n_row - the number of rows of divided point cloud (default 6, 50% overlap)
%
% output:
% cov_within - vector converted from 6x6xn_cov matrix
% cov_between - vector converted from 6x6xn_cov matrix
% ed_within - eigen-depth feature vector within voxel
% ed_between - eigen-depth feature vector between voxel
%
% last updated: 2016/8/13

if nargin<3
    patches=segment_patch(vertex, normals);
else
    n_row=para.n_row;
    n_col=para.n_col;
    patches=segment_patch(vertex, normals, n_col, n_row);
end

cov_within=within_patch_covariance(patches);
cov_between=between_patch_covariance(patches);
ed_within=eigen_depth(cov_within);
ed_between=eigen_depth(cov_between);
cov_within=cov_within(:);
cov_between=cov_between(:);
end