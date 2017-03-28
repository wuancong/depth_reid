% Demo for DVCov and Eigen-depth feature extraction of one frame in BIWI RGBD-ID dataset

clc;clear;
addpath './utils';

% Data examples from BIWI RGBD-ID dataset
% Dataset citation:
% M. Munaro, A. Basso, A. Fossati, L. V. Gool, and E. Menegatti, 3d
% reconstruction of freely moving persons for re-identification with a
% depth sensor, in The IEEE International Conference on Robotics and
% Automation (ICRA), 2014
rgb_file='./data/000_000000-a_8348863_rgb.jpg';
depth_file='./data/000_000000-b_8349124_depth.pgm';
mask_file='./data/000_000000-c_8349124_userMap.pgm';
skeleton_file='./data/000_000000-d_8349192_skel.txt';
ground_file='./data/000_000000-e_8349192_groundCoeff.txt';

% Preprocess data (this is different for different datasets)
depth=imread(depth_file);
mask=imread(mask_file);
skeleton=dlmread(skeleton_file);
ground=dlmread(ground_file);
pointcloud=compute_person_pointcloud(depth,mask);
pointcloud_torso=segment_torso(pointcloud,skeleton);

% Extract normals
% Normals are computed in matlab here, if you want to extract mormals
% faster, you could open matlab 'parpool' or use open source project Point Cloud Library (PCL) instead.
normals = estimateNormals( pointcloud_torso );

% Feature extraction (the output is the features)
% Please refer to PAVIS_evaluation.m to see how to use the features in PAVIS dataset
[cov_within, cov_between, ed_within, ed_between]=dvcov_and_eigen_depth_extraction(pointcloud_torso, normals);