function [row_fm, col_fm, err] = find_matches(R, G, B, grey, temp, valid_mask, err_thresh, s_texture)

global gauss_mask; %according to the gauss_mask set in main.m
global window_size; %according to the window_size set in main.m

total_weight = sum(sum(gauss_mask(valid_mask)));
mask = valid_mask .* gauss_mask / total_weight;
mask = mask(:)';

if size(temp,3) ~= 3
    [p_win, neighborhood] = size(grey);
    
    val_grey = temp(:,:);
    val_grey = val_grey(:);
    val_grey = repmat(val_grey, [1 neighborhood]);
    grey_dist = mask * (val_grey - grey).^2;
    SSD = grey_dist;
    
else
    [p_win, neighborhood] = size(R);
    
    val_red = temp(:,:,1);
    val_red = val_red(:);
    
    val_green = temp(:,:,2);
    val_green = val_green(:);
    
    val_blue = temp(:,:,3);
    val_blue = val_blue(:);
    
    val_red = repmat(val_red, [1, neighborhood]); 
    val_green = repmat(val_green, [1, neighborhood]); 
    val_blue = repmat(val_blue, [1, neighborhood]); 
   
    red_dist =  mask * (val_red - R).^2; 
    green_dist = mask * (val_green - G).^2; 
    blue_dist = mask * (val_blue - B).^2; 

    SSD = red_dist + green_dist + blue_dist; 

end

p_matches = find(SSD <= min(SSD) * (err_thresh + 1));
p_match = p_matches(ceil(rand*length(p_matches)));
err = SSD(p_match);

%convert p_match to rol and col 
[row_fm, col_fm] = ind2sub(size(s_texture) - window_size + 1, p_match);

%shift the top left pixel to the center
w_half = (window_size - 1)/2;
row_fm = row_fm + w_half;
col_fm = col_fm + w_half;

end

