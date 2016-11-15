function [angle, ratio] = get_orientation_angle(normal)
angle = [];
ratio = [];
for i = 1:size(normal, 1)

    x = normal(i, 1);
    y = normal(i, 2);
    z = normal(i, 3);

    a = atan2(y, x);
    a = norm_angle(a);
    angle = [angle; rad2deg(a)];

    ratio = [ratio; abs(norm([x y]))];

end

ratio = ceil(ratio / 0.1);

end