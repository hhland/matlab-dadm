%% 阈值寻优
clear;
inputfile='../data/water_heater.xls';           % inputfile：输入数据路径,需要使用Excel格式；

%% 读入数据
[~, ~, data]=xlsread(inputfile);

%% 根据不同阈值，得到用水划分结果
threshold_best=0;
disp('划分用水事件中......');
h = 2:0.25:8; % 在区间2-8分钟内找一个最优阈值
cols = size(h,2);
t = zeros(cols,3);
for i=1:cols                       
    dividsequence=divide_event_for_optimization(h(1,i),data);
    n=size(dividsequence,1);        % 事件个数
    t(i,1)=h(1,i);  
    t(i,2)=n;    
end       

%% 当都得出2-8分钟，不同阈值的事件个数后，开始找最优的阈值
disp('阈值寻优中......');
threshold_n=size(t,1);      %threshold_n记录探寻的阈值个数
for i=1:threshold_n-4
    t(i,3)=(abs((t(i+1,2)-t(i,2))/0.25)+abs((t(i+2,2)-t(i,2))/0.5)...
        +abs((t(i+3,2)-t(i,2))/0.75)+abs((t(i+4,2)-t(i,2))/1))/4;
    %t(i,3)用来记录每个阈值对应的平均斜率
    if(t(i,3)<=1)   
        threshold_best=t(i,1);   
        break;   
    end    %找到最靠前的最优的值
end
if(threshold_best==0)                          %如果没找到最优的阈值，则给它默认值4分钟或者取最小的
    [threshold_best,threshold_index]=min(t(1:threshold_n-4,3));
    if(threshold_best>=5)
        threshold_best=4;
        disp('here...');
    else
        threshold_best=t(threshold_index,1);
    end
end

%% 打印结果
disp(['最优阈值为：' num2str(threshold_best) '分钟']);
