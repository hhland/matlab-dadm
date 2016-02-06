%% 主成分分析 降维
clear;
% 参数初始化
inputfile = '../data/principal_component.xls';
outputfile = '../tmp/dimention_reducted.xls'; % 降维后的数据
proportion = 0.95 ; % 主成分的比例

%% 数据读取
[num,~] = xlsread(inputfile);

%% 主成分分析
[coeff,~,latent] = pca(num);

%% 计算累计贡献率，确认维度
sum_latent = cumsum(latent/sum(latent)); % 累计贡献率
dimension = find(sum_latent>proportion);
dimension= dimension(1);

%% 降维
data = num * coeff(:,1:dimension); 
xlswrite(outputfile,data);
disp('主成分特征根：');
disp(latent');
disp('主成分单位特征向量');
disp(coeff);
disp('累计贡献率');
disp(sum_latent');
disp(['主成分分析完成，降维后的数据在' outputfile]);