%% 谱系聚类图
clear;
% 参数初始化
standardizedfile='../data/standardized.xls';  % 标准化后的数据文件

%% 读取数据
[num,txt] =  xlsread(standardizedfile);

%% 谱系聚类图
Z = linkage(num,'ward','euclidean');
% 画谱系聚类图
dendrogram(Z,0);
