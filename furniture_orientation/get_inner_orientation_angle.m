function [angle, ratio] = get_inner_orientation_angle(normal, xyz)

angle = [];
ratio = [];

cx = ( max(xyz(:,1)) + min(xyz(:,1)) ) / 2;
cy = ( max(xyz(:,2)) + min(xyz(:,2)) ) / 2;

for i = 1:size(normal, 1)

    x = normal(i, 1);
    y = normal(i, 2);
    z = normal(i, 3);
    
    xx = xyz(i, 1);
    yy = xyz(i, 2);

    innerangle = atan2(yy - cy, xx - cx);
    innerangle = norm_angle(innerangle);
    
    a = atan2(y, x);
    a = norm_angle(a);
    
    d = a - innerangle;
    while d > pi
        d = d - 2 * pi;
    end
    while d < -pi
        d = d + 2 * pi;
    end
    
    if abs(d) > pi/2
        a = a - pi;
        a = norm_angle(a);
    end
    
    if isnan(a)
    end
    angle = [angle; rad2deg(a)];

    ratio = [ratio; abs(norm([x y]))];

end

ratio = ceil(ratio / 0.1);

end