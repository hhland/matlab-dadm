function preprocess_apriori(input,output,separator)
%% 数据预处理

% 输入参数：
% input : 输入文件；
% output：输出文件；
% separator：输出文件条目分隔符；

%% 读取数据
[num,txt] = xlsread(input);
txt = txt(2:end,2);
%% 构造输出
if exist(output,'file')==2
   delete(output); 
end
rows = size(num,1);
fid = fopen(output, 'w');
 
firstid= num(1,1);
fprintf(fid,'%s',txt{1,1}); 
for i=2:rows
    secondid =num(i,1);
    if firstid~=secondid % 需要换行
        fprintf(fid,'%s\n',''); 
        
    else % 需要添加separator，
        fprintf(fid,'%s',separator);  
    end
    % 写入数据,并重新赋值id
    fprintf(fid,'%s',txt{i,1});  
    firstid = secondid;
    
end
fclose(fid);

end