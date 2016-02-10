function[w1,b1,w2,b2,trnAcc,ptrn,trnTime,trnMse]=lmNetTrain(numeric,trnD,midNodeNum,trnPara,trnFun,figPath,trnFigName,figSet)
%计时开始
tic;
%%%%传递进来的trnD是含有ID的，这里做去ID处理。
% NNTWARN OFF  %关闭神经网络的警告信息
nntwarn off
% fldName=regexp(fldName,',','split');
p=trnD(:,2:end-1)';
t=trnD(:,end)';

%% 神经网络参数设置
% 网络参数设置
MidDim=midNodeNum;       %中间层节点数
% 网络训练参数
df=trnPara(1);           %显示间隔次数 25
me=trnPara(2);           %最大循环次数 1000
eg=trnPara(3);           %目标误差 0.02
lr=trnPara(4);           %学习速率 0.001
lrInc=trnPara(5);        %学习速率增加比率 0.001
lrIdec=trnPara(6);       %学习速率减少比率 10
momConst=trnPara(7);     %动量常数 0.1
errRatio=trnPara(8);     %最大误差比率 1e10
%训练函数赋值
trnFun=regexp(trnFun, ',', 'split');
InputFun=trnFun{1};      %输入层到中间层的传递函数
OutputFun=trnFun{2};     %中间层到输出层的传递函数

%%& 图片名称赋值

trnFigName=regexp(trnFigName, ',', 'split');
figName1=trnFigName{1};
figName2=trnFigName{2};
figName3=trnFigName{3};
figName4=trnFigName{4};

%图片设置赋值
fontSize=figSet(1);
figLength=figSet(2);
figWidth=figSet(3);



tp=[df me eg lr lrInc lrIdec momConst errRatio];
[r,q]=size(p);
[s2,q]=size(t);
[w1,b1]=rands(MidDim,r);
[w2,b2]=rands(s2,MidDim);

% [msgstr, msgid] = lastwarn;  %查看上一个warning的message ID
% warning('off', msgid);    %关掉它

%% 神经网络训练
[w1,b1,w2,b2,epochs,trnMse]=trainlm(w1,b1,InputFun,w2,b2,OutputFun,p,t,tp);
close;
trnMse=trnMse';

%% 计算训练后神经网络的输出
ptrn=simuff(p,w1,b1,InputFun,w2,b2,OutputFun)';%训练后神经模糊系统输出
%% 计算建模阶段分类准确率
trnAccNum=0;
[trnDM,trnDN]=size(trnD);
for i=trnDM:-1:1    %%做内存预分配
    if round(ptrn(i))==round(trnD(i,end))
        trnAccNum=trnAccNum+1;
    end
end
trnAcc=trnAccNum/trnDM*100; %train_acc建模阶段分类准确率

%% 训练和测试的误差变化图
if isempty(figName2)==0
    f2=figure;
    set(gca,'fontname','隶书');
    [trnMseM,trnMseN]=size(trnMse);
    set(gca,'fontsize',fontSize);
    plot(1:trnMseM, trnMse(1:trnMseM), 'k-');
    title('训练误差曲线图');
    xlabel('训练步数');
    ylabel('均方差');
    set(f2,'PaperPositionMode','auto','Position',[100,200,figLength,figWidth]);
    set(f2,'visible','off');%%%使图形不跳出界面
    print(f2,'-dpng',strcat(figPath,'\',figName2));
end

%% 绘制分类预测图
if isempty(figName3)==0
    f3=figure('Name','分类预览图','NumberTitle','off','MenuBar','none');
    iconfilename='F:\\Matlab_1\\logo.jpg';
    chgicon(f3,iconfilename);
    set(gca,'fontname','隶书');
    [ptrnM,ptrnN]=size(ptrn); 
    grid on;
    set(gca,'fontsize',fontSize) ;  
    ptrnCopy=ptrn;
    if numeric==0
        ptrnCopy=round(ptrn);
    end
    plot(1:trnDM,trnD(1:trnDM,end),'k.',1:ptrnM,ptrnCopy(1:ptrnM),'rx');
     axis([0 trnDM+10  min(trnD(:,trnDN))-1   max(trnD(:,trnDN))+1]);%设置坐标轴的范围
    title('训练样本预测结果');
    if numeric==0
        legend('原始类别','预测类别');
    else
        legend('实际值','预测值');
    end
    xlabel('样本编号');
    ylabel('预测结果');
    % % %设置图片保存的大小，不显示。[100,200,400,300]左右上下，
    set(f3,'PaperPositionMode','auto','Position',[100,200,figLength,figWidth]);
    set(f3,'visible','off');%%%使图形不跳出界面
    print(f3,'-dpng',strcat(figPath,'\',figName3));
end
%% 绘制训练样本误差图
if numeric==1
    f4=figure;
    set(gca,'fontname','隶书');
    set(gca,'fontsize',fontSize);
    trnErrY=(ptrn./trnD(:,end)-1)*100;
    % train_err_y=ptrain-train_data(:,end);
    maxY=max(trnErrY);
    minY=min(trnErrY);
    plot(trnErrY);  
    axis([0,length(trnErrY)+10,minY-1,maxY+1]);  
    title('训练样本误差图');
    xlabel('样本编号');
    ylabel('相对误差(%)');
    set(f4,'PaperPositionMode','auto','Position',[100,200,figLength,figWidth]);
    set(f4,'visible','off');%%%使图形不跳出界面
    print(f4,'-dpng',strcat(figPath,'\',figName4));
end
%% 绘制网络结构图
lmNetStructure(size(trnD,2)-2,midNodeNum,figPath,figName1,figSet);
trnTime=toc; %花费时间
end