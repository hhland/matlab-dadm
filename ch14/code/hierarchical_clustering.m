%% 层次聚类算法
clear;
% 参数初始化
xlabels={'工作日人均停留时间','凌晨人均停留时间'...
    '周末人均停留时间','日均人流量'};           % x轴坐标
type=3;                                       % 分群类别数
standardizedfile='../data/standardized.xls';  % 标准化后的数据文件

%% 读取数据
[num,txt] =  xlsread(standardizedfile);

%% 层次聚类
Z = linkage(num,'ward','euclidean'); 
typeindex = cluster(Z,'maxclust',type);

 %% 针对每个群组画图
for i=1:type
    data=num(typeindex==i,:);
    plotrows(data,i,xlabels);
end
