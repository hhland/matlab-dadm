function [ tree ] = id3( examples, attributes, activeAttributes )
%% ID3 算法 ，构建ID3决策树
    ...参考：https://github.com/gwheaton/ID3-Decision-Tree

% 输入参数：
% example: 输入0、1矩阵；
% attributes: 属性值，含有Label；
% activeAttributes: 活跃的属性值；-1,1向量，1表示活跃；

% 输出参数：
% tree：构建的决策树；

%% 提供的数据为空，则报异常
if (isempty(examples));
    error('必须提供数据！');
end

% 常量
numberAttributes = length(activeAttributes);
numberExamples = length(examples(:,1));

% 创建树节点
tree = struct('value', 'null', 'left', 'null', 'right', 'null');

% 如果最后一列全部为1，则返回“true”
lastColumnSum = sum(examples(:, numberAttributes + 1));

if (lastColumnSum == numberExamples);
    tree.value = 'true';
    return
end
% 如果最后一列全部为0，则返回“false”
if (lastColumnSum == 0);
    tree.value = 'false';
    return
end

% 如果活跃的属性为空，则返回label最多的属性值
if (sum(activeAttributes) == 0);
    if (lastColumnSum >= numberExamples / 2);
        tree.value = 'true';
    else
        tree.value = 'false';
    end
    return
end

%% 计算当前属性的熵
p1 = lastColumnSum / numberExamples;
if (p1 == 0);
    p1_eq = 0;
else
    p1_eq = -1*p1*log2(p1);
end
p0 = (numberExamples - lastColumnSum) / numberExamples;
if (p0 == 0);
    p0_eq = 0;
else
    p0_eq = -1*p0*log2(p0);
end
currentEntropy = p1_eq + p0_eq;

%% 寻找最大增益
gains = -1*ones(1,numberAttributes); % 初始化增益

for i=1:numberAttributes;
    if (activeAttributes(i)) % 该属性仍处于活跃状态，对其更新
        s0 = 0; s0_and_true = 0;
        s1 = 0; s1_and_true = 0;
        for j=1:numberExamples;
            if (examples(j,i)); 
                s1 = s1 + 1;
                if (examples(j, numberAttributes + 1)); 
                    s1_and_true = s1_and_true + 1;
                end
            else
                s0 = s0 + 1;
                if (examples(j, numberAttributes + 1)); 
                    s0_and_true = s0_and_true + 1;
                end
            end
        end
        
        % 熵 S(v=1)
        if (~s1);
            p1 = 0;
        else
            p1 = (s1_and_true / s1); 
        end
        if (p1 == 0);
            p1_eq = 0;
        else
            p1_eq = -1*(p1)*log2(p1);
        end
        if (~s1);
            p0 = 0;
        else
            p0 = ((s1 - s1_and_true) / s1);
        end
        if (p0 == 0);
            p0_eq = 0;
        else
            p0_eq = -1*(p0)*log2(p0);
        end
        entropy_s1 = p1_eq + p0_eq;

        % 熵 S(v=0)
        if (~s0);
            p1 = 0;
        else
            p1 = (s0_and_true / s0); 
        end
        if (p1 == 0);
            p1_eq = 0;
        else
            p1_eq = -1*(p1)*log2(p1);
        end
        if (~s0);
            p0 = 0;
        else
            p0 = ((s0 - s0_and_true) / s0);
        end
        if (p0 == 0);
            p0_eq = 0;
        else
            p0_eq = -1*(p0)*log2(p0);
        end
        entropy_s0 = p1_eq + p0_eq;
        
        gains(i) = currentEntropy - ((s1/numberExamples)*entropy_s1) - ((s0/numberExamples)*entropy_s0);
    end
end

% 选出最大增益
[~, bestAttribute] = max(gains);
% 设置相应值
tree.value = attributes{bestAttribute};
% 去活跃状态
activeAttributes(bestAttribute) = 0;

% 根据bestAttribute把数据进行分组
examples_0= examples(examples(:,bestAttribute)==0,:);
examples_1= examples(examples(:,bestAttribute)==1,:);

% 当 value = false or 0, 左分支
if (isempty(examples_0));
    leaf = struct('value', 'null', 'left', 'null', 'right', 'null');
    if (lastColumnSum >= numberExamples / 2); % for matrix examples
        leaf.value = 'true';
    else
        leaf.value = 'false';
    end
    tree.left = leaf;
else
    % 递归
    tree.left = id3(examples_0, attributes, activeAttributes);
end
% 当 value = true or 1, 右分支
if (isempty(examples_1));
    leaf = struct('value', 'null', 'left', 'null', 'right', 'null');
    if (lastColumnSum >= numberExamples / 2); 
        leaf.value = 'true';
    else
        leaf.value = 'false';
    end
    tree.right = leaf;
else
    % 递归
    tree.right = id3(examples_1, attributes, activeAttributes);
end

% 返回
return
end