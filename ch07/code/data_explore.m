%% 数据空缺值探索,如果是字符串则返回缺失值个数，
%  如果是数值型返回缺失值个数以及最大最小值
clear;
% 参数初始化
datafile= '../data/air_data.csv' ; % 航空原始数据,第一行为属性标签
logfile = '../tmp/log.txt'; % 日志文件
resultfile = '../tmp/explore.xls'; % 数据探索结果表

%% 读取数据
[num,txt] = xlsread(datafile);
[rows,cols] = size(num);
% 初始化 结果变量
results = cell(5,cols+1);
result = zeros(4,cols);
results(:,1)= {'属性';'空记录数';'缺失率';'最大值';'最小值'};
results(1,2:end)=txt(1,:);
% 记录日志
log_add(logfile,['文件' datafile '一共有' num2str(rows) ...
     '条记录']);
 
%% 遍历所有列，进行空缺判断
for i= 1: cols
    % 判断txt每列从第二行开始 ，是否都是空串
    empty_sum = sum(cellfun(@isempty,txt(2:end,i))); % 如果是空串，则empty_sum==rows,即为数值型 
    if empty_sum==rows  % 该列为数值型
        min_ = min(num(:,i)); % 最小值
        max_ = max(num(:,i)); % 最大值
        nan_sum = sum(isnan(num(:,i)));
        nan_rate = nan_sum/rows; % 缺失率
        loginfo=['属性列' txt{1,i} '是数值型，其最大值为'...
             num2str(max_) ',最小值为' num2str(min_) ...
             ',缺失值个数为' num2str(nan_sum) '个，缺失率为' ...
             num2str(nan_rate)];
        log_add(logfile,loginfo);
%         if nan_sum~=0
%             disp(loginfo);
%         end
        result(1,i)=nan_sum;
        result(2,i)=nan_rate;
        result(3,i)=max_;
        result(4,i)=min_;
        
    else       % 该列为字符串型，接着判断txt
        [emptynum,emptyrate]= find_empty(txt(2:end,i));
        loginfo=['属性列' txt{1,i} '是字符串型，缺失值个数为' ...
            num2str(emptynum) '个，缺失率为' ...
             num2str(emptyrate)];
          log_add(logfile,loginfo);
%          if emptynum~=0
%             disp(loginfo);
%          end
        result(1,i)=nan_sum;
        result(2,i)=nan_rate;
    end
end 
 
%% 写入数据探索结果
results(2:end,2:end)=num2cell(result);
xlswrite(resultfile,results');

disp('代码运行完成！');