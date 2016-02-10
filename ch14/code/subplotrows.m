function subplotrows(type,data,i,xlabels)
%% 画一个图太小了 ，而且坐标不能旋转
[rows,cols] = size(data);

subplot(ceil(type/2),2,i);
title(['商圈类别' num2str(i)]);
hold on;
for k=1:rows
    plot(1:cols,data(k,:),'-k');
end
hold off;
set(gca,'xtick',1:cols);
set(gca,'xticklabel',xlabels);
% h = gca;
%  rotateticklabel(h, 45);%调用下面的函数，坐标倾斜45度

end