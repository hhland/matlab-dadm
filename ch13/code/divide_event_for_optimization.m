function [dividsequence] = divide_event_for_optimization(threshold,data)
%% 根据采集的EXCEL表数据，划分用水事件；

% 输入参数：
% threshold：划分事件时的阈值,单位：分钟；
% data：输入数据，函数输入；

% 输出参数：
% dividsequence：返回划分好的每个事件的起始数据编号与结束数据编号；
m=size(data,1);                        % 得到读取的表格的数据维数
dividsequence=zeros(0,3);              % 'dividsequence'第一列记录序号，第二列记录事件的起始数据编号，第三列记录结束数据编号
flag=0;                                % 标记是否找到用水事件
i=2;                                   % 从第二行数据开始
eventnum=0;                            % eventnum记录用水事件个数
threshold=threshold*60;
%% 划分用水事件
while(i<=m)                            % 扫描一遍数据表，得到用水事件的序号、起始编号、终止数据编号。
    if(data{i,7}~=0)                   % 当水流量不为0时
        flag=1;
        start=i;                       % 记录起始编号
        i=i+1;
        temp1=start;                   % temp1记录前一次用水不为0的数据
        while(1)                       % 找停顿次数，事件开始后，可能有停顿
            if(i==m)                   
                endsequence=m;  
                break;  
            end          % 如果已经到达数据终点，则最后一条数据的前一条为结束。
            while(data{i,7}==0)
                if(i==m)                
                    endsequence=m-1; 
                    break;  
                end          % 如果已经到达数据终点，则最后一条数据的前一条为结束，为什么是m条？
                i=i+1;
            end                        % while结束后，找到了下一条水流量不为0的数据
            temp2=i;                   % temp2记录了下一条不为0的数据
            d1=datenum(data{temp1,1},'yyyymmddHHMMSS');    % 时间用函数‘datenum’来处理
            d2=datenum(data{temp2,1},'yyyymmddHHMMSS');
            dis=(d2-d1)*86400;                             % 得到的dis是以天为单位的，换算成秒s
            if(dis>=threshold||i==m)
                endsequence=temp1;                         % 大于阈值，则该次事件的结束编号为temp1
                break;
            else
                temp1=temp2;                               % 小于阈值
            end
            if(i<=m-1)   
                i=i+1; 
            end                      % 防止溢出
        end
    end
    if(flag==1)                        % 如果标志位1，表示是有一次用水事件的，则记录这次用水事件的信息
        eventnum=eventnum+1;
        dividsequence=[dividsequence; eventnum start endsequence];
        flag=0;
        i=endsequence;                 % 下次扫描时i从endsequence开始
    end
    i=i+1;                             % 对应第24行的while
end
disp(['阈值为' num2str(threshold/60) '分钟时，得到事件划分次数为：' num2str(eventnum)]);
end
