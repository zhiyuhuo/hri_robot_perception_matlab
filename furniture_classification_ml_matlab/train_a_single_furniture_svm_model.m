function [model, acc] = train_a_single_furniture_svm_model(dataset, category, kernelstr)

X = dataset.X';
Y = dataset.Y;
idx_train = randsample(size(X,1), ceil(size(X,1) * 2/3));
idx_test = setdiff([1:size(X,1)], idx_train);
Xtrain = X(idx_train,:);
Xtest = X(idx_test,:);
Ytrain = Y(idx_train);
Ytrain(find(Ytrain ~= category)) = -1;
Ytrain(find(Ytrain == category)) = 1;
Ytest = Y(idx_test);
Ytest(find(Ytest ~= category)) = -1;
Ytest(find(Ytest == category)) = 1;

rbfsigma = 20;  
model = fitcsvm(Xtrain, Ytrain, 'Standardize',true,'KernelFunction', kernelstr, 'KernelScale','auto');

[label,score] = predict(model,Xtest);

k = Ytest.*label;
acc = length(find(k > 0)) / length(label);

% disp(acc);

% model.Sigma = rbfsigma;
% 
% save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');
% 
% folderdir = ['models_for_ros/' category];
% mkdir(folderdir);
% save_model_to_dir(folderdir, model);

