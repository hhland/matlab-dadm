%% 餐饮销量数据相关性分析
clear;
% 初始化参数
catering_sale = '../data/catering_sale_all.xls'; % 餐饮数据，含有其他属性
index = 1; % 销量数据所在列 

%% 读入数据
[num,txt] = xlsread(catering_sale);

%% 相关性分析
corr_ = corr(num);
%% 打印结果
rows = size(corr_,1);
for i=2:rows
    disp(['"' txt{1,2} '"和"' txt{1,1+i} '"的相关系数为：' num2str(corr_(i,1))]);
end
disp('餐饮菜品日销量相关性分析完成！');