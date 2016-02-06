%% 构建CART决策树模型

clear;
% 参数初始化
trainfile = '../data/train_model.xls'; % 训练数据
treefile = '../tmp/tree.mat'; % 构建的决策树模型存储路径
trainoutputfile = '../tmp/dt_train_output_data.xls' ; % 训练数据模型输出文件

%% 读取数据，并提取输入输出
[data,txt]=xlsread(trainfile);
input=data(:,1:end-1);
targetoutput=data(:,end);

% 使用训练数据构建决策树
tree= fitctree(input,targetoutput);

%% 使用构建好的决策树模型对原始数据进行测试
output=predict(tree,input);

% 变换数据并画混淆矩阵图
output=output';
targetoutput=targetoutput';
output= full(ind2vec(output+1));
targetoutput = full(ind2vec(targetoutput+1));
plotconfusion(targetoutput,output);

%% 保存数据
save(treefile,'tree'); % 保存决策树模型

output = vec2ind(output);
output = output';
xlswrite(trainoutputfile,[txt,'模型输出';num2cell([data,output-1])]);
disp('CART决策树模型构建完成！');