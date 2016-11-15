function acc = train_a_single_furniture_nearestneighbour_model(dataset, category, k)

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

[IDX,D] = knnsearch(Xtrain, Xtest, 'K', k, 'NSMethod', 'kdtree');
label = -ones(size(Ytest,1),1);
for r = 1:size(IDX, 1)
    score = 0;
    for c = 1:size(IDX, 2)
        if Ytrain(IDX(r,c)) == category
            score = score + 1;
        end
    end
    if score >= k/2
        label(r) = 1;
    end
end
k = Ytest.*label;
acc = length(find(k > 0)) / length(label);

end