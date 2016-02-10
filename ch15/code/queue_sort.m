function queue = queue_sort(queue,num,type)
%% 排序
% queue： 其数据结构为： {'attrIndex',attrIndex,'stateIndex',stateIndex,...
%  'stateCount', stateCount,'allCount',allCount,'support',support,'lessThan',lessThan}
% num ：返回排序的前num个
% type：升序或降序 'descend':降序 ，'ascend'： 升序

% 先按stateCount 降序排序，再按support降序排序
% 这样可以最终的排序即是先按support降序排序，然后在stateCount 降序排序

% [~,b_i] = sort([queue.stateCount],'descend');
cols = size(queue,2);
if cols<=0
   return ; 
end
[~,b_i] = sort([queue.stateCount],type);
tmp= queue(b_i);
% [~,bb_i]=sort([tmp.support],'descend');
[~,bb_i]=sort([tmp.support],type);
queue = tmp(bb_i);
cols =size(queue,2);
if num>cols % queue中没有那么多数据，则排序后直接返回即可
    return; 
end
queue =queue(1,1:num);
end