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

%
BW = edge(I,'Canny');
figure('Name','edge com Canny')
imshow(BW)
BW = edge(I,'Sobel');
figure('Name','edge com Sobel')
imshow(BW)
BW = edge(I,'log');
figure('Name','edge com log')
imshow(BW)
BW = edge(I,'zerocross',0.1,h_log);
figure('Name','edge com zerocross')
imshow(BW)