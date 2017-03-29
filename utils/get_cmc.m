function [cmc]=get_cmc(Y_gallery,Y_probe,dist)
[~, ind]=sort(dist,2);
num_probe_sample=length(Y_probe);
Y_result=Y_gallery(ind);
Y_gallery_unique=unique(Y_gallery);
num_Y_gallery_unique=length(Y_gallery_unique);
Y_result_unique=zeros(num_probe_sample,num_Y_gallery_unique);
Y_probe_rep=repmat(Y_probe,1,num_Y_gallery_unique);
for i=1:num_probe_sample
    Y_result_unique(i,:)=unique(Y_result(i,:),'stable');
end
hit=Y_result_unique==Y_probe_rep;
rankk=sum(hit)/num_probe_sample;
cmc=cumsum(rankk);
end