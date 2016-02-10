%% 数据清洗，过滤掉不符合规则的数据
clear;
% 参数初始化
datafile = '../data/air_data.csv';  % 数据文件
cleanedfile = '../tmp/data_cleaned.csv';  % 数据清洗后保存的文件

%% 清洗空值和不符规则的数据
[num,txt]=xlsread(datafile);     
[row,col]=size(txt);

% 数据整合
for i=1:col
    % 判断txt每列从第二行开始 ，是否都是空串
    empty_sum = sum(cellfun(@isempty,txt(2:end,i))); % 如果是空串，则empty_sum==row-1,即为数值型 
    if empty_sum == row-1
       txt(2:end,i)=num2cell(num(:,i)); % 把数值型转为cell类型，并整合 
    end
%     if mod(i,500)==0
%        disp(['已整合数据' num2str(i) '条记录...']); 
%     end
end
disp(['过滤前行数：' num2str(size(txt,1))]);

% 初始化变量
txt_copy=[];
rule1_sum =0;
rule2_sum =0;

% 数据过滤
for i=2:row   % 从第二行数据行开始判断
    % 判断每一行数据是否符合规则，其中filter_data为自定义函数，
    % 如果数据符合要求则返回1，否则返回0
    [filterflag,rule1_sum,rule2_sum] = filter_data(txt(i,:),rule1_sum,rule2_sum);
    if filterflag ==0  %  不合要求,删除
        txt_copy=[txt_copy,i];  % 清除数据
    end
%     if mod(i,500)==0
%        disp(['已过滤数据' num2str(i) '条记录...']); 
%     end
end
txt(txt_copy,:)=[];
disp(['过滤后行数：' num2str(size(txt,1)-1) '，规则1过滤记录数：' num2str(rule1_sum) ...
    '规则2过滤的记录数：' num2str(rule2_sum)]);

%% 写入过滤后的数据
xlswrite(cleanedfile,txt);  % 写入数据文件

