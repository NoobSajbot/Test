%Version 1.1
clear all
close all
clc

load('DataSet_New.mat')
% X = meas(:,1:4);
X=DataSet(:,21:end);

nMin=1;
nMax=1000;

bcd=0;
wcd=0;
nIter_max=3;
for k=nMin:nMax
    nIter=1;
    while nIter<nIter_max
        [idx_i,C_i, sumD_i, D_i] = kmeans(X,k);
        ClustIndices(:,k-nMin+1)=idx_i;
        for i=1:k
            n(i,1)=length(find(idx_i==i));
        end
        
        [idx_tot, C_tot, sumD_tot, D_tot]=kmeans(C_i,1);
        
        bcd=sum(D_tot.*n)/(sum(n)*k);
        wcd=sum(sumD_i./n);
        
        nIter=nIter+1
    end
    
    SF(k-nMin+1)=1-(1/exp(exp(bcd-wcd)));
    nClust(k-nMin+1)=k;
end
plot(nClust, SF)
[~, idx]=max(SF);
k_opt=nClust(idx);
idx_opt=ClustIndices(:,idx);
