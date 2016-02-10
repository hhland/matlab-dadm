%% 聚类数据标准化
clear ;
% 参数初始化
inputfile = '../data/cluster_data.xls';
outputfile = '../tmp/cluster_data.xls';

%% 读取数据
[num,txt,raw] = xlsread(inputfile);

%% 数据标准化
data = num(:,2:end);
data_ = zscore(data);

%% 构造输出
raw_ = raw;
raw_(2:end,2:end) = num2cell(data_);

%% 输出
xlswrite(outputfile,raw_);
disp(['标准化后的文件已写入“' outputfile '”中']);