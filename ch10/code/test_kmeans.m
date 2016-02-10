%% 用户数据聚类分析
clear ;
% 参数初始化
inputfile = '../data/cluster_data.xls';
data_type = '../tmp/cluster_data_type.xls';
picoutput_prefix = '../tmp/pd_'; % 概率密度图文件名前缀
k=3; % 聚类个数

%% 读取数据
[num,txt,raw] = xlsread(inputfile);
data = num(:,2:end);
data_ = zscore(data); % 数据标准化

%% K-Means聚类
[idx,center] = kmeans(data_,k);

%% 构建数据
all_data = [data,idx];

%% 打印结果，并保存概率密度图和原始数据类别数据
for i=1:k
   data_i = all_data(all_data(:,end)==i,:);
   rows = size(data_i,1);
   disp(['客户群' num2str(i) ', 用户数：' num2str(rows) ', 聚类中心：' num2str(center(i,:))]);
   % 画概率密度图,自定义函数
   cust_ksdensity(data_i(:,1:end-1),i,picoutput_prefix,txt(1,2:end));
end
xlswrite(data_type,[raw,['所属类别';num2cell(idx)]]);
disp('用户聚类分区完成！');