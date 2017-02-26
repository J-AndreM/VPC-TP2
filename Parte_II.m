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
figure('Name','Resultado da Filtragem')
subplot(2,2,1)
imshow(B_sobel)
title('sobel');

subplot(2,2,2)
imshow(B_lapla)
title('laplacian');

subplot(2,2,3)
imshow(B_log)
title('log');

subplot(2,2,4)
imshow(BI)
title('Canny');





%%

% detetar arestas
figure('Name','Detectores de Arestas')
subplot(2,2,1)
BW = edge(I,'Canny');
imshow(BW)
title('Canny');
%
subplot(2,2,2)
BW = edge(I,'Sobel');
imshow(BW)
title('Sobel');
%
subplot(2,2,3)
BW = edge(I,'log');
imshow(BW)
title('log');
%
subplot(2,2,4)
BW = edge(I,'zerocross');
imshow(BW)
title('zerocross');



