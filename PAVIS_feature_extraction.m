% Extract and save dvcov and eigen-depth of PAVIS (RGBD-ID)
% last updated: 2017/3/28
% dataset citation:
% I. B. Barbosa, M. Cristani, A. Del Bue, L. Bazzani, and V. Murino, 
% ¡°Reidentification with rgb-d sensors,¡± in European Conference on Computer
% Vision (ECCV) Workshop. Springer, 2012, pp. 433¨C442.

clc;clear
addpath './utils';

for chosen_dataset_num=1:2

% parameter of dividing patches for feature extraction
para.n_col = 2; % default 2
para.n_row = 6; % default 6
    
if chosen_dataset_num==1
    chosen_dataset='walking1'
elseif chosen_dataset_num==2
    chosen_dataset='walking2'
end

X_cov_within=[];
X_cov_between=[];
X_ed_within=[];
X_ed_between=[];
Y=[];

% the data point_torso_walking1.mat and point_torso_walking2.mat are
% preprocessed by extracting the head and torso parts of the pointclouds
% provided by the dataset
load(fullfile('./data',['point_torso_' chosen_dataset '.mat']));
person_count=length(point_torso);

for selected_user =1:person_count
    
    disp(selected_user);
    frame_count=length(point_torso{selected_user});
    
    for selected_frame=1:frame_count
        
        point_torso_this=point_torso{selected_user}{selected_frame};
        
        % Estimate normal vectors (using parpool in matlab for faster extraction)
        % If you want faster estimation, this operation can be replaced by
        % using Point Cloud Library (PCL).
        normals_this = estimateNormals( point_torso_this );
        
        % the proposed depth shape descriptor
        [cov_within, cov_between, ed_within, ed_between]=dvcov_and_eigen_depth_extraction(point_torso_this, normals_this, para);
        
        Y=[Y;selected_user];
        X_cov_within=[X_cov_within;cov_within'];
        X_cov_between=[X_cov_between;cov_between'];
        X_ed_within=[X_ed_within;ed_within'];
        X_ed_between=[X_ed_between;ed_between'];
        
    end
end

% saving the features
save_dir=fullfile('./features',chosen_dataset);
if ~exist(save_dir,'dir')
    mkdir(save_dir);
end
X=[X_cov_within X_cov_between];
save_path=fullfile(save_dir, ['X_dvcov_' num2str(para.n_row) 'x' num2str(para.n_col) '.mat']);
save(save_path, 'X', 'Y');
X=[X_ed_within X_ed_between];
save_path=fullfile(save_dir, ['X_ed_' num2str(para.n_row) 'x' num2str(para.n_col) '.mat']);
save(save_path, 'X', 'Y');
end