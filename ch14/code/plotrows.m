function plotrows( data,i ,xlabels)
%% 画图

[rows,cols] = size(data);
figure(100+i);
hold on;
for k=1:rows
   plot(1:cols,data(k,:),'-ok');
end

hold off;

%  设置坐标
title(['商圈类别' num2str(i)]);
set(gca,'xtick',1:cols);
set(gca,'xticklabel',xlabels);

 
% h = gca;
% rotateticklabel(h, 45);%调用下面的函数，坐标倾斜45度

end

