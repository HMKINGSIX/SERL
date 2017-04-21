function macro_F1=Macro_F1(Pre_Labels, test_target)
    macro_F1_sum = 0;
    for i = 1:1:size(test_target,1)
        intersection = Pre_Labels(i,:) & test_target(i,:);
        if sum(Pre_Labels(i,:)) == 0
            if sum(test_target(i,:)) == 0
              macro_F1_sum = macro_F1_sum + 1;
            end
            continue;
        end
        tmp_pre = sum(intersection) / sum(Pre_Labels(i,:));
        tmp_recall = sum(intersection) / sum(test_target(i,:));
        if tmp_pre == 0 || tmp_recall == 0
            continue;
        end
        tmp_f1 = (2 * tmp_pre * tmp_recall) / (tmp_pre + tmp_recall);
        macro_F1_sum = macro_F1_sum + tmp_f1;
    end
    macro_F1 = macro_F1_sum / size(test_target,1);
end

