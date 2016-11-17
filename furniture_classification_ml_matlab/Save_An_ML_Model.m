clc;
clear;
close all;
%

dataset = load('apartment_normal_data_1d.mat');
dataset = dataset.data;
rbfsigma = 20;
kernelstr = 'RBF';

category = 1;
[model, acc] = train_a_single_furniture_svm_model(dataset, category, kernelstr);
disp(acc);
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');
folderdir = ['models_for_ros/' num2str(category)];
mkdir(folderdir);
save_model_to_dir(folderdir, model, rbfsigma);

category = 2;
[model, acc] = train_a_single_furniture_svm_model(dataset, category, kernelstr);
disp(acc);
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');
folderdir = ['models_for_ros/' num2str(category)];
mkdir(folderdir);
save_model_to_dir(folderdir, model, rbfsigma);

category = 3;
[model, acc] = train_a_single_furniture_svm_model(dataset, category, kernelstr);
disp(acc);
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');
folderdir = ['models_for_ros/' num2str(category)];
mkdir(folderdir);
save_model_to_dir(folderdir, model, rbfsigma);

category = 4;
[model, acc] = train_a_single_furniture_svm_model(dataset, category, kernelstr);
disp(acc);
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model');
folderdir = ['models_for_ros/' num2str(category)];
mkdir(folderdir);
save_model_to_dir(folderdir, model, rbfsigma);