function feature = eigen_depth( covariance )
% compute eigen-depth from covariance matrices
%
% input:
% covariance - 6x6xN matrix, N covariance matrices
%
% output:
% feature - eigen-depth feature of N matrices, dim=Nx6
reg=1;
cov_count=size(covariance,3);
feature=zeros(6,cov_count);
for i=1:cov_count
    feature(:,i)=log(reg+sort(eig(covariance(:,:,i))));
end
feature=feature(:);
end

