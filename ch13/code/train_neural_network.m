%% 训练BP神经网络
clear;
% 初始化参数
inputfile = '../data/neural_network_data.xls';   % 训练数据
netfile = '../tmp/net.mat'; % 训练好的神经网络保存路径
ywind=6:16;                   % 记录被选择用来作为输入的属性
nlayer=[17,10];
trainfun='trainlm';
performfun='mse';

%% 读取数据，设置神经网络参数，并训练网络
[num,~,~]=xlsread(inputfile);   % 读入训练数据(由日志标记事件是否为洗浴)
inputdata=num(:,ywind)'; 
outputdata=num(:,5)';           % 记录教师信号所在列
net = patternnet(nlayer,trainfun,performfun);
net.trainParam.epochs=500;
net.trainParam.goal=1e-5;
net.trainParam.lr=0.05;
net.trainParam.showWindow=0;                 % 不显示训练GUI
disp('训练BP神经网络中...')
[net,tr]=train(net,inputdata,outputdata);      % 注意tr有所需的训练信息，此处为一个输出

%% 保存训练好的BP神经网络
save(netfile,'net');                  % 将训练好的神经网络保存到net.mat中
disp('训练好的BP神经网络模型存入到net.mat中！')
