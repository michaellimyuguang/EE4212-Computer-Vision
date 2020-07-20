X = [];
images = dir('*.png');

%create the 42021x150 matrix
for j = 1:length(images)
   image_name = images(j).name;
   I = im2double(imread(image_name));
   I = I(:); %scanning column by column
   X = [X I];
end

%mean centering
X_mean = mean(X, 2);
X_mean_centered = X - X_mean;

%PCA
[U, S, V] = svd(X_mean_centered,'econ'); % to produce "economy size"
X_PCA = U(:,1:10) * S(1:10, :) * V'; %take only the first 10 principal components
X_reconstructed = X_PCA + X_mean; %adding back the mean image vector

%obtain the 150 reconstructed images
for k = 1:150
    image_reconstructed = X_reconstructed(:, k);
    imwrite(reshape(image_reconstructed, [161, 261]), strcat(int2str(k), '.png'));
end

