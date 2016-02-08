%%神经网络预测
function [ppre]=lmNetPredict(preD,w1,b1,w2,b2,trnFun)
% NNTWARN OFF%关闭神经网络的警告信息 
nntwarn off
%这里的ppre是含有ID的，不含有类别的，以下做去ID 处理。
p=preD(:,2:end);
%训练函数赋值
 trnFun=regexp(trnFun, ',', 'split');
InputFun=trnFun{1};%%%输入层到中间层的传递函数
OutputFun=trnFun{2}; %%中间层到输出层的传递函数

ppre=simuff(p',w1,b1,InputFun,w2,b2,OutputFun);
 ppre=ppre';
end