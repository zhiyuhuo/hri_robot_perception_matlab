function res = generate_gs(data, orientation)

data = data(find(~isnan(data(:,4))), :);
% scatter3(data(:,1), data(:,2), data(:,3), '.');
M = zeros(10, 10);
F = zeros(10, 10);
rh = [];
for i = 1:length(data)
    xyz = data(i, 1:3);
    [r h] = get_rh(xyz);
    rh = [rh; [r h]];
end
rh = [rh(:,1) / max(rh(:,1)), rh(:,2) / max(rh(:,2))];
rh = ceil(rh / 0.1);
for i = 1:length(rh)
    h = rh(i,2);
    r = rh(i,1);
    nl = data(i, 4:6);
    [hor ver] = get_angle(nl);
    if abs(ver) < pi/6
        da = angle_diff(hor, orientation);
        sc = (pi - da) / pi;
        F(h,r) = F(h,r)+sc;
        M(h,r) = M(h,r)+1; 
    end
end

res = zeros(10, 10);
for i = 1:size(F, 1)
    for j = 1:size(F, 2)
        if F(j, i) > 0
            res(j, i) = F(j, i) / M(j, i);
        end
    end
end

end