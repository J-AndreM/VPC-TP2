close; clear; clc;
%% ************************************** Al�nea 1 ************************************** %%
I = imread('cameraman.tif');

%% ************************************** Al�nea 2 ************************************** %%
% % % Al�nea a) % % %
% Ru�do Gaussiano - m�dia 0, vari�ncia 2
G1 = imnoise(I,'gaussian',0,2/255);
% Ru�do Gaussiano - m�dia 0, vari�ncia 20
G2 = imnoise(I,'gaussian',0,20/255);
% Ru�do Gaussiano - m�dia 10, vari�ncia 2
G3 = imnoise(I,'gaussian',10/255,2/255);
% Ru�do Gaussiano - m�dia 10, vari�ncia 20
G4 = imnoise(I,'gaussian',10/255,20/255);

% % % Al�nea b) % % %
% Ru�do �salt & pepper� - densidade 0.1
SP1 = imnoise(I,'salt & pepper', 0.1);
% Ru�do �salt & pepper� - densidade 0.5
SP2 = imnoise(I,'salt & pepper', 0.5);

% % % Al�nea c) % % %
% Ru�do �speckle� - vari�ncia 0.8
SK = imnoise(I,'speckle',0.8);

%% ************************************** Al�nea 3 ************************************** %%
% Filtro de m�dia 
h_mean = fspecial('average');

G1_mean = imfilter(G1, h_mean);
G2_mean = imfilter(G2, h_mean);
G3_mean = imfilter(G3, h_mean);
G4_mean = imfilter(G4, h_mean);
SP1_mean = imfilter(SP1, h_mean);
SP2_mean = imfilter(SP2, h_mean);
SK_mean = imfilter(SK, h_mean);

% Filtro Gaussiano
h_gauss = fspecial('gaussian');

G1_gauss = imfilter(G1, h_gauss);
G2_gauss = imfilter(G2, h_gauss);
G3_gauss = imfilter(G3, h_gauss);
G4_gauss = imfilter(G4, h_gauss);
SP1_gauss = imfilter(SP1, h_gauss);
SP2_gauss = imfilter(SP2, h_gauss);
SK_gauss = imfilter(SK, h_gauss);

% Filtro mediana
G1_med =  medfilt2(G1);
G2_med =  medfilt2(G2);
G3_med =  medfilt2(G3);
G4_med =  medfilt2(G4);
SP1_med =  medfilt2(SP1);
SP2_med =  medfilt2(SP2);
SK_med =  medfilt2(SK);

%% Imprime as imagens %%
% Imagem com ru�do Gaussiano - m�dia 0, vari�ncia 2
figure('Name','Ru�do Gaussiano');
subplot(2,2,1); imshow(G1); title('med=0   var=2');
subplot(2,2,2); imshow(G1_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(G1_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(G1_med); title('Filtro de Mediana');

% Imagem com ru�do Gaussiano - m�dia 0, vari�ncia 20
figure('Name','Ru�do Gaussiano');
subplot(2,2,1); imshow(G2); title('med=0   var=20');
subplot(2,2,2); imshow(G2_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(G2_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(G2_med); title('Filtro de Mediana');

% Imagem com ru�do Gaussiano - m�dia 10, vari�ncia 2
figure('Name','Ru�do Gaussiano');
subplot(2,2,1); imshow(G3); title('med=10   var=2');
subplot(2,2,2); imshow(G3_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(G3_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(G3_med); title('Filtro de Mediana');

% Imagem com ru�do Gaussiano - m�dia 0, vari�ncia 2
figure('Name','Ru�do Gaussiano');
subplot(2,2,1); imshow(G4); title('med=10   var=20');
subplot(2,2,2); imshow(G4_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(G4_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(G4_med); title('Filtro de Mediana');

% Imagem com ru�do �salt & pepper� - densidade 0.1
figure('Name','Ru�do ''Salt & Pepper'' ');
subplot(2,2,1); imshow(SP1); title('densidade = 0.1');
subplot(2,2,2); imshow(SP1_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(SP1_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(SP1_med); title('Filtro de Mediana');

% Imagem com ru�do �salt & pepper� - densidade 0.5
figure('Name','Ru�do ''Salt & Pepper'' ');
subplot(2,2,1); imshow(SP2); title('densidade = 0.5');
subplot(2,2,2); imshow(SP2_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(SP2_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(SP2_med); title('Filtro de Mediana');


% Imagem com ru�do �salt & pepper� - vari�ncia 0.8
figure('Name','Ru�do ''Speckle'' ');
subplot(2,2,1); imshow(SK); title('vari�ncia = 0.8');
subplot(2,2,2); imshow(SK_mean); title('Filtro de M�dia');
subplot(2,2,3); imshow(SK_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(SK_med); title('Filtro de Mediana');














