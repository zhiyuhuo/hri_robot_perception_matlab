function res = get_xy_centroid(data)

X = data(:,1);
Y = data(:,2);

res = [ min(X) + max(X) / 2, min(Y) + max(Y) / 2 ];

end