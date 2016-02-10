%% 数据离散化
clear;
% 参数初始化
datafile = '../data/data.xls'; % 数据文件
processedfile='../tmp/data_processed.xls'; % 数据处理后文件
type=4; % 数据离散化的分组个数
index=8; % TNM分期数据所在列
typelabel={'A','B','C','D','E','F'}; % 数据离散化后的标识前缀
rng('default'); % 固定随机化种子

%% 读取数据 
[num,txt] = xlsread(datafile);

[rows,cols] = size(num); % 列数
disdata= cell(rows,cols+1); % 初始化

%% 聚类离散化
for i=1:cols
   [IDX,C] = kmeans(num(:,1),type,'start','cluster'); % 对单个属性列进行聚类
   [B,I] =sort(C); % 对聚类中心进行排序 
   
   for j=1:size(I,1)
       disdata(IDX==I(j),i)=cellstr([typelabel{1,i} num2str(j)]);
   end
end
disdata(:,cols+1)=txt(2:end,index);

%% 写入数据
xlswrite(processedfile,[txt(1,1:size(typelabel,2)),txt{1,index};disdata]);
disp('数据离散化完成！');
