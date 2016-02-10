%% K-Means聚类算法
clear;
% 参数初始化
inputfile = '../tmp/zscoreddata.xls';  % 待聚类的数据文件；
k=5;                   % 需要进行的聚类类别数；
logfile = '../tmp/log.txt'; % 日志文件

%% 读取数据并进行聚类分析
[num,txt]=xlsread(inputfile);         % 读取数据
% 调用k-means算法，进行聚类分析
% 其中，type为每个样本对应的类别号，centervec为聚类中心向量；
[type,centervec] = kmeans(num,k);

%% 聚类中心写入日志文件
rows = size(centervec,1); 
for i=1:rows
    loginfo= ['聚类号为' num2str(i) '的聚类中心向量为：' ...
        num2str(centervec(i,:))];
    log_add(logfile,loginfo);
end

