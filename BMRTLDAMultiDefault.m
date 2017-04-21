function BMRTLDAMultiDefault(data_name, numM, numK, numC, beta, gamma, ini_parmas1, ini_parmas2, samp_ratio, sample_num, label_num, feature_dim, topN)

test_default_all_labelnum1 = 0;
test_default_eval_matrix = zeros(11, sample_num);
test_default_topN_hammingloss_matrix = zeros(topN, sample_num);
elapsed_time = 0;
% system(['del /q data\\' data_name '\\tmpfiles\\']);

for ii = 1:1:sample_num
    tic;
    %%%%%%%%Step1 Load data.
    if strcmp(data_name,'Image') == 1 || strcmp(data_name,'Yeast') == 1
        train_data= load(['data/' data_name '/data/' data_name '_train_data_s' num2str(ii)]);
        train_target = load(['data/' data_name '/data/' data_name '_train_target_s' num2str(ii)]);
        right_examples = sum(train_target, 1) ~= 0;
        train_data = train_data(right_examples, :);
        train_target = train_target(:, right_examples);
        train_label = train_target';
        
        test_data= load(['data/' data_name '/data/' data_name '_test_data_s' num2str(ii)]);
        test_target = load(['data/' data_name '/data/' data_name '_test_target_s' num2str(ii)]);
        right_examples = sum(test_target, 1) ~= 0;
        test_data = test_data(right_examples, :);
        test_target = test_target(:, right_examples);
        test_label = test_target';
        
    elseif strcmp(data_name,'LLOG-F') == 1 || strcmp(data_name,'ENRON-F') == 1  || strcmp(data_name,'SLASHDOT-F') == 1
        train_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_train_sa' num2str(ii-1)]);
        test_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_test_sa' num2str(ii-1)]);
        
        train_data = train_src(:,label_num+1:end);
        train_target = train_src(:,1:label_num)';
        right_examples = sum(train_target, 1) ~= 0;
        train_data = train_data(right_examples, :);
        train_target = train_target(:, right_examples);
        train_label = train_target';
        
        test_data = test_src(:,label_num+1:end);
        test_target = test_src(:,1:label_num)';
        right_examples = sum(test_target, 1) ~= 0;
        test_data = test_data(right_examples, :);
        test_target = test_target(:, right_examples);
        test_label = test_target';
    else
        train_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_train_sa' num2str(ii-1)]);
        test_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_test_sa' num2str(ii-1)]);
        
        train_data = train_src(:,1:feature_dim);
        train_target = train_src(:,feature_dim + 1:end)';
        right_examples = sum(train_target, 1) ~= 0;
        train_data = train_data(right_examples, :);
        train_target = train_target(:, right_examples);
        train_label = train_target';
        
        test_data = test_src(:,1:feature_dim);
        test_target = test_src(:,feature_dim + 1:end)';
        right_examples = sum(test_target, 1) ~= 0;
        test_data = test_data(right_examples, :);
        test_target = test_target(:, right_examples);
        test_label = test_target';
    end
    
    
    multi_train_labels = [];
    multi_train_data = [];
    count = 0;
    X_dis_indexs = cell(label_num,2);
    for jj = 1:label_num
        has_labels = train_label(:,jj) == 1;
        X_dis_indexs{jj,1} = count + 1;
        count = count + sum(has_labels, 1);
        X_dis_indexs{jj,2} = count;
        multi_train_data = [multi_train_data ;train_data(has_labels,:)];
        multi_train_labels = [multi_train_labels jj * ones(1,X_dis_indexs{jj,2} - X_dis_indexs{jj,1} + 1)];
    end
    
    train_data = train_data';
    test_data = test_data';
    multi_train_data = multi_train_data';
    
    %%%%%%%%Step2 Initialize the parameter
    
    theta = initialize_params(numK, numM, numC, train_data, test_data);    % Randomly initialize the parameters
    
    %%%%%%%%Step3 Use minFunc to minimize the function
    addpath minFunc/
    options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function.
    %options.maxIter = 300;	  % Maximum number of iterations of L-BFGS to run
    options.maxIter = 300;	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    options.display = 'on';
    options.TolFun  = 1e-6;
    options.TolX = 1e-1119;
    options.maxFunEvals = 4000;
    [opttheta, cost] = minFunc( @(p) computeObjectAndGradiendMulti(p, numM, numK,...
        numC, beta, gamma, train_data, test_data, multi_train_data, X_dis_indexs), theta, options);
    
    %Get W1 W2 W11 W22 b1 b2 b11 b22 after training.
    W1 = reshape(opttheta(1:numK*numM), numK, numM);
    W2 = reshape(opttheta(numK*numM+1:numK*numM+numK*numC), numC, numK);
    W22 = reshape(opttheta(numK*numM+numK*numC+1:numK*numM+2*numK*numC), numK, numC);
    W11 = reshape(opttheta(numK*numM+2*numK*numC+1:2*numK*numM+2*numK*numC), numM, numK);
    b1 = opttheta(2*numK*numM+2*numK*numC+1:2*numK*numM+2*numK*numC+numK);
    b2 = opttheta(2*numK*numM+2*numK*numC+numK+1:2*numK*numM+2*numK*numC+numK+numC);
    b22 = opttheta(2*numK*numM+2*numK*numC+numK+numC+1:2*numK*numM+2*numK*numC+2*numK+numC);
    b11 = opttheta(2*numK*numM+2*numK*numC+2*numK+numC+1:2*numK*numM+2*numK*numC+2*numK+numC+numM);
    
    %Test the data after training.
    test_hiddenvalues = sigmoid(W1 * test_data + b1 * ones(1, size(test_data,2)));
    test_labelinputs = W2 * test_hiddenvalues + b2 * ones(1, size(test_hiddenvalues,2));
    test_default_softmaxoutputs = exp(test_labelinputs) ./ ( ones(numC,1) * sum(exp(test_labelinputs),1));
    
    %Write outputs.
    dlmwrite(['data/' data_name '/midfiles/' data_name '_test_default_outputs_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_' ini_parmas1 ...
        '_sa ' num2str(ii)], test_default_softmaxoutputs, 'delimiter', ' ', 'precision', 8);
    %Stra1 Cut once
    test_default_pre_all_outputs1 = test_default_softmaxoutputs;
    sorted_test_default_pre_all_outputs1 = sort(test_default_pre_all_outputs1, 'descend');
    delta = [];
    for jj = 1:(size(test_default_pre_all_outputs1, 1) - 1)
        delta = [delta; (sorted_test_default_pre_all_outputs1(jj,:) - sorted_test_default_pre_all_outputs1(jj + 1,:))];
    end
    max_deltas = max(delta);
    max_deltas = ones(size(delta,1),1) * max_deltas;
    max_delta_indexs = delta == max_deltas;
    partial_outputs = sorted_test_default_pre_all_outputs1(1:end-1, :);
    cut_values = partial_outputs(max_delta_indexs)';
    cut_values = ones(size(test_default_pre_all_outputs1,1),1) * cut_values;
    test_default_pre_all_labels1 = test_default_pre_all_outputs1 >= cut_values;
    test_default_tmp_labelnum1 = sum(sum(test_default_pre_all_labels1)) / size(test_target, 2);
    test_default_all_labelnum1 = test_default_all_labelnum1 + test_default_tmp_labelnum1;
    %Write predicted labels.
    dlmwrite(['data/' data_name '/midfiles/' data_name '_test_default_prelabels_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_' ini_parmas1 ...
        '_sa ' num2str(ii)], test_default_pre_all_labels1, 'delimiter', ' ');
    
    %Compute evaluations.
    test_default_eval_matrix(1, ii) = Hamming_loss(test_default_pre_all_labels1, test_target);
    test_default_eval_matrix(2, ii) = One_error(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(3, ii) = coverage(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(4, ii) = Ranking_loss(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(5, ii) = Average_precision(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(6, ii) = Macro_AUC(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(7, ii) = Micro_AUC(test_default_pre_all_outputs1, test_target);
    test_default_eval_matrix(8, ii) = Accuracy(test_default_pre_all_labels1, test_target);
    test_default_eval_matrix(9, ii) = F1(test_default_pre_all_labels1, test_target);
    test_default_eval_matrix(10, ii) = Macro_F1(test_default_pre_all_labels1, test_target);
    test_default_eval_matrix(11, ii) = Micro_F1(test_default_pre_all_labels1, test_target);
    
    %Stra5 top n hamming loss
    test_default_pre_all_outputs5 = test_default_softmaxoutputs;
    test_default_topN_hammingloss_matrix(:, ii) = TopN_hamming_loss(test_default_pre_all_outputs5, test_target, topN);
    %Write evaluations.
    
    elapsed_tmp_time = toc;
    elapsed_time = elapsed_time + elapsed_tmp_time;
    
    dlmwrite(['data/' data_name '/midfiles/' data_name '_test_default_evals_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_time ' num2str(elapsed_tmp_time,8) '_' ini_parmas1 '_sa ' num2str(ii)], ...
        test_default_eval_matrix(:, ii)', 'delimiter', ' ', 'precision', 8);
    dlmwrite(['data/' data_name '/midfiles/' data_name '_test_default_evals_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_time ' num2str(elapsed_tmp_time,8) '_' ini_parmas1 '_sa ' num2str(ii)], ...
        test_default_topN_hammingloss_matrix(:,ii)', '-append','delimiter', ' ','precision', 8);
    dlmwrite(['data/' data_name '/midfiles/' data_name '_test_default_evals_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_time ' num2str(elapsed_tmp_time,8) '_' ini_parmas1 '_sa ' num2str(ii)], ...
        test_default_tmp_labelnum1, '-append','delimiter',' ','precision', 8);
    
    
    %%%%%%%%Step4 Generate data for BMR.
    multi_train_hiddenvalues = sigmoid(W1 * multi_train_data + b1 * ones(1, size(multi_train_data,2)));
    all_new_softmax_data = [multi_train_hiddenvalues';test_hiddenvalues'];
    indices = all_new_softmax_data <= 1e-200;
    all_new_softmax_data(indices) = 0;
    train_new_softmax_data = all_new_softmax_data(1:size(multi_train_hiddenvalues,2), :);
    test_new_softmax_data = all_new_softmax_data(size(multi_train_hiddenvalues,2)+1:end, :);
    
    train_src_data = ['data\\' data_name '\\tmpfiles\\' data_name '_train_data_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    train_src_label = ['data\\' data_name '\\tmpfiles\\' data_name '_train_labels_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    dlmwrite(train_src_data, train_new_softmax_data, 'delimiter', ' ', 'precision', 8);
    dlmwrite(train_src_label, multi_train_labels, 'delimiter', ' ');
    
    test_src_data = ['data\\' data_name '\\tmpfiles\\' data_name '_test_data_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    test_src_label = ['data\\' data_name '\\tmpfiles\\' data_name '_test_labels_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    dlmwrite(test_src_data, test_new_softmax_data, 'delimiter', ' ', 'precision', 8);
    dlmwrite(test_src_label, test_label(:,1)', 'delimiter', ' ');
    
    
    train_bmr_data = ['data/' data_name '/tmpfiles/' data_name '_train_BMRData_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    test_bmr_data = ['data/' data_name '/tmpfiles/' data_name '_test_BMRData_sampratio+' samp_ratio '_hiddensize+' num2str(numK) '+beta+' num2str(beta) '+gamma+' num2str(gamma) '_' ini_parmas2 '_sa+' num2str(ii)];
    
    system(['java GenerateBMRData -srcDataFileName ' train_src_data ' -srcLabelFileName ' train_src_label ' -tmpBMRDataFileName ' train_bmr_data]);
    system(['java GenerateBMRData -srcDataFileName ' test_src_data ' -srcLabelFileName ' test_src_label ' -tmpBMRDataFileName ' test_bmr_data]);
    system(['del ' train_src_data ' ' train_src_label ' ' test_src_data ' ' test_src_label]);
    
end

elapsed_time = elapsed_time / sample_num;
test_default_all_labelnum1 = test_default_all_labelnum1 / sample_num;

[evals_means, evals_stddevs] = Mean_StdDev(test_default_eval_matrix);
eval_str = '';
for i=1:1:size(evals_means, 1)
    eval_str = [eval_str num2str(evals_means(i, 1),8) '+/-' num2str(evals_stddevs(i, 1),8) ' '];
end

[topN_hammingloss_means, topN_hammingloss_stddevs] = Mean_StdDev(test_default_topN_hammingloss_matrix);
topN_hammingloss_str = '';
for i=1:1:size(topN_hammingloss_means, 1)
    topN_hammingloss_str = [topN_hammingloss_str num2str(topN_hammingloss_means(i, 1),8) '+/-' num2str(topN_hammingloss_stddevs(i, 1),8) ' '];
end

fid=fopen(['data/' data_name '/results/' data_name '_test_default_evals_sampratio ' samp_ratio '_hiddensize ' num2str(numK) ' beta ' num2str(beta) ' gamma ' num2str(gamma) '_time ' num2str(elapsed_time, 8) '_' ini_parmas1], 'w+');
fprintf(fid,[eval_str '\r\n' topN_hammingloss_str '\r\n' num2str(test_default_all_labelnum1, 8)]);
fclose(fid);


end

