%% 
I = imread('cameraman.tif');

% criar mascaras
h_sobel = fspecial('sobel');
h_lapla = fspecial('laplacian');
h_log   = fspecial('log');
% aolicar filtros
B_sobel = imfilter(I,h_sobel);
B_lapla = imfilter(I,h_lapla);
B_log   = imfilter(I,h_log);
BI = edge(I,'Canny');
% ver resultado
imshow(B_sobel)
imshow(B_lapla)
imshow(B_log)
imshow(BI)