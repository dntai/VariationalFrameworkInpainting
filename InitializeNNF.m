% Initialize the nearest-neighbour field given two  images A and B and
% their virtually padded counterparts pad_A and pad_B. half_patch is the
% half of the patch size, since we're centering patches on a pixel.
function [NNF] = InitializeNNF(A, B, pad_A, pad_B, half_patch)
    [m, n, ~] = size(A);

    % Random offsets.
    offset_x = randi([1 size(B, 1)], m, n);
    offset_y = randi([1 size(B, 2)], m, n);    
    NNF(:, :, 1) = offset_x;
    NNF(:, :, 2) = offset_y;
        
    % Virtually extending the offsets to ease the indices handling.
    pad_offset_x = padarray(offset_x, [half_patch half_patch]);
    pad_offset_y = padarray(offset_y, [half_patch half_patch]); 
 
    % For each pixel in A, compute the SSD between the patch centered in
    % A(i,j) and B(NNF(i,j,1), NNF(i,j,2)). Store the distance in the third
    % channel.
    for i = 1 + half_patch : m + half_patch
        for j = 1 + half_patch : n + half_patch                        
            NNF(i - half_patch, j - half_patch, 3) = Distance(pad_A, pad_B, i, j, pad_offset_x(i, j) + half_patch, pad_offset_y(i, j) + half_patch, half_patch);
        end
    end    
end