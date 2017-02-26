close; clear; clc;
%% Lê a imagem
I = imread('cameraman.tif');

%% cria mascaras
h_sobel = fspecial('sobel');
h_lapla = fspecial('laplacian');
h_log   = fspecial('log');

%% aplica os filtros
B_sobel = imfilter(I,h_sobel);
B_lapla = imfilter(I,h_lapla);
B_log   = imfilter(I,h_log);
BI = edge(I,'Canny');

% ver resultado
figure('Name','Resultado da Filtragem')
subplot(2,2,1)
imshow(B_sobel)
title('Sobel');

subplot(2,2,2)
imshow(B_lapla)
title('Laplaciano');

subplot(2,2,3)
imshow(B_log)
title('LoG');

subplot(2,2,4)
imshow(BI)
title('Canny');


%% Módulo e fase
% Calcula a Fase
B_sobel_y = imfilter(I,h_sobel');
B_lapla_y = imfilter(I,h_lapla');
B_log_y   = imfilter(I,h_log');

% Apresenta os resultados
figure('Name','Módulo e Fase')
% % Sobel
subplot(2,3,1)
imshow(abs(B_sobel));
title('Módulo Sobel')
subplot(2,3,4)
imshow(atan2(double(B_sobel_y), double(B_sobel)));
title('Fase Sobel')

% % Laplaciano
subplot(2,3,2)
imshow(abs(B_lapla));
title('Módulo Laplaciano')
subplot(2,3,5)
imshow(atan2(double(B_lapla_y), double(B_lapla)));
title('Fase Laplaciano')

% % Laplaciano da Gaussiana
subplot(2,3,3)
imshow(abs(B_log));
title('Módulo LoG')
subplot(2,3,6)
imshow(atan2(double(B_log_y), double(B_log)));
title('Fase LoG')


%% Vetor do gradiente
figure('Name','Resultado da Filtragem')
subplot(1,3,1)
imshow(B_sobel)
hold on
quiver(B_sobel,B_sobel_y,4,'color',[0.5 1 0])
title('Sobel');

subplot(1,3,2)
imshow(B_lapla)
hold on
quiver(B_lapla,B_lapla_y,4,'color',[1 1 0.5])
title('Laplaciano');

subplot(1,3,3)
imshow(B_log)
hold on
quiver(B_log,B_log_y,4,'color',[1 0.5 0])
title('LoG');

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



