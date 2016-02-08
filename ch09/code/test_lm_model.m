%% LM神经网络模型测试
clear;
% 参数初始化
testfile = '../data/test_moment.xls'; % 训练数据
netfile = '../tmp/net.mat';   % 神经网络模型存储路径
testoutputfile = '../tmp/test_output_data.xls' ; % 测试数据模型输出文件

%% 数据读取
[data,txt] = xlsread(testfile);
input=data(:,3:end);
target=data(:,1);

%% 使用构建好的神经网络模型对原始数据进行测试
load(netfile);  % 载入神经网络模型
output_lm = sim(net,input');

% 测试数据数据变换以及画混淆矩阵曲线图 
targetoutput = full(ind2vec(target'));
plotconfusion(targetoutput,output_lm);

%% 写入数据
output_lm=vec2ind(output_lm);
output_lm = output_lm';
xlswrite(testoutputfile,[txt,'模型输出';num2cell([data,output_lm])]);

disp('LM神经网络模型测试完成！');