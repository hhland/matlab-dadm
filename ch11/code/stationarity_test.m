%% 平稳性检验
clear;
% 参数初始化
discfile = '../data/discdata_processed.xls';
predictnum =5 ;  % 不检测最后5个数据
index = 3; % D盘数据所在列下标

%% 读取数据
[num,txt] = xlsread(discfile);
data = num(1:end-5,index); % 取前5个数据

%% 平稳性检测
[h,pvalue ]= adftest(data); 
diffnum = 0; % 差分的次数
while h~=1
    data = diff(data);
   h =  adftest(data);
   diffnum=diffnum+1;
end

%% 打印结果
disp(['平稳性检测p值为：' num2str(pvalue) ',' ...
    num2str(diffnum) '次差分后序列归于平稳']);
disp('平稳性检测完成！');