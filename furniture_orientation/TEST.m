clc;
clear;
close all;
%

id = 1;
oname = [ num2str(id) '/orientation.txt' ];
orientation = load(oname);

map = zeros(10, 10);
for n = 0:23
    submount = ones(10, 10);
    submap = zeros(10, 10);
    fname = [ num2str(id) '/f-' num2str(id) '-' num2str(n) '.matdata'];
    disp(fname);
    data = load(fname);
    gangle = orientation(n+1);
    xyz = data(:,1:3);
    normal = data(:,4:6);
%     [angle, ratio] = get_orientation_angle(normal);
    [angle, ratio] = get_inner_orientation_angle(normal, xyz);
    [rdh rh] = get_rdh_from_xyz(xyz);
    f = [rh ratio];
    o = angle;
    t = orientation(n+1);
    
    d = o - t;
    MP = find(d > 180);
    MN = find(d < -180);  
    d(MP) = d(MP) - 360;
    d(MN) = d(MN) + 360;
    d = abs(d) / 180;
    
    T = 0;
    for k = 1:size(o, 1)        
        if ~isnan(d(k)) && f(k,3) > 5
            submap(f(k,1), f(k,2)) = submap(f(k,1), f(k,2)) + d(k);
            submount(f(k,1), f(k,2)) = submount(f(k,1), f(k,2)) + 1;
            T = T + 1;
        end
    end
    submap = submap./ submount;
    map = map + submap;
end