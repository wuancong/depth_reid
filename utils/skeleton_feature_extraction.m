function [ feature ] = skeleton_feature_extraction( joint_pos, floor )
% extract skeleton-based feature, implementation of the following paper:
% M. Munaro, A. Basso, A. Fossati, L. V. Gool, and E. Menegatti, 3d
% reconstruction of freely moving persons for re-identification with a
% depth sensor, in The IEEE International Conference on Robotics and
% Automation (ICRA), 2014
%
% input:
% joint_pos - a struct containing 15 fields including positions of head, neck, torso, l_shoulder (left),
% r_shoulder (right), l_elbow, r_elbow, l_hand, r_hand, l_hip, r_hip,
% l_knee, r_knee, l_foot, r_foot, each one is represented by coordinate
% [x,y,z] (unit: cm)
% floor - the coeffcients of the floor plane ax+by+c+d=0 represented by [a,b,c,d]
%
% output:
% feature - column feature vector

a=floor(1);
b=floor(2);
c=floor(3);
d=floor(4);

head=joint_pos.head;
neck=joint_pos.neck;
torso=joint_pos.torso;
l_shoulder=joint_pos.l_shoulder;
l_elbow=joint_pos.l_elbow;
l_hand=joint_pos.l_hand;
r_shoulder=joint_pos.r_shoulder;
r_elbow=joint_pos.r_elbow;
r_hand=joint_pos.r_hand;
l_hip=joint_pos.l_hip;
l_knee=joint_pos.l_knee;
l_foot=joint_pos.l_foot;
r_hip=joint_pos.r_hip;
r_knee=joint_pos.r_knee;
r_foot=joint_pos.r_foot;

feature=zeros(13,1);

%head height
feature(1)=abs(a*head(1)+b*head(2)+c*head(3)+d)/sqrt(a^2+b^2+c^2);
%neck height
feature(2)=abs(a*neck(1)+b*neck(2)+c*neck(3)+d)/sqrt(a^2+b^2+c^2);
%neck - left shoulder
feature(3)=norm(l_shoulder-neck);
%neck - right shoulder
feature(4)=norm(r_shoulder-neck);
%torso to right shoulder
feature(5)=norm(torso-r_shoulder);
%right arm length
feature(6)=norm(r_elbow-r_hand)+norm(r_elbow-r_shoulder);
%left arm length
feature(7)=norm(l_elbow-l_hand)+norm(l_elbow-l_shoulder);
%right upper leg
feature(8)=norm(r_hip-r_knee);
%left upper leg
feature(9)=norm(l_hip-l_knee);
%torso length
feature(10)=norm(neck-torso);
%right hip - left hip
feature(11)=norm(r_hip-l_hip);
%10/8
feature(12)=feature(10)/feature(8)*100;
%10/9
feature(13)=feature(10)/feature(9)*100;

end

