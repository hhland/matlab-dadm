function lmNetStructure(trnInputNum,midNodeNum,figPath,figName,figSet)
%%%---相关参数说明---%%%
%%trainInputNum, 输入节点数
%%midNodeNum , 隐含节点数
%%fieldName，字段名，是一个数组，对应网络结构图的输入与输出名称
            % {'ZN','CU','高锰酸盐','T-P','石油类','COD','DO','油层类别'};最后一个为输出参数。
%%figurePath，图片路径
%%figureName，图片名

fldName=cell(1,trnInputNum+1);
for i=1:trnInputNum
   fldName{1,i}=['x' num2str(i)]; 
end
fldName{1,trnInputNum+1}='y';
gcf=figure;
set(gca,'fontname','隶书');
hold on;

%%%相关数据赋值，这只在程序调试阶段用，实际通过参数传递
% 第一组测试数据
%trainInputNum=7;
%midNodeNum=5;
%figurePath='E:\image';
%figureName='lmStructure';
%fieldName={'ZN','CU','高锰酸盐','T-P','石油类','COD','DO','油层类别'};
%figureSet = [7;520;360];

% 第二组测试数据
% trnInputNum=2;
% midNodeNum=6;
% figPath='E:\image';
% figName='lmStructure.png';
% % fldName={'ZN','CU','油层类别'};
% fldName={'x1','x2','y'};

%figSet = [7;520;360];
%%---------------

I=trnInputNum; % 输入节点数
M=midNodeNum;    % 隐含节点数
t=2;               % 输入层、隐含层以及输出层的间隔基数


%图片设置赋值
fontSize=figSet(1);
figLength=figSet(2);
figWidth=figSet(3);

fldName1 = {'输入层','隐含层','输出层'};  %lm神经网络三层结构注释

ci=0.18*exp(linspace(0,pi*2,100)*1i);
outputNode=fill(5*t+real(ci),(I+1)/2+imag(ci),'k');
text(double(5*t+0.5),double((I+1)/2),'\rightarrow','fontsize',12);
text(double(5*t+0.5),double((I+1)/2+1),fldName{1,end},'fontsize',fontSize);
text(double(t-0.5),double(min(1,(I-M)/2)-1),fldName1{1,1},'fontsize',fontSize);
text(double(3*t-0.5),double(min(1,(I-M)/2)-1),fldName1{1,2},'fontsize',fontSize);
text(double(5*t+0.5),double(min(1,(I-M)/2)-1),fldName1{1,3},'fontsize',fontSize);
title('lm神经网络结构图');

for node=1:M
    f(node)=fill(3*t+real(ci),node+(I-M)/2+imag(ci),'k');
    plot([3*t,5*t],[node+(I-M)/2,(I+1)/2],'k','linewidth',1);
    for j=1:I
        f(j)=fill(t+real(ci),j+imag(ci),'k');
        text(t-1,j,'\rightarrow','fontsize',12);
        text(t-3,I - j + 1,fldName{1,j},'fontsize',fontSize);
        plot([3*t,t],[node+(I-M)/2,j],'k','linewidth',1); 
    end
end  

set(gcf, 'PaperPositionMode', 'auto', 'Position', [100,200, figLength, figWidth]);
set(gcf, 'visible', 'off');%%使图形不跳出界面
axis([t-4 5*t+3 min(1,(I-M)/2)-2 max(I+1,(I+M)/2+1)]);
axis off;

%% 生成图像文件

if isempty(figName)==0  %%%如果文件名，不为空的时候，就保存图形，否则不保存     
    figPathName=strcat(figPath,'\',figName);
    print(gcf,'-dpng',figPathName); %将图形保存为jpeg/jpg格式的图片。
end








