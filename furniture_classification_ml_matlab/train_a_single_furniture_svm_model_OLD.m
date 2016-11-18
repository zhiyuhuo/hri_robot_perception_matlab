function [model, acc] = train_a_single_furniture_svm_model_OLD(dataset, category, kernelstr)

X = dataset.X';
Y = dataset.Y;
idx_train = randsample(size(X,1), ceil(size(X,1) * 2/3));
idx_test = setdiff([1:size(X,1)], idx_train);

%for the final training
idx_train = [1:size(X,1)];

Xtrain = X(idx_train,:);
Xtest = X(idx_test,:);
Ytrain = Y(idx_train);
Ytrain(find(Ytrain ~= category)) = -1;
Ytrain(find(Ytrain == category)) = 1;
Ytest = Y(idx_test);
Ytest(find(Ytest ~= category)) = -1;
Ytest(find(Ytest == category)) = 1;

SMO_OptsStruct = svmsmoset('MaxIter', 100000); 
model = svmtrain(Xtrain, Ytrain, 'kernel_function', kernelstr, 'Method', 'SMO', 'SMO_Opts', SMO_OptsStruct);

label = svmclassify(model,Xtest);

group = model.GroupNames(model.SupportVectorIndices);
ylabel = zeros(size(Xtest,1), 1);
for i = 1:size(Xtest,1)
    x = Xtest(i,:);
    x = model.ScaleData.scaleFactor .* (x + model.ScaleData.shift);
    y = 0;
    for k = 1:length(group)
        xs = model.SupportVectors(k,:);
        y = y + model.Alpha(k) * (x * xs');
    end
    y = y + model.Bias;
    ylabel(i) = -y;
end
disp([Ytest, ylabel])
k = Ytest.*label;
acc = length(find(k > 0)) / length(label);

