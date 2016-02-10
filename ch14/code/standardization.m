%% 数据标准化到[0,1]
clear;
% 参数初始化
filename='../data/business_circle.xls';       % 数据文件
standardizedfile='../tmp/standardized.xls';  % 标准化后的数据文件

%% 读取数据
[num,txt] =  xlsread(filename);
data = num(:,2:end); % 截取需要进行转换的数据

%% 数据标准化
data = data'; % 数据转置，数据需要符合mapminmax函数要求
[ydata,ps] = mapminmax(data,0,1); % 标准化到[0,1]
ydata = ydata';

%% 标准化后数据写入文件
xlswrite(standardizedfile, ydata);
disp('数据离差标准化完成！');