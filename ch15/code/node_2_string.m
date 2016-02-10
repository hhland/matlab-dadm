function nodestr = node_2_string(node,unique_labels,attributes)
%% 返回node各个属性的字符串
%  struct('splitAttributeIndex',child.attrIndex,'stateIndex',child.stateIndex,...
%          'stateCount',child.stateCount,'allCount',child.allCount,'support',child.support,...
%          'lessThan',child.lessThan,'children',[]);
attrStr = attributes{1,node.splitAttributeIndex};

if node.lessThan==2
    stateStr = unique_labels{node.stateIndex,1};
    symbol =' = ';
else
    if node.lessThan ==1
        symbol =' <= ';
    else
        symbol =' > ';    
    end
    stateStr = num2str(node.stateIndex);
end
supportStr = [num2str(node.support*100) '%'];
stateCountStr = num2str(node.stateCount);
allCountStr = num2str(node.allCount);
nodestr=[attrStr symbol stateStr '  (' supportStr ' [' stateCountStr '/' ...
    allCountStr '])'];
end