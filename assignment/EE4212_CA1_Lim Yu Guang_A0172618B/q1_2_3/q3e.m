matrix_xy = importdata('two_dimensional_points.txt'); %this txt file contain the storage of the two-dimensional points (x,y)

x = matrix_xy(:,1); %all x values
y = matrix_xy(:,2); %all y values

A = zeros(82,6);

for i = 1:82
    A(i,1) = x(i).^2;
    A(i,2) = x(i).*y(i);
    A(i,3) = y(i).^2;
    A(i,4) = x(i);
    A(i,5) = y(i);
    A(i,6) = 1;
end

[U, S, V] = svd(A);

disp('a = '), disp(V(1,6));
disp('b = '), disp(V(2,6));
disp('c = '), disp(V(3,6));
disp('d = '), disp(V(4,6));
disp('e = '), disp(V(5,6));
disp('f = '), disp(V(6,6));

