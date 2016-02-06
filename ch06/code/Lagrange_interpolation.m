%% 拉格朗日插值算法
clear;
% 参数初始化
inputfile='../data/missing_data.xls';   % 输入数据路径,需要使用Excel格式；
outputfile='../tmp/missing_data_processed.xls';            %输出数据路径,需要使用Excel格式

%% 拉格朗日插值
% 读入文件
data=xlsread(inputfile);
[rows,cols]=size(data);

% 按照每列进行插值处理
% 其中ployinterp_column为自定义函数，针对列向量进行插值
for j=1:cols
   data(:,j)=ployinterp_column(data(:,j)); 
end

%% 写入文件
xlswrite(outputfile,data);
