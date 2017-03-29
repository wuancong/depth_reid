function [X_train,Y_train,X_gallery,Y_gallery,X_probe,Y_probe]= segment_dataset(X_cam1,Y_cam1,X_cam2,Y_cam2,split,number_shot,trial_num)
% segment dataset to training set and testing gallery and probe set
%
% input:
% X_cam1, Y_cam1 - training and gallery
% X_cam2, Y_cam2 - training and probe
% split - struct containing cam1_shuffle_ind, train_label and test_label of
% 10 trials
% number_shot - n shot
% trial_num - the n-th trial
%
% output:
% X_train, Y_train - training set
% X_gallery, Y_gallery - gallery set
% X_probe, Y_probe - probe set

cam1_shuffle_ind = split.cam1_shuffle_ind(trial_num,:);
train_label=split.train_label(trial_num,:);
test_label=split.test_label(trial_num,:);

train_ind1=[];
train_ind2=[];
for id=train_label
    ind1=find(Y_cam1==id);
    train_ind1=[train_ind1;ind1];
    ind2=find(Y_cam2==id);
    train_ind2=[train_ind2;ind2];
end
X_train_cam1=X_cam1(train_ind1,:);
Y_train_cam1=Y_cam1(train_ind1,:);
X_train_cam2=X_cam2(train_ind2,:);
Y_train_cam2=Y_cam2(train_ind2,:);
X_train=[X_train_cam1;X_train_cam2];
Y_train=[Y_train_cam1;Y_train_cam2];

X_cam1=X_cam1(cam1_shuffle_ind,:);
Y_cam1=Y_cam1(cam1_shuffle_ind,:);
gallery_ind=[];
probe_ind=[];
for id=test_label
    ind1=find(Y_cam1==id);
    gallery_ind=[gallery_ind;ind1(1:min(number_shot,end))];
    ind2=find(Y_cam2==id);
    probe_ind=[probe_ind;ind2];
end
X_gallery=X_cam1(gallery_ind,:);
Y_gallery=Y_cam1(gallery_ind,:);
X_probe=X_cam2(probe_ind,:);
Y_probe=Y_cam2(probe_ind,:);