% Given an image "I_init", a region in this image to inpaint "Mask", the
% size of a patch "size_patch" in the image and the number of levels
% "nb_level" to use in the multi-scale scheme, proceeds to inpaint the
% image and returns it, as well as its corresponding offset map. "median",
% "average" and "poisson" are mutually exclusive booleans used to determine
% which similarity metric to use, and "lambda" is used for Poisson metric.
function [offset_map, I_final] = VariationalFramework(I_init, mask, size_patch, nb_level, lambda, median, average, poisson)
    I = im2double(I_init);
    mask = im2double(mask);
    half_patch_size = (size_patch - 1) / 2;
    
    sigma2 = 0.5;
    tolerance = 0.01;
    A = 0.15;
    decay_time = 0;
    asymptotic_value = 0;
    
    if nb_level == 1
        [I_final, offset_map] = MinimizationOfEnergies(I, mask, sigma2, tolerance, lambda, half_patch_size, median, average, poisson);    
    else 
        [I_final, offset_map] = Multiscale(I, mask, size_patch, nb_level, A, tolerance, sigma2, lambda, median, average, poisson);
    end
end
