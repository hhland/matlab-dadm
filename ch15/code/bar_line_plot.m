function  bar_line_plot( x,bar_y,bar_legend,line_y,line_legend )
%% 

line_type ={'-o','-*','-+','-s','-d','-^'};

figure;

hold on ;
% ÌõĞÎÍ¼
bar(x,bar_y,0.4);
% legend(bar_legend);
% ÕÛÏßÍ¼
cols = size(line_y,2);
for i=1:cols
   plot(x,line_y(:,i),line_type{1,i}); 
%    legend(line_legend(i));
end
legend([bar_legend,line_legend])
hold off; 


end

