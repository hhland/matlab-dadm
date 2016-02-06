function log_add( logfile,loginfo )
%% 日志追加
% 输入参数：
% logfileid： 日志文件；
% loginfo： 需要记录的日志信息；

%% 打开日志文件
fileID = fopen(logfile,'a+'); % 以追加的方式添加日志信息
loginfo =[datestr(now) '  ' loginfo]; % 日志信息

%% 记录日志
fprintf(fileID,'%s\r\n',loginfo);  %  写入日志信息

%% 关闭日志文件
fclose(fileID);


end

