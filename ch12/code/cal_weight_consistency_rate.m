%% 计算权值和一致性检验率
clear;
% 参数初始化
inputfile ='../data/paired_comparision.xls';
Ri=[0	0	0.58	0.90	1.12	1.24	1.32	1.41	1.45	1.49	1.51];% Ri 参考矩阵
outputfile = '../tmp/paired-comparision.xls'; % 输出文件

%% 读取数据
[num,txt]=xlsread(inputfile,1);
[rows,cols]=size(num);

%% 计算权值和随机一致性比率
%计算行向量内积
prodvalue=prod(num,2);
% 开rows次方
rootvalue=power(prodvalue,1/rows);
sumrootvalue=sum(rootvalue);
wi =rootvalue/sumrootvalue; % 权值
awi=num*wi;
awi_wi=awi./wi; 
Ci=(mean(awi_wi)-rows)/(rows-1);
consistencyrate=Ci/Ri(rows);

%% 数据写入
txt(2:end,2:end) = num2cell(num);
txt(1,cols+2:cols+3) = {'权重','CR'};
txt(2:end,cols+2) = num2cell(wi);
txt{2,cols+3}= consistencyrate;
xlswrite(outputfile,txt);
disp('随机一致性比率计算完成！');