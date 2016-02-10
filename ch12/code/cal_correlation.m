%% 计算关联度
clear;
% 参数初始化
scorefile = '../data/score.xls' ; 
userinfo= '../data/user_information.xls' ;
correlationfile = '../tmp/correlation.xls';
filesnum = 7818 ; % 文件数

%% 读取数据
[score,score_txt] = xlsread(scorefile);
[user,user_txt] = xlsread(userinfo);
[rows,cols] = size(score);
[user_rows,user_cols] = size(user);
%% 计算关联度
%对文档进行分类
score_trans= zeros(rows,1);
for i=1:rows
    if score(i,19)>10^(-4);  % 阈值设为10^(-4)
        score_trans(i,1)=score(i,20);
    else
        score_trans(i,1)=0;
    end
end
%计算每个用户相关联的文档篇数
sum_user = zeros(user_rows,1);
for i=1:user_rows     
    k=0;
    for j=1:rows
        if score_trans(j,1)==user(i,1)
            k=k+1;
        end
    end
    sum_user(i,1)=k;
end
%计算各用户与舆情资源的关联度
d=sum_user/filesnum;
corr=[user(:,1) sum_user d];
corr=sortrows(corr,-3); % 排序

%% 数据写入
xlswrite(correlationfile,[{'ID','包含文档数','关联度'};num2cell(corr)]);
disp('关联度计算完成！');
