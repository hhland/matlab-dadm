function [ flag ] = m_rules_containkey( newSplitValues,newTests )
%% 判断当前的规则是否已经在全局规则中, 0表示不在（会添加），1表示在（不会添加）

global m_rules;
cols= size(m_rules,2);
if cols<=0 % 第一条规则直接添加
    add_2_m_rules(newSplitValues,newTests); 
    flag =0;
    return ;
end

for i=1:cols
    rule_node = m_rules(1,i);
    if equal_split_test(rule_node,newSplitValues,newTests) % 如果相等，则说明已存在
        flag=1;
        return ;
    end
end
% 遍历完m_rules 还不在，则进行添加
add_2_m_rules(newSplitValues,newTests);
flag =0;
end

function add_2_m_rules(newSplitValues,newTests)
%% 把新规则加入到全局规则中
% 构造rule 结构体
    global m_rules;
    rule_node = struct('splitValues',newSplitValues,'tests',newTests);
    m_rules=[m_rules,rule_node];
end

function flag = equal_split_test(rule_node,newSplitValues,newTests)
 %% 判断给定的规则和新规则是否是一样的
    splitValues = rule_node.splitValues;
    tests = rule_node.tests;
    cols = size(tests,2);
    split_sum = sum(splitValues==newSplitValues);
    test_sum = sum(tests==newTests);
    if split_sum==cols && test_sum==cols
       flag =1; 
       return;
    end
    flag =0;
end