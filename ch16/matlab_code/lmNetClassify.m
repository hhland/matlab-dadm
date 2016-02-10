function[ptrnTestAcc,ptrnTest,ppre, trnTime, tstTime]=lmNetClassify(getD,tstDNum,preD,trnPara,trnFun,midNodeNum,figPath,trnFigName,tstFigName,figSet)
%% 相关参数说明
%%%利用lm神经网络方法进行分类，
%%%输入参数
%getD，所有建模的数据
%tstDNum，数据库中，用于参与测试（检验的）实际值的个数
%preD,要进行模型预测的X影响值，这个值的赋值要和建模的影响因素的X赋值格式一致，有ID。
%trnPara，训练参数，格式如trnPara=[25;50;0.001;0.001;0.001;10;0.1;1e10];
%依次的含义为：
%显示间隔次数 25
%最大循环次数 1000
%%目标误差 0.02
%学习速率 0.001
%学习速率增加比率 0.001
%学习速率减少比率 10
%最大误差比率 1e10
%trnFun 训练函数，格式如trnFun='tansig,purelin';tansig输入层到中间层的传递函数，purelin中间层到输出层的传递函数
%midNodeNum中间层节点数
%figPath 生成图形保存路径,格式如'E:\image'，还需要在相应路径下创建文件夹,特别注意，这个路径要用
%英文的路径，不然java调用会出错。
%trnFigName，训练阶段的图形
%tstFigName，测试阶段的图形
%figSet图形设置，格式如figSet=[7;650;320];7%图形字体大小，650图形长度，320图形宽度

%%%输出参数
%ptrnTest,建模阶段和测试阶段的预测值
%ptrnTestAcc,建模和测试阶段的准确率
%ppre,预测值

close all;
% NNTWARN OFF%关闭神经网络的警告信息
nntwarn off
%% %相关数据赋值，这只在程序调试阶段用，实际通过参数传递
%   tstDNum=100;
%   preD=[251	5	4	4	5	2	4	3	;
%         259	5	5	4	4	3	5	4	];  %预测数据第一是ID，不参与建模，只有X，没有y% 
%  midNodeNum=6;
%  trnPara=[25;50;0.001;0.001;0.001;10;0.1;1e10];
%  trnFun='tansig,purelin';
%  figPath='E:\image';
%  trnFigName='lmNetStructure,lmNetTrainError,lmNetTrainFigure,lmNetTrainRelaError';
%  tstFigName='lmNetTestFigure,lmNetTestRelaError';
%  figSet=[7;650;320];
%  getD= xlsread('data.xls','data');%读入数据， 读入的数据是含有ID的，第一列不参与建模
 %get_data(3,2)=-1;
 numeric=1;
%  fldName='ZN,CU,U,高锰酸盐,T-P,石油类,COD,DO,油层类别';
%% 建模数据、测试数据分离，都含有ID
 trnD=getD(1:end-tstDNum,1:end);
 tstD=getD(end-tstDNum+1:end,1:end);
 
%% 神经网络训练
[w1,b1,w2,b2,trnAcc,ptrn,trnTime]=lmNetTrain(numeric,trnD,midNodeNum,trnPara,trnFun,figPath,trnFigName,figSet);
%输入参数
% trnD，训练所需要的数据，含有ID
% midNodeNum中间层节点数
%trnPara，训练参数，格式如trnPara=[25;50;0.001;0.001;0.001;10;0.1;1e10];
%依次的含义为：
%显示间隔次数 25
%最大循环次数 1000
%目标误差 0.02
%动量常量 0.001
%学习速率 0.001
%学习速率增加比率 0.001
%学习速率减少比率 10
%最大误差比率 1e10
% trnFun %% 训练函数，格式如trnFun='tansig,purelin';tansig输入层到中间层的传递函数，purelin中间层到输出层的传递函数
% trnFigureName训练阶段的图形
% figureSet图形设置格式如figureSet=[7;650;320];7%图形字体大小，650图形长度，320图形宽度
%输出参数
%w1,b1,w2,b2，神经网络训练后的权值
% trnAcc, 训练阶段的分类准确率
% ptrn%% 训练阶段对应分类

%% 神经网络测试 
[tstAcc,ptst,tstTime]=lmNetTest(numeric,tstD,w1,b1,w2,b2,trnFun,figPath,tstFigName,figSet);
%输入参数
% tstD，测试所需要的数据，含有ID
%w1,b1,w2,b2，神经网络训练后的权值
% trnFun%% 训练函数，格式如trnFun='tansig,purelin';tansig输入层到中间层的传递函数，purelin中间层到输出层的传递函数
% trnFigName训练阶段的图形
% figSet图形设置格式如figSet=[7;650;320];7%图形字体大小，650图形长度，320图形宽度

%输出参数
% tstAcc 测试阶段的分类准确率
% ptst 测试阶段对应的分类

%% 神经网络预测
if ~isempty(preD)
  [ppre]=lmNetPredict(preD,w1,b1,w2,b2,trnFun);
 %输入参数
% preD，预测所需要的数据，不含有类号
%w1,b1,w2,b2，神经网络训练后的权值
% trnFun%% 训练函数，格式如trnFun='tansig,purelin';tansig输入层到中间层的传递函数，purelin中间层到输出层的传递函数
 
%输出参数
%ppre预测阶段对应的分类
else
    ppre=[];
end
  %%
ptrnTestAcc=[trnAcc;tstAcc];
ptrnTest=[ptrn;ptst];


end

