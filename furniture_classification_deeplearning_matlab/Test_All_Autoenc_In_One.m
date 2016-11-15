clc;
clear;
close all;
%

%%% test rgbd dataset using normal feature
data = load('apartment_normal_data_1d.mat');
data = data.data;
X = data.X;
Y = data.Y;
idx_test = randsample(size(X,2), ceil(size(X,2) * 1/3));
Xtest = X(:,idx_test);
Ytest = Y(idx_test);
Ttest = zeros(max(Ytest), length(Ytest));
for i = 1:size(Ttest,2)
    Ttest(Ytest(i), i) = 1;
end
deepnet = load('deepnet_autoenc_normal_apartment.mat');
deepnet = deepnet.deepnet;
y = deepnet(Xtest);
% plotconfusion(Ttest,y);
acc = length(find(y.*Ttest > 0.5)) / length(Ttest);
disp(['normal feature - apartment dataset acc: ', num2str(acc)]);
clear;

%%% test rgbdscene dataset using normal feature
data = load('rgbdscene_normal_data_1d.mat');
data = data.data;
X = data.X;
Y = data.Y;
idx_test = randsample(size(X,2), ceil(size(X,2) * 1/3));
Xtest = X(:,idx_test);
Ytest = Y(idx_test);
Ttest = zeros(max(Ytest), length(Ytest));
for i = 1:size(Ttest,2)
    Ttest(Ytest(i), i) = 1;
end
deepnet = load('deepnet_autoenc_normal_rgbdscene.mat');
deepnet = deepnet.deepnet;
y = deepnet(Xtest);
% plotconfusion(Ttest,y);
acc = length(find(y.*Ttest > 0.5)) / length(Ttest);
disp(['normal feature - rgbdscene dataset acc: ', num2str(acc)]);
clear;

%%% test apartment dataset using fpfh feature
data = load('apartment_fpfh_data_1d.mat');
data = data.data;
X = data.X;
Y = data.Y;
idx_test = randsample(size(X,2), ceil(size(X,2) * 1/3));
Xtest = X(:,idx_test);
Ytest = Y(idx_test);
Ttest = zeros(max(Ytest), length(Ytest));
for i = 1:size(Ttest,2)
    Ttest(Ytest(i), i) = 1;
end
deepnet = load('deepnet_autoenc_fpfh_apartment.mat');
deepnet = deepnet.deepnet;
y = deepnet(Xtest);
% plotconfusion(Ttest,y);
acc = length(find(y.*Ttest > 0.5)) / length(Ttest);
disp(['fpfh feature --- apartment dataset acc: ', num2str(acc)]);
clear;

%%% test rgbdscene dataset using fpfh feature
data = load('rgbdscene_fpfh_data_1d.mat');
data = data.data;
X = data.X;
Y = data.Y;
idx_test = randsample(size(X,2), ceil(size(X,2) * 1/3));
Xtest = X(:,idx_test);
Ytest = Y(idx_test);
Ttest = zeros(max(Ytest), length(Ytest));
for i = 1:size(Ttest,2)
    Ttest(Ytest(i), i) = 1;
end
deepnet = load('deepnet_autoenc_fpfh_rgbdscene.mat');
deepnet = deepnet.deepnet;
y = deepnet(Xtest);
% plotconfusion(Ttest,y);
acc = length(find(y.*Ttest > 0.5)) / length(Ttest);
disp(['fpfh feature --- rgbdscene dataset acc: ', num2str(acc)]);
clear;

