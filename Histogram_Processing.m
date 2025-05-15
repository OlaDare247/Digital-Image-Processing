
% MATLAB script for image processing
%% Exercise 1. Implement the following processes: 
% 1) read the cameraman image, 
% 2) calculate negative image, 
% 3) add a constant value of 50, 
% 4) apply gamma intensity transform with γ ∈ [0, 2.0] with a step of 0.4. 
% Report your observations with respect to contrast stretching.
% Step 1: Read the cameraman image
original_image = imread('cameraman.tif');
original_image = im2double(original_image); % Convert to double for calculations
% Display the original image
figure;
imshow(original_image);
title('Original Image');
% Step 2: Calculate the negative image
negative_image = 1 - original_image;
% Display the negative image
figure;
imshow(negative_image);
title('Negative Image');
% Step 3: Add a constant value of 50
% Ensure the pixel values remain in the valid range [0, 1]
added_constant_image = original_image + 50 / 255;
added_constant_image = min(added_constant_image, 1);
% Display the image after adding a constant value
figure;
imshow(added_constant_image);
title('Image After Adding Constant Value of 50');
% Step 4: Apply gamma intensity transformation with γ ∈ [0, 2.0], step = 0.4
gamma_values = 0:0.4:2.0;
num_gammas = length(gamma_values);
figure;
for i = 1:num_gammas
 
gamma = gamma_values(i);
 
gamma_transformed_image = original_image .^ gamma;
 
 
% Display each gamma transformed image
 
subplot(2, ceil(num_gammas / 2), i);
 
imshow(gamma_transformed_image);
 
title(['Gamma = ', num2str(gamma)]);
end
sgtitle('Gamma Transformed Images');
% Contrast Stretching
% Step 1: Read image file and convert to double
Image = imread('woman_darkhair.png');
Image = double(Image);
figure, imagesc(Image), axis image, colormap gray, colorbar;
title('Original Image');
% Step 2: Define the piecewise linear function
a = [0 50 150 255];
b = [0 30 200 255];
figure, plot(a, b, 'linewidth', 2), title('Piecewise linear intensity mapping function.'), grid on;
saveas(gcf, 'piecewise_linear_mapping.png');
% Step 3: Create output image
Image2 = zeros(size(Image));
% Step 4: Apply piecewise linear mapping
for i = 1:length(a)-1
 
indices = find(Image >= a(i) & Image <= a(i+1));
 
Image2(indices) = (Image(indices) - a(i)) * (b(i+1) - b(i)) / (a(i+1) - a(i)) + b(i);
 
figure, imagesc(Image2), axis image, colormap gray, colorbar;
 
title(['Contrast Stretched Image - Interval ', num2str(i)]);
end
% Save the final result
saveas(gcf, 'woman_darkhair_post_mapping.png');
% Step 1: Read and display the jetplane image
Jetplane = imread('jetplane.png');
Jetplane = double(Jetplane); % Convert to double
figure, imagesc(Jetplane), axis image, colormap gray, colorbar;
title('Original Jetplane Image');

% Step 2: Extract bit-planes for jetplane
J0 = mod(Jetplane, 2);
J1 = mod(floor(Jetplane / 2), 2);
J2 = mod(floor(Jetplane / 4), 2);
J3 = mod(floor(Jetplane / 8), 2);
J4 = mod(floor(Jetplane / 16), 2);
J5 = mod(floor(Jetplane / 32), 2);
J6 = mod(floor(Jetplane / 64), 2);
J7 = mod(floor(Jetplane / 128), 2);
% Display bit-planes for jetplane
figure;
for i = 0:7
 
subplot(2, 4, i+1);
 
eval(['imshow(J', num2str(i), ');']);
 
title(['Bit-Plane J', num2str(i)]);
end
sgtitle('Bit-Planes of Jetplane Image');
% Step 3: Reconstruct the jetplane image
JC1 = 2 * J7; % Using most significant bit-plane (J7)
figure, imagesc(JC1), axis image, colormap gray, colorbar;
title('Jetplane Reconstruction Using J7 Only');
JC2 = 2 * (2 * J7 + J6); % Using J7 and J6
figure, imagesc(JC2), axis image, colormap gray, colorbar;
title('Jetplane Reconstruction Using J7 and J6');
JC3 = 2 * (2 * (2 * J7 + J6) + J5); % Using J7, J6, and J5
figure, imagesc(JC3), axis image, colormap gray, colorbar;
title('Jetplane Reconstruction Using J7, J6, and J5');
% Histogram Transformation Example
% Step 1: Read and display input image
Image = imread('pirate_gray.png');
Image = double(Image);
figure, imagesc(Image), axis image, colormap gray, colorbar;
title('Original Image');
saveas(gcf, 'pirate_gray_original.png');
% Step 2: Calculate histogram and PDF
i = 0:1:255;
n = hist(Image(:), i);
pdf = n / sum(n);
figure, plot(i, pdf, 'linewidth', 2), axis tight, grid on;
title('PDF');
saveas(gcf, 'pirate_gray_original_pdf.png');
% Step 3: Calculate the CDF and intensity mapping function
cdf = cumsum(pdf);
figure, plot(i, cdf, 'linewidth', 2), axis tight, grid on;
title('CDF');
saveas(gcf, 'pirate_gray_original_cdf.png');
mapping = 255 * cdf;
figure, plot(i, mapping, 'linewidth', 2), axis tight, grid on;
title('Mapping');
saveas(gcf, 'pirate_gray_mapping.png');
% Step 4: Apply intensity mapping
Image2 = zeros(size(Image));
for i = 1:256
 
indices = find(Image == i-1);
 
Image2(indices) = round(mapping(i));
end
figure, imagesc(Image2), axis image, colormap gray, colorbar;
title('Equalized Image');
saveas(gcf, 'pirate.tif');
% Step 5: Calculate and display new histogram, PDF, and CDF
i = 0:1:255;
n2 = hist(Image2(:), i);
pdf2 = n2 / sum(n2);
figure, plot(i, pdf2, 'linewidth', 2), axis tight, grid on;
title('Equalized PDF');
saveas(gcf, 'pirate_pdf.png');
cdf2 = cumsum(pdf2);
figure, plot(i, cdf2, 'linewidth', 2), axis tight, grid on;
title('Equalized CDF');
saveas(gcf, 'pirate_gray_equalized_cdf.png');
% Exercise 5: Histogram Equalization for Cameraman Image
% Step 1: Read the cameraman image

cameraman_image = imread('cameraman.tif');
cameraman_image = double(cameraman_image);
% Step 2: Calculate histogram and PDF
cameraman_hist = hist(cameraman_image(:), i);
cameraman_pdf = cameraman_hist / sum(cameraman_hist);
figure, plot(i, cameraman_pdf, 'linewidth', 2), axis tight, grid on;
title('Original PDF - Cameraman');
saveas(gcf, 'cameraman_original_pdf.png');
% Step 3: Calculate CDF and Mapping
cameraman_cdf = cumsum(cameraman_pdf);
cameraman_mapping = 255 * cameraman_cdf;
figure, plot(i, cameraman_mapping, 'linewidth', 2), axis tight, grid on;
title('Intensity Mapping - Cameraman');
saveas(gcf, 'cameraman_mapping.png');
% Step 4: Apply intensity mapping
cameraman_equalized = zeros(size(cameraman_image));
for j = 1:256
 
indices = find(cameraman_image == j-1);
 
cameraman_equalized(indices) = round(cameraman_mapping(j));
end
figure, imagesc(cameraman_equalized), axis image, colormap gray, colorbar;
title('Equalized Cameraman Image');
saveas(gcf, 'cameraman_equalized.png');
% Step 5: Calculate and display new histogram, PDF, and CDF
cameraman_equalized_hist = hist(cameraman_equalized(:), i);
cameraman_equalized_pdf = cameraman_equalized_hist / sum(cameraman_equalized_hist);
figure, plot(i, cameraman_equalized_pdf, 'linewidth', 2), axis tight, grid on;
title('Equalized PDF - Cameraman');
saveas(gcf, 'cameraman_equalized_pdf.png');
cameraman_equalized_cdf = cumsum(cameraman_equalized_pdf);
figure, plot(i, cameraman_equalized_cdf, 'linewidth', 2), axis tight, grid on;
title('Equalized CDF - Cameraman');
saveas(gcf, 'cameraman_equalized_cdf.png');
% Observations:
% - Original histogram often shows a narrow intensity range, indicating low contrast.
% - Histogram equalization redistributes intensities across the range, improving contrast.
% - Output PDF may not be perfectly uniform due to discrete intensity levels and the nature of the input image distribution.

