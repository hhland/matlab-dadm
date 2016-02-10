%% 数据离散化
clear;
% 参数初始化：
data = '../data/discretization_data.xls';
k = 4; 

%% 读取数据
[data,~] = xlsread(data);
rows = size(data,1);
%% 等宽离散化
% 规则需要自定义
rules = [0,0.179,0.258,0.35,0.504];
width_data = zeros(rows,2);
width_data(:,1) = data;
width_data(:,2)= arrayfun(@find_type,data);

%% 等频离散化
frequent_data = zeros(rows,2);
frequent_data(:,1) = data;
end_ =-1;
for i=1:k-1
    start_ = floor((i-1)*rows/k)+1;
    end_ = floor(i*rows/k);
    frequent_data(start_:end_,2) = i;
end
frequent_data(end_+1:end,2) = k;

%% 聚类离散化
[idx,~] = kmeans(data,k);
cluster_data = zeros(rows,2);
cluster_data(:,1) = data;
cluster_data(:,2) = idx;

%% 作图展示结果
figure
cust_subplot(width_data,3,1,1,k,'等宽离散化');
cust_subplot(frequent_data,3,1,2,k,'等频离散化');
cust_subplot(cluster_data,3,1,3,k,'聚类离散化');
disp('数据离散化完成！');