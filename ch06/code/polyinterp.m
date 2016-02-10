function v = polyinterp(x,y,u)
%% 拉格朗日插值算法
% x：下标序列；
% y: 时间序列值；
% u：缺失值下标序列；

n = length(x);
v = zeros(size(u));
for k = 1:n
    w = ones(size(u));  
    for j = [1:k-1 k+1:n]
        w = (u-x(j))./(x(k)-x(j)).*w;
    end
    v = v + w*y(k);
end

end