function [ SF, k_opt, idx_opt] = f_KmeansWithSF( X, nMin, nMax )
%f_KmeansWithSF k-means clustering with scoring function
%   INPUTS:
%     X       --> Data for clustering
%     nMin    --> minimum number of clusters to evaluate in data
%     nMax    --> maximum number of clusters to consider
%     
%     OUTPUTS:
%     SF      --> Scoring function value for various number of clusters
%     k_opt   --> Optimal number of clusters
%     idx_opt --> Cluster indices for optimal number of clusters

%% for reference
%Saitta S., Raphael B. and Smith I.F.C., "A Bounded Index for Cluster
%Validity", Machine Learning and Data Mining in Pattern Recognition, LNAI
%4571, Springer, Heidelberg, pp. 174-187, 2007.

%%

for k=nMin:nMax
[idx_i,C_i, sumD_i, D_i] = kmeans(X,k);
ClustIndices(:,k-nMin+1)=idx_i;
for i=1:k
    n(i,1)=length(find(idx_i==i));
end

[idx_tot, C_tot, sumD_tot, D_tot]=kmeans(C_i,1);

bcd=sum(D_tot.*n)/(sum(n)*k);
wcd=sum(sumD_i./n);

SF(k-nMin+1)=1-(1/exp(exp(bcd-wcd)));
nClust(k-nMin+1)=k;
plot(nClust, SF)
end

[~, idx]=max(SF);
k_opt=nClust(idx);
idx_opt=ClustIndices(:,idx);

end

