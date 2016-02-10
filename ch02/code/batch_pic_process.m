%% 图片批量截取
clear;
% 初始化参数
picdir = '../data/images/' ;  % 图片所在文件夹
picsave = '../tmp/';          % 截取图片保存文件夹
logfile = '../tmp/log.txt' ;  % 日志文件所在路径
momentfile ='../tmp/moment.xls'; % 图片阶矩存储路径

%% 日志文件初始化
fileID = fopen(logfile,'a+'); % 以追加的方式添加日志信息
loginfo =[datestr(now) '  ' '日志初始化完成']; % 日志信息
fprintf(fileID,'%s\r\n',loginfo);  %  写入日志信息 

%% 图片名批量获取
inputfolder=dir(picdir);
inputfolder=struct2cell(inputfolder);
inputfolder=inputfolder';
isdirs=cell2mat(inputfolder(:,4));
num= sum(isdirs==0);% 图片的数量
images=inputfolder(:,1);
images=images(isdirs==0);  % 图片名
% 日志记录
loginfo =[datestr(now) '   ' '图片所在文件夹为：' picdir ...
    ',一共有' num2str(num) '个图片'];
fprintf(fileID,'%s\r\n',loginfo);

%% 图片批量截取和保存
rows = size(images,1);
moment = zeros(rows,3); % 初始化一阶矩变量
for i= 1:rows
    % 日志记录
    loginfo =[datestr(now) '   ' '正在处理第' num2str(i) ...
    '个图片，文件名为' images{i,1} ];
    fprintf(fileID,'%s\r\n',loginfo);
    imdata_i = imread([picdir images{i,1}]); % 读取图片文件
    [width,length,z]=size(imdata_i);
    subimage= imdata_i(fix(width/2)-50:fix(width/2)+50,...
        fix(length/2)-50:fix(length/2)+50,:); % 图片截取
    imwrite(subimage,[picsave images{i,1}]); % 保存图片
    % 计算截取图片后一阶矩
    subimage=im2double(subimage); % 数据转换
    firstmoment= mean(mean(subimage));% 一阶矩
    for j=1:3
        moment(i,j)=firstmoment(1,1,j);
    end
end

%% 保存数据 关闭日志文件
xlswrite(momentfile,moment); % 把阶矩数据写入EXCEL文件
% 日志记录
loginfo =[datestr(now) '   ' '阶矩数据已写入文件' ];
fprintf(fileID,'%s\r\n',loginfo);

fclose(fileID); % 关闭日志文件