function [ item,newqueue ] = queue_pop( queue )
%% 访问队列

if isempty(queue)
    disp('队列为空，不能访问！');
    return;
end

item = queue(1); % 第一个元素弹出
newqueue=queue(2:end); % 往后移动一个元素位置

end

