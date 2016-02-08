function [ filteredrules ] = filter_rules(rulesfile, rules,outputfile )
%% 根据规则的后项，过滤规则并输出到文件

% 输入参数
% rulesfile：规则文件；
% rules：要过滤的后项名称；
% outputfile：过滤后关联规则名称；

% 输出参数
% filteredrules: 过滤后的规则

%% 写入输出文件首行
fid = fopen(outputfile, 'w');
fprintf(fid, '%s   (%s, %s) \n', 'Rule', 'Support', 'Confidence');

%% 遍历输入文件，过滤规则
fid_in= fopen(rulesfile);
tline = fgetl(fid_in);
lines=0;
filteredrules={};
while ischar(tline)
    index=strfind(tline,rules);
    if ~isempty(index)
        lines=lines+1; % 记录行数
        fprintf(fid,'%s\n',tline);
        filteredrules=[filteredrules tline];
    end
    tline = fgetl(fid_in);
end

%% 关闭文件
fclose(fid_in);
fclose(fid);
disp(['过滤后的关联规则有' num2str(lines) '条记录！']);
disp(['存储规则到文件到‘' outputfile '’完成！'])
end

