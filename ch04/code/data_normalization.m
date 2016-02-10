%% 数据规范化
clear;
% 参数初始化：
data = '../data/normalization_data.xls';

%% 读取数据
[data,~] = xlsread(data);

%% 最小-最大规范化
data_scatter = mapminmax(data',0,1); % 数据需要转置
data_scatter = data_scatter';

%% 零-均值规范化
data_zscore = zscore(data);

%% 小数定标规范化
max_ = max(abs(data));
max_ = power(10,ceil(log10(max_)));
cols = size(max_,2);
data_dot = data;
for i=1:cols
    data_dot(:,i)=data(:,i)/max_(1,i);
end

%% 打印结果
disp('原始数据为：');
disp(data);
disp('最小-最大规范化后的数据为：');
disp(data_scatter);
disp('零-均值规范化后的数据为：');
disp(data_zscore);
disp('小数定标规范化后的数据为：');
disp(data_dot);