function [r h] = get_rh(xyz, cxy)

r = norm(xyz(1:2));
h = xyz(3);

end