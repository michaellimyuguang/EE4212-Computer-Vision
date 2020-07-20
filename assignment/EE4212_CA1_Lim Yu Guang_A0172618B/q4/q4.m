%4.2.1 establish point correspondence
img_1 = imread('frc1.tif');
img_2 = imread('frc2.tif');

%cpselect(img_1, img_2);

%x = cpstruct8.inputPoints'; %8 corresponding points
%x_prime = cpstruct8.basePoints'; %8 corresponding points

%x = cpstruct12.inputPoints'; %12 corresponding points
%x_prime = cpstruct12.basePoints'; $12 corresponding points

x = cpstruct16.inputPoints'; %16 corresponding points
x_prime = cpstruct16.basePoints'; %16 corresponding points

%4.2.2, 4.2.3 and 4.2.4
F = estimateF(x, x_prime);
disp("F = "), disp(F);
displayEpipolarF(img_1, img_2, F);

