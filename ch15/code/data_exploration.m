%% 数据探索代码
clear;
% 参数初始化
weatherfile = '../data/weatherdata.xls'; % 天气数据
defectfile = '../data/defectdata.xls' ; % 缺陷数据

%%  读取数据
[weather_num,weather_txt] = xlsread(weatherfile);
[defect_num,defect_txt] = xlsread(defectfile);
x= weather_num(:,1);

%% 自定义函数，先画条形图，然后画折线图
cols = size(defect_num,2);
for i=2:cols
    % 第i缺陷，极高温、极低温、强降水量 
    bar_line_plot(x,defect_num(:,i),defect_txt{1,i},weather_num(:,[2,3,6])...
        ,weather_txt(1,[2,3,6]));

    % 第i缺陷，高湿度、低湿度、强风力
    bar_line_plot(x,defect_num(:,i),defect_txt{1,i},weather_num(:,[4,5,7])...
        ,weather_txt(1,[4,5,7]));
end
 
disp('数据探索分析完成！');