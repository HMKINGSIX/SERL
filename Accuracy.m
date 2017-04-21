function accuracy=Accuracy(Pre_Labels, test_target)
    accuracy_sum = 0;
    for i = 1:1:size(test_target,2)
        intersection = Pre_Labels(:,i) & test_target(:,i);
        union = Pre_Labels(:,i) | test_target(:,i);
        tmp = sum(intersection) / sum(union);
        accuracy_sum = accuracy_sum + tmp;
    end
    accuracy = accuracy_sum / size(test_target,2);
end

