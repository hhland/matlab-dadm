%% 电子商务智能推荐 Apriori关联规则挖掘
clear;
% 参数初始化
inputfile = '../data/visit_data.xls';
preprocessedfile = '../tmp/visit_data.txt';
outputfile='../tmp/as.txt';% 输出转换后0,1矩阵文件
rulefile = '../tmp/rules.txt'; % 规则输出文件
minSup = 0.01; % 最小支持度
minConf = 0.70;% 最小置信度
nRules = 1000;% 输出最大规则数
sortFlag = 1;% 按照支持度排序
separator = ','; % 分隔符

%% 数据预处理，根据sessionID对访问数据进行聚合
preprocess_apriori(inputfile,preprocessedfile,separator);

%% 数据编码
[transactions,code] = trans2matrix(preprocessedfile,outputfile,separator); 

%% 调用Apriori关联规则算法
[Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulefile);
disp('Apriori关联规则算法测试完成！');
