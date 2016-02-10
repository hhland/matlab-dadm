%% 使用ID3决策树算法预测销量高低
clear ;
% 参数初始化
inputfile = '../data/sales_data.xls'; % 销量及其他属性数据

%% 数据预处理
disp('正在进行数据预处理...');
[matrix,attributes_label,attributes] =  id3_preprocess(inputfile);

%% 构造ID3决策树，其中id3()为自定义函数
disp('数据预处理完成，正在进行构造树...');
tree = id3(matrix,attributes_label,attributes);

%% 打印并画决策树
[nodeids,nodevalues] = print_tree(tree);
tree_plot(nodeids,nodevalues);

disp('ID3算法构建决策树完成！');