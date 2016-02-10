function [train, test] = split2train_test( input,proportion )
%% 把输入数据随机分为训练和测试样本

% 输入参数：
% input : 原始矩阵,默认使用行作为一个样本
% proportion: 训练样本比重

% 输出参数：
% train:训练数据
% test：测试数据

rows=size(input,1);
%split=cvpartition(1:rows,'holdout',0.1);
split=randindex(rows,proportion);
train=input(split==0,:);
test=input(split==1,:);

end

function randindex=randindex(n,proportion)
%% 返回给定长度n，以及比例的数据下标
    randindex=zeros(n,1);
    rng('default'); % 固定随机化种子
    for i=1:n
       if rand(1)>proportion
           randindex(i)=1;
       end
    end
end