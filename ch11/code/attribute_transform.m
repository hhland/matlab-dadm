%% 属性变换
clear;
% 参数初始化
discfile = '../data/discdata.xls'; % 磁盘原始数据
transformeddata = '../tmp/discdata.xls'; % 变换后的数据
targetid = 184;

%% 读取数据
[num,txt] = xlsread(discfile);
txt(2:end,3)= num2cell(num(:,1));
txt(2:end,6)=num2cell(num(:,4));

%% 初始化相关变量
unidate = datestr(unique(datenum(txt(2:end,end))),26); % 唯一时间
unidisc = unique(txt(2:end,5));  % 唯一磁盘
rows = size(unidate,1);
cols = size(unidisc,1);
result = cell (rows+1,2+cols);
% 给磁盘字符串加前缀
unidiscstr = cell(1,cols);
for i =1:cols
   unidiscstr{1,i} = [txt{2,2} '|' txt{2,3} '|' num2str(targetid)...
       '|' unidisc{i,1}]; 
end
result(1,1:2)={txt{1,1},txt{1,end}};  % SYS_NAME,COLLECTTIME,disc ...
result(1,3:end)=unidiscstr;

%% 数据整合
txt = txt(2:end,:);
txt = txt(cell2mat(txt(:,3))==targetid,:);
rows = size(unidate,1);
for i= 1:rows
   smalltxt = txt(datenum(txt(:,end))==datenum(unidate(i,:)),:);
   result(i+1,1:2)={smalltxt{1,1},smalltxt{1,end}};
   result(i+1,3:end)= smalltxt(:,6)';
end

%% 数据写入
xlswrite(transformeddata,result);
disp('属性变换完成！');
