clc;
clear;
close all;
%

dataset = load('apartment_normal_data_1d.mat');
dataset = dataset.data;
rbfsigma = 20;
kernelstr = 'linear';
names = {'table', 'chair', 'couch', 'bed'};

category = 1;
[model_table, acc] = train_a_single_furniture_svm_model_OLD(dataset, category, kernelstr);
disp(acc);

category = 2;
[model_chair, acc] = train_a_single_furniture_svm_model_OLD(dataset, category, kernelstr);
disp(acc);

category = 3;
[model_couch, acc] = train_a_single_furniture_svm_model_OLD(dataset, category, kernelstr);
disp(acc);

category = 4;
[model_bed, acc] = train_a_single_furniture_svm_model_OLD(dataset, category, kernelstr);
disp(acc);


category = 1;
save(['models/model_' kernelstr '_' names{category} '.mat'], 'model_table');
folderdir = ['models_for_ros/' names{category}];
mkdir(folderdir);
save_model_to_dir(folderdir, model_table, rbfsigma);

category = 2;
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model_chair');
folderdir = ['models_for_ros/' names{category}];
mkdir(folderdir);
save_model_to_dir(folderdir, model_chair, rbfsigma);

category = 3;
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model_couch');
folderdir = ['models_for_ros/' names{category}];
mkdir(folderdir);
save_model_to_dir(folderdir, model_couch, rbfsigma);

category = 4;
save(['models/model_' kernelstr '_' num2str(category) '.mat'], 'model_bed');
folderdir = ['models_for_ros/' names{category}];
mkdir(folderdir);
save_model_to_dir(folderdir, model_bed, rbfsigma);