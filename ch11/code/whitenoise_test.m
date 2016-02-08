%% 白噪声检验
clear;
% 参数初始化
discfile = '../data/discdata_processed.xls';
predictnum =5 ;  % 不检测最后5个数据
index = 3; % D盘数据所在列下标

%% 读取数据
[num,txt] = xlsread(discfile);
data = num(1:end-5,index); % 取前5个数据

%% 白噪声检测
[h,pvalue ]= lbqtest(data); 

%% 打印结果
disp(['白噪声检测p值为：' num2str(pvalue)]);
if h==1
    disp('该时间序列为非白噪声序列');
else
    disp('该时间序列为白噪声序列');
end
disp('白噪声检测完成！');