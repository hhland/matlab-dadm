function root = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex)
%% 构建hotspot关联规则树

% 输入数据：
% data: 前面n-1列属性为连续型，最后一列为离散型（目标列）；
% unique_labels：目标列的编码
% minSupport: 最小支持度
% minImprovement：最小置信度
% maxBranches: 最大分支数
% labelStateIndex: 目标列的目标状态的下标

% 输出参数：
% node： 输出hotspot关联规则树的根节点

%% 初始化参数
% 初始化minSupportCount
[numInstances,cols] = size(data);
minSupportCount = floor(minSupport*numInstances+0.5);
if minSupportCount<=0
   minSupportCount=1; 
end

% 计算label的不同状态的个数
attrCount = attr_state_count(data(:,end),unique_labels);

% 初始化targetValue 
targetValue = attrCount(labelStateIndex,1)/numInstances;

% 初始化全局规则
% clear global m_rules;
global m_rules;
m_rules=[];

%% 创建根节点
root = struct('splitAttributeIndex',cols,'stateIndex',labelStateIndex,...
    'stateCount',attrCount(labelStateIndex,1),'allCount',numInstances,...
    'support', targetValue,...
    'lessThan',2,'children',[]); % 'lessThan': 0:'<=' ,1:'>' , '2':'='
% 定义规则数组splitValues 和tests
splitValues = zeros(1,cols);
tests = zeros(1,cols);
root.children = constructChildren(data,targetValue,splitValues,tests,...
    minSupportCount,minImprovement,maxBranches,labelStateIndex);

return ;
end