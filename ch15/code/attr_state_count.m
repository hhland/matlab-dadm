function [ attrCount ] = attr_state_count( labels,unique_labels )
%% 针对单个label的不同state进行计数

rows = size(unique_labels,1);
attrCount = zeros(rows,1);
for i=1:rows
    attrCount(i,1)=sum(labels==i);
end


end

