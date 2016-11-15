function [hor ver] = get_angle(nl)

hor = atan2(nl(2), nl(1));
ver = atan2(nl(3), norm(nl(1:2)));

end