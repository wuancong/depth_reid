function feature_all = within_patch_covariance( patches )
% compute within-patch covariance
%
% input:
% patches - (y_patch_num*2-1)*(x_patch_num*2-1) cell, obtained by segment_patch
%
% output:
% feature_all - 6x6x(y_patch_num*2-1)x(x_patch_num*2-1) matrix, feature_all(:,:,j,i) is a covariance matrix

y_patch_num=(size(patches,1)+1)/2;
x_patch_num=(size(patches,2)+1)/2;
feature_all=zeros(6,6,(y_patch_num*2-1)*(x_patch_num*2-1));
num=0;
for i=1:x_patch_num*2-1
    for j=1:y_patch_num*2-1
        feature_vectors=patches{j,i};
        num=num+1;
        if isempty(feature_vectors)
            feature_all(:,:,num)=zeros(6);
        else
            feature_all(:,:,num)=cov(feature_vectors);
        end
    end
end

end

