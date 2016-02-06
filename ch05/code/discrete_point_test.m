%% 基于K-Means聚类的离散点检测
clear ;
% 参数初始化
inputfile = '../data/consumption_data.xls'; % 销量及其他属性数据
k = 3; % 聚类的类别
iteration =500 ; % 聚类最大循环次数
distance = 'sqEuclidean'; % 距离函数
threshold = 20; % 离散点阈值

%% 读取数据
[num,txt]=xlsread(inputfile);
data = num(:,2:end);

%% 数据标准化
data = zscore(data);

%% 调用kmeans算法
opts = statset('MaxIter',iteration);
[IDX,C,~,D] = kmeans(data,k,'distance',distance,'Options',opts);

%% 作图查看结果
min_d = min(D,[],2);
x=1:length(min_d);
threshold_=x;
threshold_(:)=threshold;
figure
hold on
plot(x,min_d,'ko');
plot(x,threshold_,'k-');
for i=1:length(min_d)
    if min_d(i)>threshold
        plot(i,min_d(i),'k*')
        text(i+7,min_d(i)+2,num2str(min_d(i)));
    end
end
title('离散点检测');
ylabel('距离误差');
xlabel('样本号');
hold off

disp('基于K-Means聚类的离散点检测完成！');