I = im2double(imread('image001.png'));

[U, S, V] = svd(I);

plot(diag(S), 'b.');