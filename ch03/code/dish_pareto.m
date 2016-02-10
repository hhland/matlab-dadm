%% 菜品盈利数据 帕累托图
clear;
% 初始化参数
dish_profit = '../data/catering_dish_profit.xls'; % 餐饮菜品盈利数据

%% 读入数据
[num,txt,raw] = xlsread(dish_profit);

%% 帕累托图作图
rows = size(num,1);
hold on;
% 计算累计系数
yy_ = cumsum(num(:,end));
yy=yy_/yy_(end)*100;
[hAx,hLine1,hLine2]=plotyy(1:rows,num(:,end),1:rows,yy,'bar','plot');
set(hAx(1),'XTick',[])%去掉x轴的刻度
set(hLine1,'BarWidth',0.5);
set(hAx(2), 'XTick', 1:rows);  
set(hAx(2),'XTickLabel',raw(2:end,2));
ylabel(hAx(1),'盈利：元') % left y-axis
ylabel(hAx(2),'累计百分比：%') % right y-axis
set(hLine2,'LineStyle','-')
set(hLine2,'Marker','d')
% 标记 80% 点
index = find(yy>=80);
plot(index(1),yy(index(1))*100,'d', 'markerfacecolor', [ 1, 0, 0 ] );
text(index(1),yy(index(1))*93,[num2str(yy(index(1))) '%'] );
hold off;

disp('餐饮菜品盈利数据帕累托图作图完成！');