function [means, std_devs] = Mean_StdDev(evals)
    means = sum(evals, 2) / size(evals, 2);
    deltas = evals - means * ones(1, size(evals, 2));
    std_devs = sqrt(sum(deltas .* deltas, 2) / size(evals, 2));
end

