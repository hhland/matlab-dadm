function [tstAcc,ptst,tstTime] = lmNetTest(numeric,tstD,w1,b1,w2,b2,trnFun,figPath,tstFigName,figSet)
%计时开始
tic;
% NNTWARN OFF%关闭神经网络的警告信息 
nntwarn off
%注意，这里的tstD是含有ID的，第一列不参与建模，
p=tstD(:,2:end-1);
[tstDM,tstDN]=size(tstD);
%训练函数赋值

trnFun=regexp(trnFun, ',', 'split');
InputFun=trnFun{1};%%%输入层到中间层的传递函数
OutputFun=trnFun{2};%%中间层到输出层的传递函数


%%& 图片名称赋值

tstFigName=regexp(tstFigName, ',', 'split');
figName5=tstFigName{1};

%图片设置赋值
fontSize=figSet(1);
figLength=figSet(2);
figWidth=figSet(3);

%网络仿真
ptst=simuff(p',w1,b1,InputFun,w2,b2,OutputFun);
%% 计算测试阶段分类准确率
tstAccNum=0;
for i=tstDM:-1:1  %%做内存预分配
    if round(ptst(i))==round(tstD(i,end))
        tstAccNum=tstAccNum+1;
    end
end
tstAcc=tstAccNum/tstDM*100; %test_acc测试阶段分类准确率
ptst=ptst';
%% 画图
if isempty(figName5)==0 %%%如果文件名，不为空的时候，就画图，否则不画。
    % % %% 设置图形
    f5=figure('Name','分类预览图','NumberTitle','off','MenuBar','none');
    iconfilename='F:\\Matlab_1\\logo.jpg';
    chgicon(f5,iconfilename);
    set(gca,'fontname','隶书');
    [tstDM,tstDN]=size(tstD);  
    grid on;
    set(gca,'fontsize',fontSize) ;   
    ptstCopy=ptst;
    if numeric==0
        ptstCopy=round(ptst);
    end
    plot(1:tstDM,tstD(1:tstDM,end),'k.',1:tstDM,ptstCopy(1:tstDM),'bx')
    axis([0 tstDM+10  min(tstD(:,tstDN))-1   max(tstD(:,tstDN))+1]);%设置坐标轴的范围
    title('测试样本预测结果');
    if numeric==0
        legend('原始类别','预测类别');
    else
        legend('实际值','预测值');
    end
    xlabel('样本编号');
    ylabel('预测结果');
    % % %设置图片保存的大小，不显示。[100,200,400,300]左右上下，
    set(f5,'PaperPositionMode','auto','Position',[100,200,figLength,figWidth]);
    set(f5,'visible','off');%%%使图形不跳出界面
    print(f5,'-dpng',strcat(figPath,'\',figName5));
end
%% 输出测试样本误差图
if numeric==1
    figName6=tstFigName{2};
    f6=figure('Name','测试样本误差图','NumberTitle','off','MenuBar','none');
    iconfilename='F:\\Matlab_1\\logo.jpg';
    chgicon(f6,iconfilename);
    set(gca,'fontname','隶书');
    set(gca,'fontsize',fontSize) ;  
    tstErrY=(ptst./tstD(:,end)-1)*100;
    %_%trainErrY=ptrn-trnD(:,end);
    maxY=max(tstErrY);
    minY=min(tstErrY);
    plot(tstErrY);  
    axis([0,length(tstErrY)+10,minY-1,maxY+1]);  
    title('测试样本误差图');
    xlabel('样本编号');
    ylabel('相对误差(%)');
    set(f6,'PaperPositionMode','auto','Position',[100,200,figLength,figWidth]);
    set(f6,'visible','off');%%%使图形不跳出界面
    print(f6,'-dpng',strcat(figPath,'\',figName6));
end
%花费时间
tstTime=toc;
end

