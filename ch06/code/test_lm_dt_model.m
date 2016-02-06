%% LM神经网络和CART决策树模型测试
clear;
% 参数初始化
testfile = '../data/test_model.xls'; % 训练数据
treefile = '../tmp/tree.mat'; % 决策树模型存储路径
netfile = '../tmp/net.mat';   % 神经网络模型存储路径
dttestoutputfile = '../tmp/dt_test_output_data.xls' ; % 测试数据模型输出文件
lmtestoutputfile = '../tmp/lm_test_output_data.xls' ; % 测试数据模型输出文件

[data,txt] = xlsread(testfile);
input = data(:,1:end-1);
target = data(:,end);

%% 使用构建好的决策树模型对原始数据进行测试
load(treefile); % 载入决策树模型
output_tree=predict(tree,input);

% 决策树输出数据变换以及画ROC曲线图
output_tree= full(ind2vec(output_tree'+1));
targetoutput = full(ind2vec(target'+1));
figure(1)
plotroc(targetoutput,output_tree);

%% 使用构建好的神经网络模型对原始数据进行测试
load(netfile);  % 载入神经网络模型
output_lm = sim(net,input');

% 测试数据数据变换以及画ROC曲线图 
figure(2)
plotroc(targetoutput,output_lm);

%% 写入数据
output_lm=vec2ind(output_lm);
output_lm = output_lm'-1;
output_tree=vec2ind(output_tree);
output_tree=output_tree'-1;
xlswrite(lmtestoutputfile,[txt,'模型输出';num2cell([data,output_lm])]);
xlswrite(dttestoutputfile,[txt,'模型输出';num2cell([data,output_tree])]);
disp('CART决策树模型和LM神经网络模型测试完成！');