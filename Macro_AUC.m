function MacroAUC=Macro_AUC(Outputs, test_target)
label_num = size(test_target,1);
sum = 0;
for i = 1:1:size(test_target,1)
    pos_indexs = find(test_target(i,:) == 1);
    neg_indexs = find(test_target(i,:) == 0);
    if (size(pos_indexs,2) == 0 || size(neg_indexs,2) == 0)
        label_num = label_num - 1;
        continue;
    end
    count = 0;
    for j = 1:1:size(pos_indexs,2)
        for k = 1:1:size(neg_indexs,2)
            %             if Outputs(i,pos_indexs(1,j)) >= Outputs(i, neg_indexs(1,k))
            %                 count = count + 1;
            %             end
            if Outputs(i,pos_indexs(1,j)) > Outputs(i, neg_indexs(1,k))
                count = count + 1;
            elseif Outputs(i,pos_indexs(1,j)) == Outputs(i, neg_indexs(1,k))
                count = count + 0.5;
            end
        end
    end
    sum = sum + count / (size(pos_indexs,2) * size(neg_indexs,2));
end
MacroAUC = sum / label_num;

end

