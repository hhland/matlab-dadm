%% 逻辑回归 自动建模
clear;
% 参数初始化
filename = '../data/bankloan.xls' ; 

%% 读取数据
[num,txt] = xlsread(filename);
X = num(:,1:end-1);
Y = num(:,end);

%% 递归建模 
flag =1;
mdl = fitglm(X,Y,'linear','distr','binomial','Link','logit');
while flag ==1
    disp(mdl); % 打印model
    pValue = mdl.Coefficients.pValue;
    pValue_gt05 =pValue>0.05 ;
    if sum(pValue_gt05)==0 % 没有pValue值大于0.05的值
       flag =0;
       break;
    end
    % 移除pValue中大于0.05的变量最大的变量
    fprintf('\n移除变量：');
    [t,index]= max(pValue,[],1);
    fprintf('%s\t',mdl.CoefficientNames{1,index});
    fprintf('\n模型如下：');
    if index-1~=0   
        removeVariance =mdl.CoefficientNames{1,index};
    else
        removeVariance ='1';
    end
        % 从模型中移除变量
    mdl = removeTerms(mdl,removeVariance);
end

%% 自动建模 ，添加变量
disp('添加变量，自动建模中...');
mdl2 = stepwiseglm(X,Y,'constant','Distribution','binomial','Link','logit');
disp('添加变量，自动建模模型如下：')
disp(mdl2);

%% 自动建模 ， 移除变量
disp('移除变量，自动建模中...');
mdl3 =stepwiseglm(X,Y,'linear','Distribution','binomial','Link','logit');
disp('移除变量，自动建模模型如下：')
disp(mdl3);