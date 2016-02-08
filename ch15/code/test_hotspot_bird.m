%% hotspot算法测试脚本,以鸟害为例
clear;
% 初始化参数
inputfile = '../data/hotspotdata.xls'; 
hotspottreefile = '../tmp/hstree.mat';
labelIndex = 3; % 给定目标列是离散型数据
attrsIndex=[3,5]; % 给定属性列都是连续型数据 
attrsIndex_txt=[8,10];
minSupport =0.04; 
minImprovement=0.01;
maxBranches =2; % 最大分支数
labelStateIndex =5; % 给定目标列的目标状态下标，5表示鸟害
level =0; % 打印root节点设置为0

%% 数据预处理
[unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt);

% 测试
% global unique_labels_  attributes_;
% unique_labels_=unique_labels;
% attributes_ = attributes;

%% hotspot算法调用
disp('HotSpot关联规则树构建中...');
root = hotspot(data,unique_labels,minSupport,minImprovement,maxBranches,labelStateIndex);
save(hotspottreefile,'root');
disp(['HotSpot关联规则树已经保存在文件"' hotspottreefile '"中!']);
%% 打印hotspot关联规则树
disp('HotSpot 关联规则树构建完成，下面是打印的树：');
print_hsnode(root,level,unique_labels,attributes);