%% 颜色矩提取代码
clear;
% 参数初始化
filename='../data/1_1_processed.jpg';  %  图像切割后图片路径名称
outputfile = '../tmp/moment.xls'; % 颜色矩提取文件

%% 计算阶矩 
results = zeros(1,9+2);
subimage=imread(filename);  % 读取图像数据
subimage=im2double(subimage);  % 数据转换
firstmoment= mean(mean(subimage));  % 一阶矩
for m=1:3                %  针对RGB三通道分别计算
   results(1,2+m)=firstmoment(1,1,m);
   differencemoment= subimage(:,:,m)-firstmoment(1,1,m);
   secondmoment= sqrt(sum(differencemoment(:).*differencemoment(:))/101/101); % 二阶矩
   results(1,5+m)=secondmoment;
   thirdmoment= nthroot(sum(differencemoment(:).*differencemoment(:).*differencemoment(:))/101/101,3); % 三阶矩
   results(1,8+m)=thirdmoment;
end

% 提取类别和序号
index_ = strfind(filename,'/');
index_dot = strfind(filename,'_');

filename = filename(index_(1,end)+1:index_dot(1,end)-1);
index__= strfind(filename,'_');
type = filename(1:index__-1);
id = filename(index__+1:end);
results(1,1)=str2double(type);
results(1,2)=str2double(id);

%% 阶矩写入文件
result_title={'类别' '序号' 'R通道一阶矩' 'G通道一阶矩' 'B通道一阶矩' 'R通道二阶矩' ...
    'G通道二阶矩' 'B通道二阶矩' 'R通道三阶矩' 'G通道三阶矩' 'B通道三阶矩'};
result=[result_title;num2cell(results)];
xlswrite(outputfile,result);
disp('图像阶矩文件生成');
