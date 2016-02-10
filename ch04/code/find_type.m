function [ flag ] = find_type( data )
%% 根据规则，返回类别

rules = [0,0.179,0.258,0.35,0.504];
cols = size(rules,2);
for i=1:cols-1
    if data>rules(i) && data<=rules(i+1)
        flag =i;
        return ;
    end
end
flag =-1;

end

