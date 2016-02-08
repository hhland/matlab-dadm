%% 模型检验
clear;
% 参数初始化
p=0;
D=1;
q=1;
filename = '../data/discdata_processed.xls';
index = 3; % D盘数据所在列下标
lagnum =12 ; % 残差延迟个数

%% 读取数据
[num,txt] = xlsread(filename);
data = num(1:end-5,index); % 取前5个数据
T = size(data,1);

%% 原始数据模拟
% 构建模型
mod = arima(p,D,q);
[EstMdl,param,logL] = estimate(mod,data,'print',false);
% 计算残差
res = infer(EstMdl,data);
stdRes = res/sqrt(EstMdl.Variance); % 标准化残差
% 白噪声检验
[h,pValue] = lbqtest(stdRes,'lags',1:lagnum);
% 计算不符合白噪声检验的个数
hsum = sum(h);

%% 打印结果
if hsum~=0
    disp(['模型arima(' num2str(p) ',' num2str(D) ',' ...
        num2str(q) ')' '不符合白噪声检验!']);
else
    disp(['模型arima(' num2str(p) ',' num2str(D) ',' ...
        num2str(q) ')' '符合白噪声检验!']);
end
disp('模型检验完成！');
