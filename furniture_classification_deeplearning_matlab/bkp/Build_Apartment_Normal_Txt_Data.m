clc;
clear;
close all;
%

data = load('apartment_normal_data_1d.mat');
data = data.data;

X = data.X;
Y = data.Y;

X = X';
Y = Y-1;
Y(find(Y == 0 | Y == 2 | Y == 4)) = 0;
Y(find(Y == 1 | Y == 3)) = 1;
Y(find(Y == 5)) = 2;
Y(find(Y == 6)) = 3;
Y(find(Y == 7)) = 4;

N = size(X,1);
D = size(X,2);

test_index = [];
for i = 1:N
    if rand < 0.25
        test_index(end+1) = i;
    end
end
total_index = 1:N;
train_index = setdiff(total_index, test_index);

train_data = X(train_index,:);
train_label = Y(train_index);

test_data = X(test_index,:);
test_label = Y(test_index);

fid = fopen('train_data.txt','wt');
for n = 1:size(train_data, 1)
    for d = 1:D
        fprintf(fid, '%s ', num2str(train_data(n,d)));
    end
    fprintf(fid, '\n');
end
fclose(fid);

fid = fopen('train_label.txt','wt');
fprintf(fid, '%s\n', num2str(train_label'));
fclose(fid);

fid = fopen('train_index.txt','wt');
fprintf(fid, '%s\n', num2str(train_index'));
fclose(fid);

fid = fopen('test_data.txt','wt');
for n = 1:size(test_data, 1)
    for d = 1:D
        fprintf(fid, '%s ', num2str(test_data(n,d)));
    end
    fprintf(fid, '\n');
end
fclose(fid);

fid = fopen('test_label.txt','wt');
fprintf(fid, '%s\n', num2str(test_label'));
fclose(fid);

fid = fopen('test_index.txt','wt');
fprintf(fid, '%s\n', num2str(test_index'));
fclose(fid);
