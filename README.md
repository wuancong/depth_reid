# Codes of "Robust Depth-based Person Re-identification"

# Contact information
If you have any question, please feel free to contact with me. My name is Ancong Wu and my email is wuancong@mail2.sysu.edu.cn.

# introduction
This package contains the feature extraction codes of DVCov descriptor, Eigen-depth feature and the skeleton-based feature. There is also an evaluation example on PAVIS (RGBD-ID) dataset.

If you use the code, please cite the following paper:
Ancong Wu, Wei-Shi Zheng, Jian-Huang Lai. Robust Depth-based Person Re-identification. IEEE Transactions on Image Processing, 2017 (DOI: 10.1109/TIP.2017.2675201).

# codes

- demo_PAVIS.m
A complete process of feature extraction and evaluation on PAVIS dataset. It calls three scripts, "PAVIS_feature_extraction.m", "PAVIS_skeleton_feature_extraction.m" and "PAVIS_evaluation.m".

- PAVIS_feature_extraction.m
Extracting and saving DVCov and Eigen-depth features.

- PAVIS_skeleton_feature_extraction.m
Extracting and saving skeleton-based features.

- PAVIS_evaluation.m
Based on the extracted features, evaluating the performance on PAVIS dataset.
The features extracted by "PAVIS_feature_extraction.m" and 
"PAVIS_skeleton_feature_extraction.m" are required.

- BIWI_feature_extraction_demo.m
We also give an example of how to extract feature in BIWI RGBD-ID dataset, which is a little different from PAVIS dataset.
The following files (raw data of BIWI RGBD-ID dataset) are required:
'./data/000_000000-a_8348863_rgb.jpg'
'./data/000_000000-b_8349124_depth.pgm'
'./data/000_000000-c_8349124_userMap.pgm'
'./data/000_000000-d_8349192_skel.txt'
'./data/000_000000-e_8349192_groundCoeff.txt'

# directories

- './utils'
If you want to know the implementation details of the feature extraction and evaluation process, please read the codes in './utils'.

- './features'
The extracted features are saved here.

- './data'
Preprocessed data for feature extraction.

-- point_torso_walking1.mat and point_torso_walking2.mat
To save memory space, we provide the preprocessed point cloud of head and torso segmented by skeleton joints.
The preprocessing can be easily done by the user, which is segmenting the point cloud of the whole body by the shoulder joints and hip joints as illustrated in our paper.

-- joint_pos_walking1.mat and joint_pos_walking2.mat
Structs containing skeleton joint positions obtained from the dataset (unit:cm). 

-- floor_walking1.mat and floor_walking2.mat
Coefficients [a,b,c,d] for the floor plane ax+by+cz+d=0 (unit:cm).

-- split.mat
A fixed split for training and testing in evaluation.
