function [ topN_hammingloss ] = TopN_hamming_loss(Outputs,test_target,n)

topN_hammingloss = [];
sorted_outputs = sort(Outputs, 'descend');
for i = 1:1:n
    baseline = sorted_outputs(i, :);
    baseline = ones(size(test_target,1), 1) * baseline;
    Pre_Labels = Outputs >= baseline;
    [num_class,num_instance]=size(Pre_Labels);
    miss_pairs=sum(sum(Pre_Labels~=test_target));
    HammingLoss=miss_pairs/(num_class*num_instance);
    topN_hammingloss = [topN_hammingloss;HammingLoss];
end



end

