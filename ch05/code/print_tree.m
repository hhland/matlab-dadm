function [nodeids_,nodevalue_] = print_tree(tree)
%% 打印树，返回树的关系向量
global nodeid nodeids nodevalue;
nodeids(1)=0; % 根节点的值为0
nodeid=0;
nodevalue={};
if isempty(tree) 
    disp('空树！');
    return ;
end

queue = queue_push([],tree);
while ~isempty(queue) % 队列不为空
     [node,queue] = queue_pop(queue); % 出队列
     
     visit(node,queue_curr_size(queue));
     if ~strcmp(node.left,'null') % 左子树不为空
        queue = queue_push(queue,node.left); % 进队
     end
     if ~strcmp(node.right,'null') % 左子树不为空
        queue = queue_push(queue,node.right); % 进队
     end
end

%% 返回 节点关系，用于treeplot画图
nodeids_=nodeids;
nodevalue_=nodevalue;
end

function visit(node,length_)
%% 访问node 节点，并把其设置值为nodeid的节点
    global nodeid nodeids nodevalue;
    if isleaf(node)
        nodeid=nodeid+1;
        fprintf('叶子节点，node: %d\t，属性值: %s\n', ...
        nodeid, node.value);
        nodevalue{1,nodeid}=node.value;
    else % 要么是叶子节点，要么不是
        %if isleaf(node.left) && ~isleaf(node.right) % 左边为叶子节点,右边不是
        nodeid=nodeid+1;
        nodeids(nodeid+length_+1)=nodeid;
        nodeids(nodeid+length_+2)=nodeid;
        
        fprintf('node: %d\t属性值: %s\t，左子树为节点：node%d，右子树为节点：node%d\n', ...
        nodeid, node.value,nodeid+length_+1,nodeid+length_+2);
        nodevalue{1,nodeid}=node.value;
    end
end

function flag = isleaf(node)
%% 是否是叶子节点
    if strcmp(node.left,'null') && strcmp(node.right,'null') % 左右都为空
        flag =1;
    else
        flag=0;
    end
end