function [valid_mask, temp] = get_neighborhood_window(completed, row, col, output_image)


global window_size; %according to the window_size set in main.m


w_half = floor((window_size - 1) / 2);

%odd window size
if mod(window_size, 2)
    wr_col = col - w_half : col + w_half;    
    wr_row = row - w_half : row + w_half;    
%even window size
else
    col_disp = round(rand);
    wr_col = col - (w_half + col_disp) : col + (w_half + ~col_disp);    
    row_disp = round(rand);
    wr_row = row - (w_half + row_disp) : row + (w_half + ~row_disp);
end

row_bound = (wr_row > size(output_image, 1)) | (wr_row < 1);
col_bound = (wr_col > size(output_image, 2)) | (wr_col < 1);

if sum(row_bound) + sum(col_bound) > 0
    row_in_bound = wr_row(~row_bound);
    col_in_bound = wr_col(~col_bound);    
    valid_mask = false([window_size window_size]);
    valid_mask(~row_bound, ~col_bound) = completed(row_in_bound, col_in_bound);
    temp = zeros(window_size, window_size, size(output_image, 3));
    temp(~row_bound, ~col_bound, :) = output_image(row_in_bound, col_in_bound, :);    
else
    valid_mask = completed(wr_row, wr_col);    
    temp = output_image(wr_row, wr_col, :);
end

end

