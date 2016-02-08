%% 单个图像切割
clear;
% 参数初始化
sourcefile='../data/1_1.jpg';   % 原始图像路径名称
destfile='../tmp/1_1_processed.jpg';  % 切割后图像路径名称

%% 读取图像并截取
image_i= imread(sourcefile);
[width,length,z]=size(image_i);
subimage= image_i(fix(width/2)-50:fix(width/2)+50,fix(length/2)-50:fix(length/2)+50,:);

%% 保存切割后的数据
imwrite(subimage,destfile);
disp([sourcefile '图片截取完成！']);
