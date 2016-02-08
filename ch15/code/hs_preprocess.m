function [unique_labels,data,attributes]=hs_preprocess(inputfile,labelIndex,attrsIndex,attrsIndex_txt)
%% 数据预处理 ，抽取需要的数据列

[num,txt] = xlsread(inputfile);

attributes = txt(1,[attrsIndex_txt,labelIndex]);

labels=txt(2:end,labelIndex);
unique_labels= unique(labels);
labels=transform(labels,unique_labels);
data =[num(:,attrsIndex),labels];

disp('数据预处理完成！');
disp('目标列编码为：');
rows = size(unique_labels,1);
for i=1:rows
   disp([unique_labels{i,1} ' --> ' num2str(i)]); 
end

end

function labels=transform(labels,unique_labels_)
    global unique_labels;
    unique_labels= unique_labels_;
    labels = cellfun(@find_label_index,labels);
%     disp('a');
    
end

function labelindex = find_label_index(label)
    global unique_labels;
    [rows]= size(unique_labels,1);
    for i=1:rows
       if strcmp(unique_labels{i,1},label)
           labelindex =i;
           return;
       end
    end
    disp('编码错误！');
end