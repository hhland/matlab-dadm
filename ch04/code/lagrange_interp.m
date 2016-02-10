function [ yi ] = lagrange_interp (X,Y,xi)
n=length(X);       %得到已知数据长度
m=length(xi);      %得到待插值数据长度
yi=zeros(size(xi));
for j=1:m          %待插值数据有m个，计算每个插值结果
    for i=1:n       %已知的n个数据构造中间值
temp=1;   %temp用于存储中间值
        for k=1:n
            if(i~=k)  %和自身标号相同的不相乘
                temp=temp*(xi(j)-X(k))/(X(i)-X(k));
            end
        end
        yi(j)=Y(i)*temp+yi(j);
    end
end
end


