function MicroAUC=Micro_AUC(Outputs, test_target)
    S_pos = [];
    S_neg = [];
    count = 0;
    for i = 1:1:size(test_target,1)
        for j = 1:1:size(test_target,2)
            if (test_target(i,j) == 1)
                S_pos = [S_pos;[i j]];
            else
                S_neg = [S_neg;[i j]];
            end
        end
    end
    for i = 1:1:size(S_pos,1)
        for j = 1:1:size(S_neg,1)
            if Outputs(S_pos(i,1),S_pos(i,2)) > Outputs(S_neg(j,1),S_neg(j,2))
              count = count + 1;  
            elseif Outputs(S_pos(i,1),S_pos(i,2)) == Outputs(S_neg(j,1),S_neg(j,2))
              count = count + 0.5;   
            end
        end
    end
    MicroAUC = count / (size(S_pos,1) * size(S_neg,1));

end

