clear all;
warning off
% input data feature dimensions  m
global numM;
% number of hidden units k
global numK;
global numC;
global beta;
global gamma;



% datasets_name = {'CAL500', 'LLOG-F', 'ENRON-F', 'Image', 'scene', 'Yeast', 'SLASHDOT-F', 'Corel5k', 'bibtex', 'Corel16k001', 'Corel16k002', 'eurlex-sm', 'eurlex-dc-leaves', 'mediamill'};
%datasets_name = {'CAL500', 'SLASHDOT-F', 'Corel5k', 'bibtex', 'Corel16k001', 'Corel16k002'};
datasets_name = { 'Corel16k001', 'Corel16k002'};

for set_index = 1:1:size(datasets_name, 2)
    
    data_name = datasets_name{1,set_index};
    %%%%%%%%Set params.
    if strcmp(data_name, 'CAL500') == 1
        all_beta=[15];
        all_hiddenSize=[30];
        all_gamma=[0.01];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 174;
        feature_dim = 68;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
    elseif strcmp(data_name, 'LLOG-F') == 1
        all_beta=[15 30];
        all_hiddenSize=[100];
        all_gamma=[0.001 0.005 0.01];
        start_index=1;
        end_index=6;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 75;
        feature_dim = 1004;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
    elseif strcmp(data_name, 'ENRON-F') == 1
        all_beta=[15 30];
        all_hiddenSize=[100];
        all_gamma=[0.001 0.005 0.01];
        start_index=1;
        end_index=6;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 53;
        feature_dim = 1001;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
    elseif strcmp(data_name, 'Image') == 1
        all_beta=[15 30];
        all_hiddenSize=[30];
        all_gamma=[0.001 0.005 0.01];
        start_index=1;
        end_index=6;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 5;
        feature_dim = 294;
        topN = 5;
        
        numM = feature_dim;
        numC = label_num;
    elseif strcmp(data_name, 'scene') == 1
        all_beta=[15 30];
        all_hiddenSize=[30];
        all_gamma=[0.001 0.005 0.01];
        start_index=1;
        end_index=6;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 6;
        feature_dim = 294;
        topN = 6;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'Yeast') == 1
        all_beta=[15 30];
        all_hiddenSize=[30];
        all_gamma=[0.001 0.005 0.01];
        start_index=1;
        end_index=6;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 14;
        feature_dim = 103;
        topN = 14;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'SLASHDOT-F') == 1
        all_beta=[15];
        all_hiddenSize=[100];
        all_gamma=[0.01];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 22;
        feature_dim = 1079;
        topN = 22;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'Corel5k') == 1
        all_beta=[15];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 374;
        feature_dim = 499;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'bibtex') == 1
        all_beta=[15];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 159;
        feature_dim = 1836;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'Corel16k001') == 1
        all_beta=[30];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 153;
        feature_dim = 500;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'Corel16k002') == 1
        all_beta=[30];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 164;
        feature_dim = 500;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'eurlex-sm') == 1
        all_beta=[15];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 201;
        feature_dim = 5000;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'eurlex-dc-leaves') == 1
        all_beta=[15];
        all_hiddenSize=[100];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 412;
        feature_dim = 5000;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
        
    elseif strcmp(data_name, 'mediamill') == 1
        all_beta=[15];
        all_hiddenSize=[30];
        all_gamma=[0.005];
        start_index=1;
        end_index=1;
        
        ini_parmas1 = 'layer1 rate 1 mask 0.2 epo 200 bat datasize layer2 rate 1 mask 0.1 epo 500 bat datasize';
        ini_parmas2 = 'layer1+rate+1+mask+0.2+epo+200+bat+datasize+layer2+rate+1+mask+0.1+epo+500+bat+datasize';
        samp_ratio = '55';
        sample_num = 5;
        label_num = 101;
        feature_dim = 120;
        topN = 30;
        
        numM = feature_dim;
        numC = label_num;
    end
    
%     %%%%%%%%Statistics.
%     nooutput_all_hammingloss = 0;
%     for ii = 5:1:sample_num
%         if strcmp(data_name,'Image') == 1 || strcmp(data_name,'Yeast') == 1
%             train_data= load(['data/' data_name '/data/' data_name '_train_data_s' num2str(ii)]);
%             train_target = load(['data/' data_name '/data/' data_name '_train_target_s' num2str(ii)]);
%             right_examples = sum(train_target, 1) ~= 0;
%             train_data = train_data(right_examples, :);
%             train_target = train_target(:, right_examples);
%             train_label = train_target';
%             
%             test_data= load(['data/' data_name '/data/' data_name '_test_data_s' num2str(ii)]);
%             test_target = load(['data/' data_name '/data/' data_name '_test_target_s' num2str(ii)]);
%             right_examples = sum(test_target, 1) ~= 0;
%             test_data = test_data(right_examples, :);
%             test_target = test_target(:, right_examples);
%             test_label = test_target';
%             
%         elseif strcmp(data_name,'LLOG-F') == 1 || strcmp(data_name,'ENRON-F') == 1  || strcmp(data_name,'SLASHDOT-F') == 1
%             train_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_train_sa' num2str(ii-1)]);
%             test_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_test_sa' num2str(ii-1)]);
%             
%             train_data = train_src(:,label_num+1:end);
%             train_target = train_src(:,1:label_num)';
%             right_examples = sum(train_target, 1) ~= 0;
%             train_data = train_data(right_examples, :);
%             train_target = train_target(:, right_examples);
%             train_label = train_target';
%             
%             test_data = test_src(:,label_num+1:end);
%             test_target = test_src(:,1:label_num)';
%             right_examples = sum(test_target, 1) ~= 0;
%             test_data = test_data(right_examples, :);
%             test_target = test_target(:, right_examples);
%             test_label = test_target';
%         else
%             train_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_train_sa' num2str(ii-1)]);
%             test_src = load(['data/' data_name '/data/' data_name '_or0_javamatlabI_javaO_test_sa' num2str(ii-1)]);
%             
%             train_data = train_src(:,1:feature_dim);
%             train_target = train_src(:,feature_dim + 1:end)';
%             right_examples = sum(train_target, 1) ~= 0;
%             train_data = train_data(right_examples, :);
%             train_target = train_target(:, right_examples);
%             train_label = train_target';
%             
%             test_data = test_src(:,1:feature_dim);
%             test_target = test_src(:,feature_dim + 1:end)';
%             right_examples = sum(test_target, 1) ~= 0;
%             test_data = test_data(right_examples, :);
%             test_target = test_target(:, right_examples);
%             test_label = test_target';
%         end
%         nooutput_tmp_hammingloss = sum(sum(test_target)) / (size(test_target, 1) * size(test_target, 2));
%         nooutput_all_hammingloss = nooutput_all_hammingloss + nooutput_tmp_hammingloss;
%         dlmwrite(['data/' data_name '/statistics/' data_name '_nooutputhammingloss_sa ' num2str(ii)], nooutput_tmp_hammingloss, 'delimiter', ' ', 'precision', 8);
%     end
%     nooutput_all_hammingloss = nooutput_all_hammingloss / sample_num;
%     dlmwrite(['data/' data_name '/statistics/' data_name '_nooutputhammingloss_samplecount ' num2str(sample_num)], nooutput_all_hammingloss, 'delimiter', ' ', 'precision', 8);
    
    
    %%%%%%%%Start running.
    params=cell(1,size(all_beta,2)*size(all_hiddenSize,2)*size(all_gamma,2));
    count=1;
    for pos1=1:1:size(all_beta,2)
        for pos2=1:1:size(all_hiddenSize,2)
            for pos3=1:1:size(all_gamma,2)
                
                params{1,count} = [all_beta(1,pos1) all_hiddenSize(1,pos2) all_gamma(1,pos3)];
                count = count + 1;
                
            end
        end
    end
    
    
    
    for index=start_index:1:end_index
        
        tmp_params = params{1,index};
        beta = tmp_params(1,1);
        numK = tmp_params(1,2);
        gamma = tmp_params(1,3);
        
        BMRTLDAMultiDefault(data_name, numM, numK, numC, beta, gamma, ini_parmas1, ini_parmas2, samp_ratio, sample_num, label_num, feature_dim, topN);
        %         BMRTLDAMultiNew(data_name, numM, numK, numC, beta, gamma, ini_parmas1, ini_parmas2, samp_ratio, sample_num, label_num, feature_dim, topN);
        
    end
    
    
end

