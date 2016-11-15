clc;
clear;
close all;
%

Angle = [pi*6/4 pi*7/4 pi*0/4 pi*1/4 pi*2/4 pi*3/4 pi*4/4 pi*5/4];
F = zeros(10, 10);
T = 0;

for i = 1:6
    for j = 0:7
        disp([i j]);
        matname = [ 'objects_data/office_chair/matdata/train/office_chair_' num2str(i) '_0_' num2str(j) '.matdata'];
        data = load(matname);
        orientation = Angle(j+1);
        
        f = generate_gs(data, orientation);
        F = F + f;
        T = T + 1;
    end
end

F = F / T;
contourf(f)
colorbar('southoutside')