function print_hsnode(node,level,unique_labels,attributes)
%% 打印hotspot规则树

% 输入参数：
% node： 节点
% level： 节点的级数，根节点为0

print_level_tab(level); % 打印level个tab
fprintf('%s\n',node_2_string(node,unique_labels,attributes)); % 打印当前节点
children = node.children;
cols = size(children,2);
for i=1:cols
    print_hsnode(children(1,i),level+1,unique_labels,attributes); % 递归打印节点
end
end

function print_level_tab(level)
%     fprintf('叶子节点，node: %d\t，属性值: %s\n', ...
%         nodeid, node.value);
if level==0
    return ; % 不打印
end
for i=1:level
    fprintf('|\t');
end
end

