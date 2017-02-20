close;
clear all;
clc;

%% ************************************** Al�nea 1 ************************************** %%
I = imread('cameraman.tif');

%% ************************************** Al�nea 2 ************************************** %%

% Ru�do Gaussiano - m�dia 0, vari�ncia 2
G1 = imnoise(I,'gaussian',0,2/255);

% Ru�do Gaussiano - m�dia 0, vari�ncia 20
G2 = imnoise(I,'gaussian',0,20/255);

% Ru�do Gaussiano - m�dia 10, vari�ncia 2
G3 = imnoise(I,'gaussian',10/255,2/255);

% Ru�do Gaussiano - m�dia 10, vari�ncia 20
G4 = imnoise(I,'gaussian',10/255,20/255);

figure;
title('Ru�do �salt & pepper�');
% Ru�do �salt & pepper� - densidade 0.1
SP1 = imnoise(I,'salt & pepper', 0.1);
subplot(1,2,1);
imshow(SP1);

% Ru�do �salt & pepper� - densidade 0.5
SP2 = imnoise(I,'salt & pepper', 0.5);
subplot(1,2,2);
imshow(SP2);

figure;
title('Ru�do �speckle�');
% Ru�do �speckle� - vari�ncia 0.8
SK = imnoise(I,'speckle',0.8);
imshow(SK);

%% Al�nea 3)
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
h_gauss = fspecial('gaussian')

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
figure;
suptitle('Ru�do Gaussiano');
subplot(2,2,1); imshow(G1); title('med=0   var=2');

subplot(2,2,1);
imshow(G1);
title('med=0   var=2');


figure;

% Ru�do Gaussiano - m�dia 0, vari�ncia 20
G2 = imnoise(I,'gaussian',0,20/255);
subplot(2,2,2)
imshow(G2);
title('med=0   var=20');

% Ru�do Gaussiano - m�dia 10, vari�ncia 2
G3 = imnoise(I,'gaussian',10/255,2/255);
subplot(2,2,3)
imshow(G3);
title('med=10   var=2');

% Ru�do Gaussiano - m�dia 10, vari�ncia 20
G4 = imnoise(I,'gaussian',10/255,20/255);
subplot(2,2,4)
imshow(G4);
title('med=10   var=20');













