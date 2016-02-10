function [ output,code] = trans2matrix( inputfile,outputfile,splitter )
%% 把输入事务转换为0、1矩阵；每行代表一个事务

% 输入参数：
% inputfile：输入文件，空格分隔每个项目；
% outputfile：输出文件，转换后的0,1矩阵文件；
% splitter: 输入文件项目的间隔符,默认为空格

% 输出参数：
% output : 转换后的0,1 矩阵
% code：编码规则；

if nargin<3
   splitter=' '; 
end

%% 读入文件, 获得编码规则
code={};
fid= fopen(inputfile);
tline = fgetl(fid);
lines=0;
while ischar(tline)
    lines=lines+1; % 记录行数
    tline = deblank(tline);
    tline = regexp(tline,splitter,'split');
    code=[code tline]; % 合并 
    code = unique(code); % 去除重复记录
%     disp(code)
    tline = fgetl(fid);
end
disp('编码规则为：')
disp(num2str(1:size(code,2)))
disp( code);
fclose(fid); % 关闭文档

%% 读取文件，根据编码规则对原始数据进行转换
itemsnum= size(code,2);
output=zeros(lines,itemsnum);
fid= fopen(inputfile);
tline = fgetl(fid);
lines=0;
while ischar(tline)
    lines=lines+1; % 记录行数
    tline = deblank(tline);
    tline = regexp(tline,splitter,'split');
    [C,icode,itline] = intersect(code,tline);% 寻找下标
    output(lines,icode')=1;
    %disp(output(lines,:))
    tline = fgetl(fid);
end
fclose(fid);

%% 把转换后的矩阵写入文件
fid = fopen(outputfile, 'w');
for i=1:lines
   fprintf(fid,'%s\n',num2str(output(i,:))); 
end
fclose(fid);
end

