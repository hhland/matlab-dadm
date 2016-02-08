%% 计算预测误差
clear;
% 参数初始化
file = '../data/predictdata.xls';

%% 读取数据
[num,txt] = xlsread(file);

%% 计算误差
abs_ =abs(num(:,2)-num(:,3));
% mae
mae_=mean(abs_);
% rmse
rmse_ = mean(power(abs_,2));
% mape
mape_ = mean(abs_./num(:,3));

%% 打印结果
disp(['平均绝对误差为：' num2str(mae_) ', 均方根误差为：' num2str(rmse_) ...
    ', 平均绝对百分误差为：' num2str(mape_)]);
disp('误差计算完成！');

