%% LM 神经网络模型构建
clear;
% 参数初始化
trainfile = '../data/train_moment.xls'; % 训练数据
netfile = '../tmp/net.mat'; % 构建的神经网络模型存储路径
trainoutputfile = '../tmp/train_output_data.xls' ; % 训练数据模型输出文件

%% 读取数据并转化
[data,txt] = xlsread(trainfile);
input=data(:,3:end);
targetoutput=data(:,1);

% 输入数据变换
input=input';
targetoutput=targetoutput';
targetoutput=full(ind2vec(targetoutput));

%% 新建LM神经网络，并设置参数 
net = patternnet(10,'trainlm');
net.trainParam.epochs=1000;
net.trainParam.show=25;
net.trainParam.showCommandLine=0;
net.trainParam.showWindow=0; 
net.trainParam.goal=0;
net.trainParam.time=inf;
net.trainParam.min_grad=1e-6;
net.trainParam.max_fail=5;
net.performFcn='mse';

% 训练神经网络模型
net= train(net,input,targetoutput);

%% 使用训练好的神经网络测试原始数据
output = sim(net,input);

%% 画混淆矩阵图
plotconfusion(targetoutput,output);

%% 数据写入到文件
save(netfile,'net'); % 保存神经网络模型

output = vec2ind(output);
output = output';
xlswrite(trainoutputfile,[txt,'模型输出';num2cell([data,output])]);
disp('LM神经网络模型构建完成！');