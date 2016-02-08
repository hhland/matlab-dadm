k=3;
out = 'tmp.xls';
[num,txt,raw] = xlsread('cluster.csv');
data = num(:,2:end-1);
data_ = zscore(data);

[idx,c]=kmeans(data_,k);
raw_=[raw,['newG';num2cell(idx)]];
xlswrite(out,raw_);
disp('done');