function [ output ] = de_abnormal( sales )
%%  去异常值,改为空

% 去异常值
abnormalvalue_ = arrayfun(@abnormal_rules_1,sales);
% output = sales(abnormalvalue_,:);
sales(~abnormalvalue_,:)=NaN;
output= sales;

end

