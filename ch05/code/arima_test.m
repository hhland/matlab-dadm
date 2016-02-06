%% arima时序模型
clear;

% 参数初始化
discfile = '../data/arima_data.xls';
forecastnum = 5;
%% 读取数据
[num,txt] = xlsread(discfile);
xdata = num; 

%% 时序图
figure;plot(xdata);
xx =1:8:length(xdata);
set(gca,'xtick',xx);
set(gca,'xticklabel',txt(xx+1,1));
title('原始销量数据时序图');
xlabel('时间');
ylabel('销量：元');

%% 自相关图
figure;autocorr(xdata,12);

%% 平稳性检测
data =xdata;
[h,pvalue ,stat,cValue,reg]= adftest(data); 
fprintf('原始数据的平稳性检验p值：%s,stat：%s,cValue:%s,reg:\n',...
    num2str(pvalue),num2str(stat),num2str(cValue));
disp(reg);
disp('reg.tStats和reg.FStat');
disp(reg.tStats);
disp(reg.FStat);

[~,pvalue,stat,cValue ]= lbqtest(data,'lags',6); 
fprintf('原始数据的白噪声检验p值：%s,stat：%s,cValue:%s\n',...
    num2str(pvalue),num2str(stat),num2str(cValue));
diffnum = 0; % 差分的次数
while h~=1
    data = diff(data);
   [h,pvalue,stat,cValue,reg] =  adftest(data);
   diffnum=diffnum+1;
end
% 打印结果
disp(['平稳性检测p值为：' num2str(pvalue) ',' ...
    num2str(diffnum) '次差分后序列归于平稳']);
fprintf(',stat：%s,cValue:%s,reg:\n',...
    num2str(stat),num2str(cValue));
disp(reg);
disp('reg.tStats和reg.FStat');
disp(reg.tStats);
disp(reg.FStat);
%% 白噪声检测
[~,pvalue ,stat,cValue]= lbqtest(data,'lags',6); 

%% 打印结果
fprintf('一阶差分后白噪声检测p值为：%s,stat：%s,cValue:%s,reg:\n',...
    num2str(pvalue),num2str(stat),num2str(cValue));

if pvalue<0.05
    fprintf('该时间序列为非白噪声序列\n');
else
    fprintf('该时间序列为白噪声序列\n');
end
%% 差分后时序图
figure;plot(data);
xx =1:8:length(data);
set(gca,'xtick',xx);
set(gca,'xticklabel',txt(xx+1,1));
title('差分销量数据时序图');
xlabel('时间');
ylabel('销量残差：元');
%% 自相关图
figure;autocorr(data,12);
%% 偏相关图
figure;parcorr(data,12);

D=diffnum;
%% 确定最佳p、d,q值
% 确定p、q的最高阶次
length_=length(xdata);
pmin=0;
qmin=0;

pmax=round(length_/10); % 一般阶数不超过length/10
qmax=round(length_/10); % 一般阶数不超过length/10

%% p、q定阶
LOGL = zeros(pmax+1,qmax+1); %Initialize
PQ = zeros(pmax+1,qmax+1);

for p = pmin:pmax
    for q = qmin:qmax
        mod = arima(p,D,q);
        fprintf('当前p:%d,q:%d',p,q);
        try
            [~,~,logL] = estimate(mod,xdata,'print',false);
        catch
            logL = -realmax;
            fprintf(',*************报错!');
        end
        fprintf('\n');
        LOGL(p+1,q+1) = logL;
        PQ(p+1,q+1) = p+q;
     end
end
% 计算BIC的值
fprintf('计算完成');
LOGL = reshape(LOGL,(qmax+1)*(pmax+1),1);
PQ = reshape(PQ,(qmax+1)*(pmax+1),1);
[~,bic] = aicbic(LOGL,PQ+1,length_);
bic=reshape(bic,pmax+1,qmax+1);
disp('bic矩阵是：');
disp(bic);
% 寻找最小BIC值下标
[bic_min,bic_index]=min(bic);
[bic_min,bic_index_]=min(bic_min);
index = [bic_index(bic_index_)-1,bic_index_-1];
p = index(1,1);
q= index(1,2);
disp(['p值为：' num2str(p) ',q值为：' num2str(q),...
    '最小BIC值为:' num2str(bic_min)]);
disp('p、q定阶完成！');

%% 模型参数打印，以及残差
 mod = arima(p,D,q);
[EstMdl,~,logL] = estimate(mod,xdata,'print',true);
% 计算残差
[res,v] = infer(EstMdl,xdata);
stdRes = res./sqrt(v); % 标准化残差
% 残差白噪声检验
[h,pvalue ]= lbqtest(res);
if pvalue<0.05
    fprintf('残差为非白噪声序列，p值为：%f \n',pvalue);
else
    fprintf('残差为白噪声序列，p值为：%f \n',pvalue);
end

%% 模型预测
[ydata] = forecast(EstMdl,forecastnum,'Y0',xdata);
disp('模型的预测值为：');
disp(ydata');