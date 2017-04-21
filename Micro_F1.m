function micro_F1=Micro_F1(Pre_Labels, test_target)
    intersect_sum = 0;
    pre_sum = sum(sum(Pre_Labels));
    true_sum = sum(sum(test_target));
    for i = 1:1:size(test_target,1)
        intersection = Pre_Labels(i,:) & test_target(i,:);
        intersect_sum = intersect_sum + sum(intersection);
    end
    precision = intersect_sum / pre_sum;
    recall = intersect_sum / true_sum;
    micro_F1 = (2 * precision * recall) / (precision + recall);
end

