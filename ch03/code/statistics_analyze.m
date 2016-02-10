%% 餐饮销量数据统计量分析
clear;
% 初始化参数
catering_sale = '../data/catering_sale.xls'; % 餐饮数据
index = 1; % 销量数据所在列 

%% 读入数据
[num,txt] = xlsread(catering_sale);
sales = num(2:end,index);
sales = de_missing_abnormal(sales,index);

%% 统计量分析
% 均值
mean_ = mean(sales);
% 中位数
median_ = median(sales);
% 众数
mode_ = mode(sales);
% 极差
range_ = range(sales);
% 标准差
std_ = std(sales);
% 变异系数
variation_ = std_/mean_;
% 四分位数间距
q1 = prctile(sales,25);
q3 = prctile(sales,75);
distance = q3-q1;

%% 打印结果
disp(['销量数据均值：' num2str(mean_) ',中位数：' num2str(median_) ',众数:' ...
    num2str(mode_) ',极差：' num2str(range_) ',标准差：' num2str(std_) ...
    ',变异系数：' num2str(variation_) ',四分位间距：' num2str(distance)]);
disp('餐饮销量统计量分析完成！');