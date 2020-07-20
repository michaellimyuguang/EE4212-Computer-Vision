close all;
clear;
clc;
clf;

%global parameters
global gauss_mask;
global window_size;
window_size = 5; %change this to the appropriate window size for the texture sample

%load the texture sample
s_image = 'texture1.jpg'; %change this to the texture sample that you want to apply texture synthesis
s_texture = im2double(imread(s_image));

%constants
err_thresh = 0.1; %according to the Efros and Leung algorithm
max_thresh = 0.3; %according to the Efros and Leung algorithm
sigma = window_size / 6.4; %according to the Efros and Leung algorithm
gauss_mask = fspecial('gaussian', window_size, sigma);
[row, column, colour] = size(s_texture);
image_size = row * 2;

%for black and white images
if colour ~= 3
    grey = im2col(s_texture(:,:), [window_size window_size]);   
    R = [];
    G = [];
    B = [];
%for coloured images
else
    grey = [];
    R = im2col(s_texture(:,:,1), [window_size window_size]);
    G = im2col(s_texture(:,:,2), [window_size window_size]);
    B = im2col(s_texture(:,:,3), [window_size window_size]);
end

%create a large empty image and copy the texture sample to its upper left corner as a starting point for the synthesis algorithm
result_texture = zeros(image_size, image_size, colour);
result_texture(1:row, 1:column, :) = s_texture;

%completed matrix. pixels that are filled are set to true and the unfilled set to false
completed = false([image_size, image_size]);
completed(1:row, 1:column) = true([row, column]);

% counter and maximum counterS
filled = size(s_texture, 1) * size(s_texture, 2);
pixel = image_size * image_size;

while filled < pixel
    done = 0;
    
    expand_completed = bwmorph(completed, 'dilate');
    border_pixel = expand_completed - completed;
    [p_row, p_col] = find(border_pixel);

    rand_idx = randperm(length(p_row));
    p_col = p_col(rand_idx);
    p_row = p_row(rand_idx);

    count_neigh = colfilt(completed, [window_size, window_size], 'sliding', @sum);
    
    l_idx = sub2ind(size(count_neigh), p_row, p_col);
    [~, idx] = sort(count_neigh(l_idx), 'descend');
    arranged = l_idx(idx);
    
    %all unfilled pixels that have filled pixels as their neighbors
    [p_row, p_col] = ind2sub(size(completed), arranged);
    
    
    for k = [p_row, p_col]'
        [valid_mask, temp] = get_neighborhood_window(completed, k(1), k(2), result_texture); 
        [row_match, col_match, err] = find_matches(R, G, B, grey, temp, valid_mask, err_thresh, s_texture);
    
        if err < max_thresh
           result_texture(k(1), k(2), :) = s_texture(row_match, col_match, :);
           completed(k(1), k(2)) = true; %update the completed matrix
           filled = filled + 1;
           done = 1;
        end
    end
    
    imshow(result_texture); %display the plot
    
    if done == 0
        max_thresh = max_thresh * 1.1; 
    end
end

result_texture_name = strcat('synthesised_', s_image);
imwrite(result_texture, result_texture_name);
