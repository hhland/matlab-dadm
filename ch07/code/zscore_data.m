%% 标准差标准化
clear;
% 参数初始化
datafile = '../data/zscoredata.xls';  % 需要进行标准化的数据文件；
zscoredfile = '../tmp/zscoreddata.xls'; % 标准差化后的数据存储路径文件；

%% 标准化处理
[data,txt]=xlsread(datafile);  
zscoredata = zscore(data) ;  % 其中zscore函数为MATLAB内置的标准化函数

%% 数据写入
xlswrite(zscoredfile,[txt;num2cell(zscoredata)]);