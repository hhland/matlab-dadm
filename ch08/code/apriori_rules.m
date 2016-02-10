%% Apriori关联规则算法
clear;
% 参数初始化
inputfile = '../data/apriori.txt';% 输入事务集文件
outputfile='../tmp/as.txt';% 输出转换后0,1矩阵文件
minSup = 0.06; % 最小支持度
minConf = 0.75;% 最小置信度
nRules = 1000;% 输出最大规则数
sortFlag = 1;% 按照支持度排序
rulefile = '../tmp/rules.txt'; % 规则输出文件

%% 调用转换程序 ，把数据转换为0,1矩阵，自定义函数
[transactions,code] = trans2matrix(inputfile,outputfile,','); 

%% 调用Apriori关联规则算法，自定义函数
[Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulefile);
disp('Apriori算法调用完成！');
