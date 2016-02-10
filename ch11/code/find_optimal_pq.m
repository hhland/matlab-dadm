%% 确定最佳p、d,q值
clear;

% 参数初始化
discfile = '../data/discdata_processed.xls';
predictnum =5 ;  % 不检测最后5个数据
index = 3; % D盘数据所在列下标
D= 1 ; % 差分的阶次

%% 读取数据
[num,txt] = xlsread(discfile);
xdata = num(1:end-5,index); % 取前5个数据
% 确定p、q的最高阶次
length_=length(xdata);
pmin=0;
pmax=round(length_/10); % 一般阶数不超过length/10
qmin=0;
qmax=round(length_/10); % 一般阶数不超过length/10

%% p、q定阶
LOGL = zeros(pmax+1,qmax+1); %Initialize
PQ = zeros(pmax+1,qmax+1);

for p = pmin:pmax
    for q = qmin:qmax
        mod = arima(p,D,q);
        [fit,~,logL] = estimate(mod,xdata,'print',false);
        LOGL(p+1,q+1) = logL;
        PQ(p+1,q+1) = p+q;
     end
end
% 计算BIC的值
LOGL = reshape(LOGL,(qmax+1)*(pmax+1),1);
PQ = reshape(PQ,(qmax+1)*(pmax+1),1);
[~,bic] = aicbic(LOGL,PQ+1,length_);
bic=reshape(bic,pmax+1,qmax+1);

%% 打印结果
% 寻找最小BIC值下标
[bic_min,bic_index]=min(bic);
[bic_min,bic_index_]=min(bic_min);
index = [bic_index(bic_index_)-1,bic_index_-1];
disp(['p值为：' num2str(index(1,1)) ',q值为：' num2str(index(1,2)),...
    '最小BIC值为:' num2str(bic_min)]);
disp('p、q定阶完成！');

