%% 使用BP神经网络算法预测销量高低
clear ;
% 参数初始化
inputfile = '../data/sales_data.xls'; % 销量及其他属性数据

%% 数据预处理
disp('正在进行数据预处理...');
[matrix,~] =  bp_preprocess(inputfile);

%% 输入数据变换
input = matrix(:,1:end-1);
target = matrix(:,end);
input=input';
target=target';
target=full(ind2vec(target+1));

%% 新建BP神经网络，并设置参数 
% net = feedforwardnet(10);
net = patternnet(10);
net.trainParam.epochs=1000;
net.trainParam.show=25;
net.trainParam.showCommandLine=0;
net.trainParam.showWindow=1; 
net.trainParam.goal=0;
net.trainParam.time=inf;
net.trainParam.min_grad=1e-6;
net.trainParam.max_fail=5;
net.performFcn='mse';
% 训练神经网络模型
net= train(net,input,target);
disp('BP神经网络训练完成！');

%% 使用训练好的BP神经网络进行预测
y= sim(net,input);
plotconfusion(target,y);
disp('销量预测完成！');