function tree_plot( p ,nodevalues)
%% ²Î¿¼treeplotº¯Êý

[x,y,h]=treelayout(p);
f = find(p~=0);
pp = p(f);
X = [x(f); x(pp); NaN(size(f))];
Y = [y(f); y(pp); NaN(size(f))];

X = X(:);
Y = Y(:);

    n = length(p);
    if n < 500,
        hold on ; 
        plot (x, y, 'ro', X, Y, 'r-');
        nodesize = length(x);
        for i=1:nodesize
%            text(x(i)+0.01,y(i),['node' num2str(i)]); 
            text(x(i)+0.01,y(i),nodevalues{1,i}); 
        end
        hold off;
    else
        plot (X, Y, 'r-');
    end;

xlabel(['height = ' int2str(h)]);
axis([0 1 0 1]);

end

