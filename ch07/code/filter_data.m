function  [filterflag,rule1_sum,rule2_sum] = filter_data(txtdata,rule1_sum,rule2_sum)
%% 根据过滤规则返回是否符合过滤条件
% 票价为空的数据，SUM_YR_1（下标15） 、SUM_YR_2（下标16） 任一为空
% 票价为0、平均折扣率不为0、总飞行公里数大于0的数据 
% SUM_YR_1（下标15） 、SUM_YR_2（下标16） 都为零
% AVG_DISCOUNT （下标为29）不等于0
% SEG_KM_SUM （下标为17）大于零；

% 输入参数：
% txtdata： 一行数据，cell向量；
% rule1_sum : 规则一过滤的记录数
% rule2_sum : 规则二过滤的记录数

% 输出数据：
% filterflag：0：数据不符合要求，1:数据符合要求；
% rule1_sum : 规则一过滤的记录数
% rule2_sum : 规则二过滤的记录数

%% 过滤 
index_15 = txtdata{1,15};
index_16 = txtdata{1,16};

% 第一个过滤条件
if isnan(index_15)||isnan(index_16)||isempty(index_15) || isempty(index_16)
    filterflag =0;
    rule1_sum=rule1_sum+1;
    return; 
end
% 第二个过滤条件
index_17 = txtdata{1,17};
index_29 = txtdata{1,29};

if index_15==0 && index_16==0
    if index_17>0 && index_29~=0
       filterflag=0;
       rule2_sum=rule2_sum+1;
       return;
    end
end
filterflag=1;