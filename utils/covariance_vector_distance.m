function d2 = covariance_vector_distance( zi,zj )
num_zj=size(zj,1);
d2=zeros(num_zj,1);
dim=length(zi);
num_cov=dim/36;
c_zi=reshape(zi,6,6,num_cov);
for i=1:num_zj
     c_zj=reshape(zj(i,:),6,6,num_cov);
    for j=1:num_cov
       d2(i)=d2(i)+covariance_distance(c_zi(:,:,j),c_zj(:,:,j));
    end
end
end

function [ distance ] = covariance_distance( C1, C2 )
%COVARIANCE_DISTANCE compute distance between covariance matrices in Riemannian
%space
%C1, C2 are input covariance matrices
if(any(any(C1))==0 || any(any(C2))==0)
    distance=0;
else
    [V D]=eig(C1,C2);
    lumda=diag(D);
    distance=real(sqrt(sum(log(abs(lumda)+eps).^2)));
end
end