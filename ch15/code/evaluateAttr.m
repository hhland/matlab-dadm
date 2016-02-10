function queue=evaluateAttr(queue,data,attrIndex,targetValue,minSupportCount,minImprovement,labelStateIndex)
%% 评价第i列属性的某个值是否有潜力加入队列

% 判断是否有足够的数据
numInstances = size(data,1);
if numInstances<=minSupportCount
    return;
end

% 根据第i列进行数据排序
[~,b_index] = sort(data(:,attrIndex));
data = data(b_index,:); % 排序后的数据

targetLeft =0;
targetRight = sum(data(:,end)==labelStateIndex);

% 初始化参数
bestMerit = 0.0;
bestSplit = 0.0;
bestSupport = 0.0;
bestSubsetSize = 0;
%  lessThan = true;
lessThan =1;
% denominators
leftCount = 0;
rightCount = numInstances;


%% for 遍历
for i=1:numInstances
    
    inst = data(i,:);
    if inst(1,end) == labelStateIndex
        targetLeft=targetLeft+1;
        targetRight=targetRight-1;
    end
    leftCount=leftCount+1;
    rightCount=rightCount-1;
    
    % move to the end of any ties
    if i < numInstances
        
        data_ii = data(i+1,:);
        if data_ii(1,attrIndex)==inst(1,attrIndex)
            continue;
        end
    end
    
    % evaluate split
    
    if targetLeft >= minSupportCount
        delta = (targetLeft / leftCount) - bestMerit;
        
        if delta > 0
            bestMerit = targetLeft / leftCount;
            % 					bestSplit = inst[attrIndex];
            bestSplit = inst(1,attrIndex);
            bestSupport = targetLeft;
            bestSubsetSize = leftCount;
            % 					lessThan = true;
            lessThan =1;
        else if delta == 0
                % break ties in favour of higher support
                if targetLeft > bestSupport
                    bestMerit = targetLeft / leftCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);
                    bestSupport = targetLeft;
                    bestSubsetSize = leftCount;
                    % 						lessThan = true;
                    lessThan =1;
                end
            end
        end
        
    end
    
    if targetRight >= minSupportCount
        delta =(targetRight / rightCount) - bestMerit;
        
        if delta > 0
            bestMerit = targetRight / rightCount;
            % 					bestSplit = inst[attrIndex];
            bestSplit =inst(1,attrIndex);
            bestSupport = targetRight;
            bestSubsetSize = rightCount;
            % 					lessThan = false;
            lessThan =0;
            
        else if delta == 0
                
                if targetRight > bestSupport
                    bestMerit = targetRight / rightCount;
                    % 						bestSplit = inst[attrIndex];
                    bestSplit = inst(1,attrIndex);
                    bestSupport = targetRight;
                    bestSubsetSize = rightCount;
                    % 						lessThan = false;
                    lessThan =0;
                end
            end
        end
        
    end
end % for 
    delta =  bestMerit- targetValue;
    
    % Have we found a candidate split?
    if bestSupport > 0 && delta / targetValue >= minImprovement
        
        %             AttrStateSup ass = new AttrStateSup(attrIndex,(float)bestSplit,
        %             (int)bestSubsetSize,(int)bestSupport,lessThan);
        % 构造结构体，插入queue
        queue_node =struct('attrIndex',attrIndex,'stateIndex',bestSplit,...
            'stateCount', bestSupport,'allCount',bestSubsetSize,'support',...
            bestSupport/bestSubsetSize,'lessThan',lessThan);
        %             pq.add(ass);
        queue= queue_push(queue,queue_node);
        
        
    end
end

