%% 线损率属性构造
clear;
%初始化参数
inputfile= '../data/electricity_data.xls';       % 供入供出电量数据
outputfile = '../tmp/electricity_data.xls';  % 属性构造后数据文件

%% 读取数据
[num,txt,raw]=xlsread(inputfile);                   % 数据第一列为供入电量，第二列为供出电量
[rows,cols] = size(num);

%% 构造属性
loss = (num(:,1)-num(:,2))./num(:,1);

%% 保存结果
result = cell(rows+1,cols+1);
result(:,1:cols) =raw;
result{1,cols+1} = '线损率';
result(2:end,cols+1) = num2cell(loss);
xlswrite(outputfile,result);
disp('线损率属性构造完毕！');
