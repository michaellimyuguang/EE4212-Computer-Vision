p_prime = importdata('pts_prime.txt'); % 200 x 3 matrix
p = importdata('pts.txt'); % 200 x 3 matrix
zeros_padding = zeros([200, 3]); % 200 x 3 of zeros

%creating the matrix A from 1b
A = [p;zeros_padding;zeros_padding]; % adding 400 x 3 of zeros at the bottom of p. A is a 600 x 3 matrix.
A = [A, [zeros_padding;p;zeros_padding]]; % A is a 600 x 6 matrix
A = [A, [zeros_padding;zeros_padding;p]]; % A is a 600 x 9 matrix
last_3 = [ones([200,1]), zeros([200,1]), zeros([200,1]); zeros([200,1]), ones([200,1]), zeros([200,1]); zeros([200,1]), zeros([200,1]), ones([200,1])]; %600 x 3 matrix
A = [A, last_3]; %A is a 600 x 12 matrix

%creating the vector b from 1b
b = [p_prime(:,1); p_prime(:,2); p_prime(:,3)]; %b is a 600 x 1 matrix

%least square via SVD
[U, D, V] = svd(A); % U is a 600 x 600 matrix. D is a 600 x 12 matrix. V is a 12 x 12 matrix 
d = diag(D); % d is a 12 x 1 matrix
b_T = U' * b; % b_T is a 12 x 1 matrix
k = b_T(1:12)./d; % y is a 12 x 1 matrix 
x = V * k; %x is a 12 x 1 matrix

R = reshape(x(1:9), [3,3])'; % put into a 3 x 3 matrix
T = reshape(x(10:12), [3,1]); % put into a 3 x 1 matrix
disp('R = '), disp(R);
disp('T = '), disp(T);
disp('det(R) = '), disp(det(R));
