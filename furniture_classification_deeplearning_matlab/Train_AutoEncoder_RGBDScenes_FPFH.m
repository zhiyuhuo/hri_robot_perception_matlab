clc;
clear;
close all;
%

data = load('rgbdscene_fpfh_data_1d.mat');
data = data.data;
X = data.X;
Y = data.Y;
idx_train = randsample(size(X,2), size(X,2) * 2/3);
idx_test = setdiff([1:size(X,2)], idx_train);
Xtrain = X(:,idx_train);
Xtest = X(:,idx_test);
Ytrain = Y(idx_train);
Ytest = Y(idx_test);
Ttrain = zeros(max(Ytrain), length(Ytrain));
for i = 1:size(Ttrain,2)
    Ttrain(Ytrain(i), i) = 1;
end
Ttest = zeros(max(Ytest), length(Ytest));
for i = 1:size(Ttest,2)
    Ttest(Ytest(i), i) = 1;
end

%%%%%%%train dnn for 200-len feature
X1 = Xtrain
hiddenSize = 512;
autoenc1 = trainAutoencoder(X1,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');
X2 = encode(autoenc1, X1);

hiddenSize = 128;
autoenc2 = trainAutoencoder(X2,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');
X3 = encode(autoenc2, X2);

hiddenSize = 16;
autoenc3 = trainAutoencoder(X3,hiddenSize,...
    'L2WeightRegularization',0.001,...
    'SparsityRegularization',4,...
    'SparsityProportion',0.05,...
    'DecoderTransferFunction','purelin');
X4 = encode(autoenc3, X3);

softnet1 = trainSoftmaxLayer(X4,Ttrain,'LossFunction','crossentropy','MaxEpochs',400);
view(softnet1);
deepnet = stack(autoenc1,autoenc2,autoenc3,softnet1);
deepnet = train(deepnet,X1,Ttrain);

%%%%%%%testing
y = deepnet(Xtest);
plotconfusion(Ttest,y);

save('deepnet_autoenc_fpfh_rgbdscene.mat', 'deepnet');










