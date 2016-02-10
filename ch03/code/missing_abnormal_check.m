%% 餐饮销量数据缺失值及异常值检测
clear;
% 初始化参数
catering_sale = '../data/catering_sale.xls'; % 餐饮数据
index = 1; % 销量数据所在列 

%% 读入数据
[num,txt] = xlsread(catering_sale);
sales =num(2:end,index);
rows = size(sales,1);

%% 缺失值检测 并打印结果
nanvalue = find(isnan( sales));
if isempty(nanvalue) %  没有缺失值
    disp('没有缺失值！');
else
    rows_ = size(nanvalue,1);
    disp(['缺失值个数为：' num2str(rows_) ',缺失率为：' num2str(rows_/rows) ]);
end

%% 异常值检测 
% 箱形图上下界
q_= prctile(sales,[25,75]);
p25=q_(1,1);
p75=q_(1,2);
upper = p75+ 1.5*(p75-p25);
lower = p25-1.5*(p75-p25);
upper_indexes = sales(sales>upper);
lower_indexes = sales(sales<lower);
indexes =[upper_indexes;lower_indexes];
indexes = sort(indexes);
% 箱形图
figure
hold on;
boxplot(sales,'whisker',1.5,'outliersize',6);
rows = size(indexes,1);
flag =0;
for i =1:rows
  if flag ==0
    text(1+0.01,indexes(i,1),num2str(indexes(i,1)));
    flag=1;
  else
      text(1-0.017*length(num2str(indexes(i,1))),indexes(i,1),num2str(indexes(i,1)));
    flag=0;
  end
end
hold off;
disp('餐饮销量数据缺失值及异常值检测完成！');