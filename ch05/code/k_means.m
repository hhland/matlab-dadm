%% 使用K-Means算法聚类消费行为特征数据
clear ;
% 参数初始化
inputfile = '../data/consumption_data.xls'; % 销量及其他属性数据
k = 3; % 聚类的类别
iteration =500 ; % 聚类最大循环次数
distance = 'sqEuclidean'; % 距离函数

%% 读取数据
[num,txt]=xlsread(inputfile);
data = num(:,2:end);

%% 数据标准化
data = zscore(data);

%% 调用kmeans算法
opts = statset('MaxIter',iteration);
[IDX,C,~,D] = kmeans(data,k,'distance',distance,'Options',opts);

%% 打印结果
for i=1:k
   disp(['第' num2str(i) '组聚类中心为：']);
   disp(C(i,:));
end

disp('K-Means聚类算法完成！');