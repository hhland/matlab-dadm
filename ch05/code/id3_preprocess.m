function [ matrix,attributes,activeAttributes ] = id3_preprocess( inputfile )
%% ID3算法数据预处理，把字符串转换为0,1编码

% 输入参数：
% inputfile: 输入数据文件；

% 输出参数：
% output： 转换后的0,1矩阵；
% attributes: 属性和Label；
% activeAttributes : 属性向量，全1；

%% 读取数据
[~,txt]=xlsread(inputfile);
attributes=txt(1,2:end);
activeAttributes = ones(1,length(attributes)-1);
data = txt(2:end,2:end);

%% 针对每列数据进行转换
[rows,cols] = size(data);
matrix = zeros(rows,cols);
for j=1:cols
    matrix(:,j) = cellfun(@trans2onezero,data(:,j));
end

end

function flag = trans2onezero(data)
    if strcmp(data,'坏') ||strcmp(data,'否')...
        ||strcmp(data,'低')
        flag =0;
        return ;
    end
    flag =1;
end
