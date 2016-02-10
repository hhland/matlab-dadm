%% 提取访问数据，把同一个ID的数据进行聚合
clear;
% 参数初始化
inputfile = '../data/visit_data.xls'; % sessionID访问数据
outputfile = '../tmp/visit_data.txt'; % 聚合后的数据文件
separator = ','; % 聚合后的访问数据的分隔符

%% 读取数据
[num,txt] = xlsread(inputfile);
txt = txt(2:end,2);

%% 检查文件是否存在，存在则删除
if exist(outputfile,'file')==2 % 避免多次运行影响
    disp(['文件' outputfile '存在，正在被删除...']);
   delete(outputfile); 
end

%% 构造输出
rows = size(num,1);
fid = fopen(outputfile, 'w'); 
firstid= num(1,1);
fprintf(fid,'%s\t%s',num2str(firstid),txt{1,1}); 
for i=2:rows
    secondid =num(i,1);
    if firstid~=secondid % 需要换行
        fprintf(fid,'%s\n%s\t','',num2str(secondid)); 
        
    else % 需要添加separator，
        fprintf(fid,'%s',separator);  
    end
    % 写入数据,并重新赋值id
    fprintf(fid,'%s',txt{i,1});  
    firstid = secondid;    
end
fclose(fid);

%% 打印结果
disp(['数据已经按照sessionID进行聚合，聚合后的数据存储在“' outputfile '”文件中！']);