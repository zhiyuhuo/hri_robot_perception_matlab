clc;
clear;
close all;
%

% for windows
% rootdir = 'C:/Users/zhdy7/Documents/Samples/Normal/hri_apartment/';
% for linux
rootdir = '/home/hri/Samples/Normal/rgbd_scene/';

classname = {'coffee_table', 'office_chair', 'sofa', 'table'};
classid = [1,2,4,1]
feature2d = zeros(10, 10, 2);

dataset = {};

for r = 1:length(classname)
    folderdir = [rootdir classname{r} '/'];
    a = dir(folderdir);
    filelist = {};
    for i = 3:length(a)
        filelist{end+1} = a(i).name
    end
    
    for f = 1:length(filelist)
        fname = [folderdir filelist{f}];
        data = load(fname);
        center = find_geometry_center(data(:,1), data(:,2), data(:,3));
        x = data(:,1) - center(1);
        y = data(:,2) - center(2);
        d = ceil(sqrt(x.^2 + y.^2) / 0.1);
        h = ceil(data(:,3) / 0.1);
        th = atan(data(:,6) ./ sqrt(data(:,4).^2 + data(:,5).^2)) / (pi/2);
        
        idx = find(~isnan(th) & d <= 10 & h <= 10 & d > 0 & h > 0);
        d = d(idx);
        h = h(idx);
        th = th(idx);
        
        for i = 1:size(d)
            feature2d(h(i), d(i), 1) = feature2d(h(i), d(i), 1) + th(i);
            feature2d(h(i), d(i), 2) = feature2d(h(i), d(i), 2) + 1;
        end
        
        for i = 1:10
            for j = 1:10
                if feature2d(i, j, 2) <= 1
                    feature2d(i, j, 2) = 0;
                end
                
                if feature2d(i, j, 2) ~= 0
                    feature2d(i, j, 1) = feature2d(i, j, 1) / feature2d(i, j, 2);
                    feature2d(i, j, 2) = 0;
                else
                    feature2d(i, j, 1) = 0;
                    feature2d(i, j, 2) = 1;
                end
            end
        end
        
        dataset{end+1} = {feature2d(:,:,1), feature2d(:,:,2), classid(r)};
        disp([r f]);
    end
end

save('rgbdscene_normal_data.mat', 'dataset');

%save one dimension dataset
L = 100;
X = [];
Y = [];

for n = 1:size(dataset,2);

    nm = dataset{n}{1};
    pt = dataset{n}{2};
    
    f = zeros(2*L,1);
    for i = 1:L
        f(2*i-1) = nm(i);
        f(2*i) = pt(i);
    end
    X = [X f];
    Y = [Y; dataset{n}{3}];
end

clear data

data.X = X;
data.Y = Y;

save('rgbdscene_normal_data_1d.mat', 'data');



