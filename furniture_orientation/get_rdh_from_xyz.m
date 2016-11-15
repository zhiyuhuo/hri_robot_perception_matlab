function [rdh rh] = get_rdh_from_xyz(xyz) %r - radiu; d - direction; h - height.

cx = ( max(xyz(:,1)) + min(xyz(:,1)) ) / 2;
cy = ( max(xyz(:,2)) + min(xyz(:,2)) ) / 2;

xyz(:,1) = xyz(:,1) - cx;
xyz(:,2) = xyz(:,2) - cy;

rdh = zeros(size(xyz, 1), 3);

for i = 1:size(xyz, 1)
    rdh(i,1) = norm([xyz(i,1) xyz(i,2)]);
    rdh(i,2) = get_orientation_angle([xyz(i,1) xyz(i,2) 0]);
    rdh(i,3) = xyz(i,3);
    
end

rh = [ceil(rdh(:,1) / 0.1) ceil(rdh(:,3) / 0.1)];

end