function cmc_mean = PAVIS_evaluation(exp, number_shot)
% input:
% exp - experiment name, four options
% exp='covariance';
% exp='covariance+skeleton';
% exp='eigen-depth';
% exp='eigen-depth+skeleton';
% number_shot - 1 or 5 denoting single-shot and multi-shot

addpath './utils';

%% experiment setting
gallery_set='walking1';
probe_set='walking2';

number_shot
exp

switch exp
    case 'eigen-depth'
        feature_name{1}='ed_6x2';
        combine_method='no';
        model_name{1}='LDA';
    case 'eigen-depth+skeleton'
        feature_name{1}='ed_6x2';
        feature_name{2}='skl';
        combine_method='concatentation';
        model_name{1}='LDA';
    case 'covariance'
        feature_name{1}='dvcov_6x2';
        combine_method='no';
        model_name{1}='cov_dist';
    case 'covariance+skeleton'
        feature_name{1}='dvcov_6x2';
        feature_name{2}='skl';
        combine_method='score';
        model_name{1}='cov_dist';
        model_name{2}='Euclidean';
end

%% load feature
feature_type=length(feature_name);
X_cam1=cell(feature_type,1);
X_cam2=cell(feature_type,1);
for i=1:feature_type
    content=load(['./features/' gallery_set '/X_' feature_name{i} '.mat']);
    X_cam1{i}=content.X;
    Y_cam1=content.Y;
    content=load(['./features/' probe_set '/X_' feature_name{i} '.mat']);
    X_cam2{i}=content.X;
    Y_cam2=content.Y;
end

%% split
% there is a fixed split for training, gallery set and probe set
load('./data/split.mat');

%% evaluation
test_person_count=size(split.test_label,2);
cmc_all=zeros(10,test_person_count);

for trial_num=1:10
    
    disp(['trial #' num2str(trial_num)]);
    
    for i=1:feature_type
        [X_train{i},Y_train,X_gallery{i},Y_gallery,X_probe{i},Y_probe]=segment_dataset(X_cam1{i}, Y_cam1, X_cam2{i}, Y_cam2, split, number_shot,trial_num);
    end
    
    if strcmp(combine_method,'concatentation')
        X_train{1}=[X_train{1} X_train{2}];
        X_train(2)=[];
        X_gallery{1}=[X_gallery{1} X_gallery{2}];
        X_gallery(2)=[];
        X_probe{1}=[X_probe{1} X_probe{2}];
        X_probe(2)=[];
    end
    
    X_train_cell_count=length(X_train);
    for i=1:X_train_cell_count
        switch model_name{i}
            case 'LDA'
                [P_pca,~,latent]=princomp(X_train{i},'econ');
                pca_ind=find(cumsum(latent)/sum(latent)>0.99);
                pca_dim=pca_ind(1);
                P_pca=P_pca(:,1:pca_dim);
                X_train{i}=X_train{i}*P_pca;
                X_gallery{i}=X_gallery{i}*P_pca;
                X_probe{i}=X_probe{i}*P_pca;
                W=LDA(X_train{i}',Y_train);
                X_gallery{i}=X_gallery{i}*W;
                X_probe{i}=X_probe{i}*W;
                dist{i}=pdist2(X_probe{i},X_gallery{i});
            case 'Euclidean'
                dist{i}=pdist2(X_probe{i},X_gallery{i});
            case 'cov_dist'
                dist{i}=pdist2(X_probe{i},X_gallery{i},@covariance_vector_distance);
        end
    end
    dist_sum=zeros(size(dist{1}));
    for i=1:X_train_cell_count
        dist_sum=dist_sum+dist{i};
    end
    cmc=get_cmc(Y_gallery,Y_probe,dist_sum);
    cmc_all(trial_num,:)=cmc;
    disp('rank 1 5 10 20');
    disp(cmc([1 5 10 20]));
end
cmc_mean=mean(cmc_all,1);
disp('Average CMC:');
disp('rank 1 5 10 20');
disp(cmc_mean([1 5 10 20]));
