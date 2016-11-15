clc;
close all;
clear;
%

for i = 1:6
    for j = 0:7
        disp([i j]);
        a = j * pi / 4;
        plyfname = ['objects_3dwarehouse\pc\office_chair\office_chair_' num2str(i) '_0.ply'];
        data = readPly(plyfname);
        X0 = data(1:10:end, 1);
        Y0 = data(1:10:end, 2);
        Z0 = data(1:10:end, 3);
        X = cos(a) * X0 + -sin(a) * Y0;
        Y = sin(a) * X0 + cos(a) * Y0;
        Z = Z0;
%         scatter3(X, Y, Z, '.');
        XYZ = [X, Y, Z];
        txtfname = ['objects_data\office_chair\txt\train\office_chair_' num2str(i) '_0_' num2str(j) '.txt'];
        dlmwrite(txtfname, XYZ);
    end
end