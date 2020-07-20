I = im2double(imread('image001.png'));

[U, S, V] = svd(I);
K = 20;
Sk = S(1:K,1:K);
Uk = U(:,1:K);
Vk = V(:,1:K);

Imk = Uk * Sk * Vk';

imshow(Imk);