% extract skeleton-based feature of PAVIS (RGBD-ID)
% last updated: 2017/3/28

clc;clear
addpath './utils';

for chosen_dataset_num=1:2
    
if chosen_dataset_num==1
    chosen_dataset='walking1'
elseif chosen_dataset_num==2
    chosen_dataset='walking2'
end

X=[];
Y=[];

load(fullfile('./data',['joint_pos_' chosen_dataset '.mat']));
load(fullfile('./data',['floor_' chosen_dataset '.mat']));
person_count=length(floor);

for selected_user =1:person_count
    
    disp(selected_user);
    frame_count=length(floor{selected_user});
    
    for selected_frame=1:frame_count
        
        joint_pos_this=joint_pos{selected_user}{selected_frame};
        floor_this=floor{selected_user}{selected_frame};
        
        feature=skeleton_feature_extraction(joint_pos_this,floor_this);
        
        X=[X;feature'];
        Y=[Y;selected_user];
        
    end
end
save_dir=fullfile('./features',chosen_dataset);
if ~exist(save_dir,'dir')
    mkdir(save_dir);
end
save_path=fullfile(save_dir, 'X_skl.mat');
save(save_path, 'X', 'Y');
end