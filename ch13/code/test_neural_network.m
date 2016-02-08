%% BP神经网络模型测试
clear;
% 参数初始化
netfile = '../tmp/net.mat';    % 神经网络模型存储路径
testdatafile = '../data/test_neural_network_data.xls' ; % 待验证数据存储路径
testoutputfile = '../tmp/test_output_data.xls' ; % 测试数据模型输出文件
data=xlsread(testdatafile);   %读入验证数据
index=5;                       %教师信号所在列
targetoutput=data(:,index);   
 
%% 神经网络仿真
ywind=6:16;                  %神经网络输入列
testdata=data(:,ywind)';       %变换成神经网络输入形式
load(netfile);                 %载入训练好的神经网络模型
output=sim(net,testdata);      %仿真得到输出结果
%检验仿真结果
n=length(output);
error=0;
for i=1:n                      %对每个神经网络得到输出进行判断
    if(output(i)<=0)           %小于等于0，则识别为非洗浴
       output(i)=-1;       
    else
       output(i)=1;            %大于0，则识别为洗浴
    end
    if(output(i)~=targetoutput(i)) error=error+1; end  %检验是否和日志记录的一样
end
disp(['该待检测样本的正确率为：' num2str(1-error/n)]);

%% 写入数据
output=output';
temp=num2cell(output);
xlswrite(testoutputfile,['模型输出';temp]);
disp('BP神经网络模型测试完成！');