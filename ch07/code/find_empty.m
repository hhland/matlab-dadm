function [ emptynum,emptyrate ] = find_empty( input )
%% cell列向量中查找字符串为空的个数以及比率
% 输入参数：
% input：cell列向量；

% 输出参数：
% emptynum： 空字符串个数；
% emptyrate: 空字符串比率；

rows = size(input,1);
emptynum=sum(cellfun(@isempty,input));
% 
% for i= 1:rows
%    if isempty(input{i,1})
%         emptynum=emptynum+1;
%    end
% end
emptyrate = emptynum/rows;

end

