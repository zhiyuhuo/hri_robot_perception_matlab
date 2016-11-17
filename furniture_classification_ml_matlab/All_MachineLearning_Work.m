clc;
close all;
clear;

categories_set = {[1 2 3 4], [1 2 3]};
datasources = {'apartment_normal_data_1d.mat', 'rgbdscene_normal_data_1d.mat', 'apartment_fpfh_data_1d.mat', 'rgbdscene_fpfh_data_1d.mat'};

for datasource_id = 1:length(datasources)
    disp(datasources{datasource_id});
    if strfind(datasources{datasource_id}, 'apartment')
        categories = categories_set{1};
    end
    if strfind(datasources{datasource_id}, 'rgbdscene')
        categories = categories_set{2};
    end
    dataset = load(datasources{datasource_id});
    dataset = dataset.data;

    run = [1 1 1 1];
    if run(1)  
    ave_acc = [];
    for category_id = 1:length(categories)
%         disp(['  category_id: ', num2str(categories(category_id))]);
        class_to_detect = categories(category_id);
        for step = 1:10
            [model, acc] = train_a_single_furniture_svm_model(dataset, class_to_detect, 'RBF');
            ave_acc(end+1) = acc;
        end
    end
    ave_acc = mean(ave_acc);
    disp(['    acc for RDF SVM: ', num2str(ave_acc)]);
    end

    if run(2)
    ave_acc = [];
    for category_id = 1:length(categories)
%         disp(['  category_id: ', num2str(categories(category_id))]);
        class_to_detect = categories(category_id);
        for step = 1:10
            [model, acc] = train_a_single_furniture_svm_model(dataset, class_to_detect, 'Linear');
            ave_acc(end+1) = acc;
        end
    end
    ave_acc = mean(ave_acc);
    disp(['    acc for Linear SVM: ', num2str(ave_acc)]);
    end
    
    if run(3)
    ave_acc = [];
    for category_id = 1:length(categories)
%         disp(['  category_id: ', num2str(categories(category_id))]);
        class_to_detect = categories(category_id);
        for step = 1:10
            [model, acc] = train_a_single_furniture_svm_model(dataset, class_to_detect, 'Poly');
            ave_acc(end+1) = acc;
        end
    end
    ave_acc = mean(ave_acc);
    disp(['    acc for Poly SVM: ', num2str(ave_acc)]);
    end

    if run(4)
    ave_acc = [];
    for category_id = 1:length(categories)
%         disp(['  category_id: ', num2str(categories(category_id))]);
        class_to_detect = categories(category_id);
        for step = 1:10
            acc = train_a_single_furniture_nearestneighbour_model(dataset, class_to_detect, 5);
            ave_acc(end+1) = acc;
        end
    end
    ave_acc = mean(ave_acc);
    disp(['    acc for Nearest Neighbour: ', num2str(ave_acc)]);
    end

end