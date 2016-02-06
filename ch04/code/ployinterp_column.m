function outputdata= ployinterp_column(columndata,type)
%% 针对每列进行插值

% 输入参数说明：
% columndata: 输入的列数据，含有缺失值
% type: 'lagrange' 或'newton' 

% 输出参数说明：
% output: 输出插值过的数据

%% 把输入列数据分为非缺失值和缺失值数据
nans = isnan(columndata);  %  区分columndata中为NaN的数据下标
notzeroIndexes = find(nans); % 寻找缺失值下标
%zeroIndexes = find(nans==0); % 寻找非缺失值下标
rows=size(columndata); %原始数据的行数 
%currentValues=zeros(size(zeroIndexes));% 初始化当前值矩阵
for i=1:size(notzeroIndexes)
    pre5=findPre5(notzeroIndexes(i),columndata);
    last5=findLast5(notzeroIndexes(i),rows(1),columndata);
    [~,pre5cols]=size(pre5);
    [~,last5cols]=size(last5);
    
    if   strcmp(type,'lagrange')
        missingValue=lagrange_interp([1:pre5cols,pre5cols+2:last5cols+pre5cols+1],...
            [pre5,last5],pre5cols+1); % 拉格朗日插值
    else
        missingValue=newton_interp([1:pre5cols,pre5cols+2:last5cols+pre5cols+1],...
            [pre5,last5],pre5cols+1); % 牛顿插值
    end
    columndata(notzeroIndexes(i),1)=missingValue;
end


% 返回插值后的数据
outputdata=columndata;

end


function pre5=findPre5(index,columndata)
%% 在columndata中寻找给定下标index前面5个数值（非NaN），不足5个的按实际情况返回
if index<=0
    disp('非法下标');
    exit; 
end
num=5;
pre5=nan(1,5);
for i=index-1:-1:1
    if isnan(columndata(i))==0  % 判断第i个值是否为NaN
        pre5(num)=columndata(i);
        num=num-1;
    end
    if num==0 % 只取前5个
        break;
    end
end
pre5=pre5(~isnan(pre5)); % 去除NaN的值
end 

function last5=findLast5(index,rows,columndata)
%% 在columndata中寻找给定下标index后面5个数值（非NaN），不足5个的按实际情况返回
if index<=0 || index>rows
    disp('非法下标');
    exit; 
end
num=0;
last5=nan(1,5); % 初始化
for i=index+1:rows
    if isnan(columndata(i))==0  % 判断第i个值是否为NaN
        num=num+1;
        last5(num)=columndata(i); 
    end
    if num==5 % 只取后5个
        break;
    end
end
last5=last5(~isnan(last5)); % 去除NaN的值
end
