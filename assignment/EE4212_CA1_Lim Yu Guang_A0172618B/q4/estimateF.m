function F = estimateF(x1, x2)

%4.2.2 normalisation of the data 
N = length(x1);

mean_x1 = mean(x1);
mean_x2 = mean(x2);

origin_x1 = x1 - mean_x1;
origin_x2 = x2 - mean_x2;

square_x1 = origin_x1.^2;
square_x2 = origin_x2.^2;

distance_x1 = mean(sqrt(square_x1(1,:) + square_x1(2,:)));
distance_x2 = mean(sqrt(square_x2(1,:) + square_x2(2,:)));

scaling_x1 = sqrt(2)./distance_x1;
scaling_x2 = sqrt(2)./distance_x2;

% T which consists of translation and scaling
T = [scaling_x1, 0 , (-scaling_x1 *  mean_x1(1)); 0, scaling_x1, (-scaling_x1 * mean_x1(2)); 0, 0, 1];
T_prime = [scaling_x2, 0, (-scaling_x2 * mean_x2(1)); 0, scaling_x2, (-scaling_x2 * mean_x2(2)); 0, 0, 1];

x1_homo = [x1; ones(1,N)];
x2_homo = [x2; ones(1,N)];

x = (T * x1_homo)';
x_prime = (T_prime * x2_homo)';

%4.2.3 computation of fundamental matrix
A = zeros(N,9);

for j = 1:N
    A(j,1) = x_prime(j,1) * x(j,1); %x1'x1
    A(j,2) = x_prime(j,1) * x(j,2); %x1'y1
    A(j,3) = x_prime(j,1); %x1'
    A(j,4) = x_prime(j,2) * x(j,1); %y1'x1
    A(j,5) = x_prime(j,2) * x(j,2); %y1'y1
    A(j,6) = x_prime(j,2); %y1'
    A(j,7) = x(j,1); %x1
    A(j,8) = x(j,2); %y1
    A(j,9) = 1; %1
end

%(1) find solution for f
[U, S, V] = svd(A);
f = V(:,9);

%(2) enforce singularity constraint
F = reshape(f,[3,3]);
F = F';

[F_U, F_D, F_V] = svd(F);
D = zeros(3,3); %D is the diagonal matrix. diag(r,s,0)
D(1,1) = F_D(1,1);
D(2,2) = F_D(2,2);
F_D = D;

F_prime = F_U * F_D * F_V'; %replace F by F'

F = T_prime' * F_prime * T;

end








    
    