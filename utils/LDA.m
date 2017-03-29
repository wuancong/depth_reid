function [ W, Z ] = LDA( X, Y, n )
%LDA
%input:
%X: feature matrix, each column is an observation
%Y: label
%n: subspace dimension
%output:
%W: projection matrix
%Z: feature matrix in subspace, Z=W'*X;
d=size(X,1);
all_class=unique(Y');
X_mean=mean(X,2);
num_c=length(all_class);
if nargin<3
    n=num_c-1;
end
Sw=zeros(d,d);
Sb=zeros(d,d);
for c=1:num_c
    Xc=X(:,Y==all_class(c));
    Xc_mean=mean(Xc,2);
    Nc=size(Xc,2);%number of samples of class c
    X_Mi=Xc-repmat(Xc_mean,1,Nc);
    Si=X_Mi*X_Mi';
    Sw=Sw+Si;
    Mi_M=Xc_mean-X_mean;
    Sb=Sb+Nc.*Mi_M*Mi_M';
end
[eigvec,eigval_matrix]=eig(Sw\Sb);
eigval=diag(eigval_matrix);
[~,sort_eigval_index]=sort(eigval,'descend');
W=eigvec(:,sort_eigval_index(1:min(n,end)));
for i_W=1:size(W,2)
    W(:,i_W)=W(:,i_W)/sqrt(W(:,i_W)'*Sw*W(:,i_W));
end
Z=W'*X; 
