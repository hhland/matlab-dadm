%% 用水事件划分
clear;
% 初始化参数
threshold=4;                       % 阈值为分钟
inputfile='../data/water_heater.xls';           % inputfile：输入数据路径,需要使用Excel格式；
outputfile='../tmp/dividsequence.xls';   % outputfile：输出数据路径,需要使用Excel格式；

%% 读取数据
[~, ~, data]=xlsread(inputfile);
m=size(data,1);                   % 得到读取的表格的数据维数
dividsequence=zeros(0,3);          % 'dividsequence'第一列记录序号，第二列记录事件的起始数据编号，第三列记录结束数据编号
flag=0;                          % 标记是否找到用水事件
i=2;                             % 从第二行数据开始
eventnum=0;                      % eventnum记录用水事件个数
threshold=threshold*60;             % 阈值转换为秒

%% 划分用水事件 
disp('划分用水事件中......');
while(i<=m)            % 扫描一遍数据表，得到用水事件的序号、起始编号、终止数据编号
    if(data{i,7}~=0)                   % 当水流量不为0时
        flag=1;
        start=i;                      % 记录起始编号
        i=i+1;
        temp1=start;                  % temp1记录前一次用水不为0的数据
        while(1)                     % 找停顿次数，事件开始后，可能有停顿
            if(i==m)                   
                endsequence=m;  
                break;  
            end          % 如果已经到达数据终点，则最后一条数据的前一条为结束。
            while(data{i,7}==0)
                if(i==m)                
                    endsequence=m-1; 
                    break;  
                end      % 如果已经到达数据终点，则最后一条数据的前一条为结束 
                i=i+1;
            end          % while结束后，找到了下一条水流量不为0的数据
            temp2=i;      % temp2记录了下一条不为0的数据
            d1=datenum(data{temp1,1},'yyyymmddHHMMSS');    % 时间用函数‘datenum’来处理
            d2=datenum(data{temp2,1},'yyyymmddHHMMSS');
            dis=(d2-d1)*86400;               % 得到的dis是以天为单位的，换算成秒s
            if(dis>=threshold||i==m)
                endsequence=temp1;          % 大于阈值，则该次事件的结束编号为temp1
                break;
            else
                temp1=temp2;               % 小于阈值
            end
            if(i<=m-1)   
                i=i+1; 
            end                            % 防止溢出
        end
    end
    if(flag==1)       % 如果标志为1，表示是有一次用水事件的，则记录这次用水事件的信息
        eventnum=eventnum+1;
        dividsequence=[dividsequence; eventnum start endsequence];
        flag=0;
        i=endsequence;                 % 下次扫描时i从endsequence开始
    end
    i=i+1;                             % 对应第24行的while
end
disp('划分用水事件完成！');
%% 将划分得到的结果写到excel中
if  exist(outputfile,'file')  % 如果已存在该文档，则将文档清空(以防多次跑出的结果写入时重叠)
    delete(outputfile);
end
output={'事件序号','事件起始编号','事件终止编号'};
xlswrite(outputfile,output);
xlswrite(outputfile,dividsequence,1,'A2');
disp('划分结果写入到excel中完成！');
