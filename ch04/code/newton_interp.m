function yi=newton_interp(X,Y,xi)
syms t;             %定义自变量t，用于字符公式
if(length(X)==length(Y))
    n=length(X);
    c(1:n)=0.0;
else
    disp('X和Y的维数不相等！');
    return;
end
f=Y(1);             %f用来记录得到的牛顿插值公式的字符串表达式
l=1;
for i=1:n-1
    y1=zeros(1,n-i);
    for j=i+1:n
        y1(j)=(Y(j)-Y(i))/(X(j)-X(i));
    end
    c(i)=y1(i+1);   %c记录差分
    l=l*(t-X(i));    %l记录(x-x0)(x-x1)……的值 
    f=f+c(i)*l;     %累加得到差分公式
    Y=y1;
end
f=simplify(f);       %简化得到的牛顿插值公式
m=length(xi);       %开始输出

for i=1:m
    yi(i)=subs(f,'t',xi(i));   % 根据公式计算需要的值
end
yi=double(yi);     % 转换为数值型，为返回值

end


