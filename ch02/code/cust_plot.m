%% 定制作图
clear;
% 初始化参数
tsfile = '../data/time_series.xls'; % 时间序列所在路径；
tspic = '../tmp/time_series.png' ;  % 时间序列图保存路径；

%% 读取时间序列
[num,txt] = xlsread(tsfile);

%% 定制作图
h=figure ;
set(h,'Visible','off'); % 直接保存，不需弹框
plot(num(:,1),num(:,2),'-ok'); % 使用-o连接，颜色为黑色
xlabel(txt{1,1});
ylabel(txt{1,2});
title('时间序列图');

%% 保存图片
print(h,'-dpng',tspic);