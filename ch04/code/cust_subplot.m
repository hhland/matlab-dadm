function cust_subplot(width_data,rows,cols,index,k,title_)
%% ×Ô¶¨Òå»­Í¼

subplot(rows,cols,index);
dot_str ={'k*','ko','ks','kd'};
hold on;
for i=1:k
    data_ = width_data((width_data(:,2)==i),1);
    num = size(data_,1);
    y= zeros(num,1);
    y(:)=0.5*(i+1);
    plot(data_,y,dot_str{1,i});
%     plot(data_,y);
end
title(title_);
hold off

end

