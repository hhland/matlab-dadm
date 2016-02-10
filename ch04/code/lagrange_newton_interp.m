%% 拉格朗日插值和牛顿插值对比
clear;
% 参数初始化
inputfile = '../data/catering_sale.xls' ; % 销量数据文件
index =1; % 销量数据所在下标
outputfile ='../tmp/sales.xls';  % 插值后数据存放

%% 读入数据
[num,txt,raw] = xlsread(inputfile);
data = num(:,index);

%% 去除异常值
data = de_abnormal(data);

%% 调用拉格朗日进行插值
la_data = ployinterp_column(data,'lagrange');

%% 调用牛顿算进行插值
new_data = ployinterp_column(data,'newton');

%% 结果写入文件
rows = size(data,1);
result = cell(rows+1,3);
result{1,1}='原始值';
result{1,2}='拉格朗日插值';
result{1,3}='牛顿插值';

result(2:end,1)= num2cell(data);
result(2:end,2)= num2cell(la_data);
result(2:end,3)= num2cell(new_data);
xlswrite(outputfile,result);
disp('拉格朗日插值和牛顿插值结果已写入数据文件！');