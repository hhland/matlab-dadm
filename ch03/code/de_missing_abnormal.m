function [ output ] = de_missing_abnormal( sales,index )
%%  去缺失值和异常值

% 去缺失值
nanvalue_ = ~isnan( sales(:,index));
sales =sales(nanvalue_,:);
% 去缺失值
abnormalvalue_ = sales(:,index)>=400;
sales = sales(abnormalvalue_,:);
abnormalvalue_ = sales(:,index) <=5000;
output = sales(abnormalvalue_,:);

end

