% demo for PAVIS (RGBD-ID) dataset
% dataset citation:
% I. B. Barbosa, M. Cristani, A. Del Bue, L. Bazzani, and V. Murino, 
% ¡°Reidentification with rgb-d sensors,¡± in European Conference on Computer
% Vision (ECCV) Workshop. Springer, 2012, pp. 433¨C442.

is_feat_extracted=false;

% extract and save features
if ~is_feat_extracted
    parpool;
    PAVIS_feature_extraction; % the proposed depth features
    PAVIS_skeleton_feature_extraction; % skeleton-based feature
end

% if the features have been extracted and saved, you can only run
% PAVIS_evaluation(exp) without the previous two steps
exp = 'eigen-depth'; % options: 'covariance', 'covariance+skeleton', 'eigen-depth', 'eigen-depth+skeleton'
number_shot = 1; %options: 1 for single-shot and 5 for multi-shot
cmc = PAVIS_evaluation(exp, number_shot);