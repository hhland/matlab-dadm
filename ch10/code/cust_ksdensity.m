function cust_ksdensity(data_i,i,picoutput_prefix,txt)
% data_i:第i类的全部数据；
% i:第i类；
% txt: 属性名；

%% 画图
cols = size(data_i,2);
figure;
attributes = size(txt,2);
rows =ceil( attributes/2);
for j=1:cols
    [f,xi] = ksdensity(data_i(:,j));
    subplot(2,rows,j);
    plot(xi,f);
    title(txt{1,j});
    ylabel('密度');
    set(get(gca,'xlabel'),'fontweight','bold','fontsize',12);
    set(get(gca,'ylabel'),'fontweight','bold','fontsize',12);
    set(get(gca,'title'),'fontweight','bold','fontsize',12);
end

%% 保存图片
set(gcf,'Position',[100,200,500,300]); % 设置图片大小
set(gcf,'visible','off'); % 设置不弹出框
% set(gca,'FontSize',20,'FontWeight','bold');
picfile = [picoutput_prefix 'type' num2str(i) '.png'];
print(gcf,'-dpng',picfile);
disp(['客户群' num2str(i) '的频率密度图已保存在‘' picfile '’']);
end