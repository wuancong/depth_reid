function feature_all = between_patch_covariance( patches )
% compute between-patch covariance
%
% input:
% patches - (y_patch_num*2-1)*(x_patch_num*2-1) cell, obtained by segment_patch
%
% output:
% feature_all - 6x6x52 matrix, feature_all(:,:,num) is a covariance matrix

y_patch_num=(size(patches,1)+1)/2;
x_patch_num=(size(patches,2)+1)/2;
feature_all=[];
num=0;
for i=1:2:x_patch_num*2-1
    for j=1:2:y_patch_num*2-1
        for ii=1:2:x_patch_num*2-1
            for jj=1:2:y_patch_num*2-1
                if i==ii && j==jj
                    continue;
                end
                  if abs(i-ii)<=2 && abs(j-jj)<=2
                    num=num+1;
                    A=patches{j,i}';
                    B=patches{jj,ii}';
                    if isempty(A) || isempty(B)
                        feature_all(:,:,num)=zeros(6);
                        continue;
                    end
                    m=size(A,2);
                    n=size(B,2);
                    AB_covariance=(n*(A)*A'+m*(B)*B'-sum(A,2)*sum(B,2)'-sum(B,2)*sum(A,2)')/(m*n);
                    feature_all(:,:,num)=AB_covariance;
                  end
            end
        end
    end
end

end

