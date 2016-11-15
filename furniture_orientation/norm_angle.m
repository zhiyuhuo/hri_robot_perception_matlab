function res = norm_angle(a)

while a > 2 * pi
    a = a - 2 * pi;
end
    
while a < 0
    a = a + 2 * pi;
end

res = a;

end