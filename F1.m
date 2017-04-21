% function f1=F1(Pre_Labels, test_target)
%     precision_sum = 0;
%     recall_sum = 0;
%     for i = 1:1:size(test_target,2)
%          intersection = Pre_Labels(:,i) & test_target(:,i);
%          if sum(Pre_Labels(:,i)) == 0
%             continue;
%          end
%          precision_sum = precision_sum + sum(intersection) / sum(Pre_Labels(:,i));
%          recall_sum = recall_sum + sum(intersection) / sum(test_target(:,i));
%     end
%     precision = precision_sum / size(test_target,2);
%     recall = recall_sum / size(test_target,2);
%     f1 = (2 * precision * recall) / (precision + recall); 
% end

function f1_sum=F1(Pre_Labels, test_target)
    f1_sum = 0;
    for i = 1:1:size(test_target,2)
         intersection = Pre_Labels(:,i) & test_target(:,i);
         if sum(Pre_Labels(:,i)) == 0
            continue;
         end
         precision = sum(intersection) / sum(Pre_Labels(:,i));
         recall = sum(intersection) / sum(test_target(:,i));
         if precision == 0
            continue;
         end
         f1 = (2 * precision * recall) / (precision + recall); 
         f1_sum = f1_sum + f1;
    end
    f1_sum = f1_sum / size(test_target,2); 
end

