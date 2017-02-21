close; clear; clc;
%% ************************************** Alínea 1 ************************************** %%
I = imread('cameraman.tif');

%% ************************************** Alínea 2 ************************************** %%
% % % Alínea a) Ruído Gaussiano % % %
Gauss = uint8(zeros(4, size(I,1), size(I,2)));
% média 0, variância 2
Gauss(1,:,:) = imnoise(I,'gaussian',0,2/255);
% média 0, variância 20
Gauss(2,:,:) = imnoise(I,'gaussian',0,20/255);
% média 10, variância 2
Gauss(3,:,:) = imnoise(I,'gaussian',10/255,2/255);
% média 10, variância 20
Gauss(4,:,:) = imnoise(I,'gaussian',10/255,20/255);

% % % Alínea b) Ruído ‘salt & pepper’ % % %
SaltP = uint8(zeros(2, size(I,1), size(I,2)));
% Densidade 0.1
SaltP(1,:,:) = imnoise(I,'salt & pepper', 0.1);
% Densidade 0.5
SaltP(2,:,:) = imnoise(I,'salt & pepper', 0.5);

% % % Alínea c) Ruído ‘speckle’ % % %
% Variância 0.8
Speckle = imnoise(I,'speckle',0.8);

%% ************************************** Alínea 3 ************************************** %%
% Filtro de média 
h_mean = fspecial('average');

Gauss_mean = imfilter(Gauss, h_mean);
SaltP_mean = imfilter(SaltP, h_mean);
Speckle_mean = imfilter(Speckle, h_mean);

% Filtro Gaussiano
h_gauss = fspecial('gaussian');

Gauss_gauss = imfilter(Gauss, h_gauss);
SaltP_gauss = imfilter(SaltP, h_gauss);
Speckle_gauss = imfilter(Speckle, h_gauss);

% Filtro mediana
Gauss_med = uint8(zeros(size(Gauss)));
for i=1:4
    Gauss_med(i,:,:) =  medfilt2(squeeze(Gauss(i,:,:)));
end

SaltP_med = uint8(zeros(size(SaltP)));
for i=1:2
    SaltP_med(i,:,:) =  medfilt2(squeeze(SaltP(i,:,:)));
end

Speckle_med =  medfilt2(Speckle);

%% Imprime as imagens %%
% Imagem com ruído Gaussiano
for i=1:4
    if i==1, figure('Name','Ruído Gaussiano - med=0, var=2');
    elseif i==2, figure('Name','Ruído Gaussiano - med=0, var=20');
    elseif i==3, figure('Name','Ruído Gaussiano - med=10, var=2');
    else, figure('Name','Ruído Gaussiano - med=10, var=20');
    end
    
    subplot(2,2,1); imshow(squeeze(Gauss(i,:,:))); title('Imagem com ruído');
    subplot(2,2,2); imshow(squeeze(Gauss_mean(i,:,:))); title('Filtro de Média');
    subplot(2,2,3); imshow(squeeze(Gauss_gauss(i,:,:))); title('Filtro Gaussiano');
    subplot(2,2,4); imshow(squeeze(Gauss_med(i,:,:))); title('Filtro de Mediana');
end

% Imagem com ruído ‘salt & pepper’
for i=1:2
    if i==1, figure('Name','Ruído ''Salt & Pepper'' - densidade=0.1');
    else, figure('Name','Ruído ''Salt & Pepper'' - densidade=0.5');
    end
    
    subplot(2,2,1); imshow(squeeze(SaltP(i,:,:))); title('Imagem com ruído');
    subplot(2,2,2); imshow(squeeze(SaltP_mean(i,:,:))); title('Filtro de Média');
    subplot(2,2,3); imshow(squeeze(SaltP_gauss(i,:,:))); title('Filtro Gaussiano');
    subplot(2,2,4); imshow(squeeze(SaltP_med(i,:,:))); title('Filtro de Mediana');
end


% Imagem com ruído ‘salt & pepper’
figure('Name','Ruído ''Speckle'' - variância=0.8');
subplot(2,2,1); imshow(Speckle); title('Imagem com ruído');
subplot(2,2,2); imshow(Speckle_mean); title('Filtro de Média');
subplot(2,2,3); imshow(Speckle_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(Speckle_med); title('Filtro de Mediana');














