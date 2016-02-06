%% 利用小波分析 进行特征分析
clear;
% 参数初始化
level =5;
load leleccum;
signal = leleccum(1:3920);

%% 进行 level层小波分解
[C,S] = wavedec2(signal,level,'bior3.7');

%% 提取第i层小波系数,并计算各层能量值
E=zeros(1,level);
for i=1:level
    [H_i,~,~] = detcoef2('all',C,S,i);
    E(1,i)=norm(H_i,'fro');
end

%% 打印各层能量值，即提取的特征值
disp('声音信号小波分析完成，提取的特征向量为：');
disp(E);