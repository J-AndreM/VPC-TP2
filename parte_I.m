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

% % Imprime as imagens % %
% ############################################################################## %
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

% ############################################################################## %
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

% ############################################################################## %
% Imagem com ruído ‘Speckle’
figure('Name','Ruído ''Speckle'' - variância=0.8');
subplot(2,2,1); imshow(Speckle); title('Imagem com ruído');
subplot(2,2,2); imshow(Speckle_mean); title('Filtro de Média');
subplot(2,2,3); imshow(Speckle_gauss); title('Filtro Gaussiano');
subplot(2,2,4); imshow(Speckle_med); title('Filtro de Mediana');

% % % Alínea a) 'improfile' - vamos utilizar uma linha de cada imagem % % %
% ############################################################################## %
% Ruído Gaussiano
Gauss_imp = double(zeros(4,4,256));
for i=1:4
    % Cálculo
    Gauss_imp(i,1,:)=improfile(squeeze(Gauss(i,:,:)),[1 256],[100 100]);
    Gauss_imp(i,2,:)=improfile(squeeze(Gauss_mean(i,:,:)),[1 256],[100 100]);
    Gauss_imp(i,3,:)=improfile(squeeze(Gauss_gauss(i,:,:)),[1 256],[100 100]);
    Gauss_imp(i,4,:)=improfile(squeeze(Gauss_med(i,:,:)),[1 256],[100 100]);


    if i==1, figure('Name','Ruído Gaussiano - med=0, var=2');
    elseif i==2, figure('Name','Ruído Gaussiano - med=0, var=20');
    elseif i==3, figure('Name','Ruído Gaussiano - med=10, var=2');
    else, figure('Name','Ruído Gaussiano - med=10, var=20');
    end
    
    subplot(1,2,2); hold on; grid on; title('Comparação'); axis([0,256,-5,280]);
    plot(squeeze(Gauss_imp(i,1,:)),'k'); plot(squeeze(Gauss_imp(i,2,:)),'b');
    plot(squeeze(Gauss_imp(i,3,:)),'g'); plot(squeeze(Gauss_imp(i,4,:)),'r');
    legend('Imagem com ruído','Filtro de Média','Filtro Gaussiano','Filtro de Mediana');
    subplot(2,4,1); plot(squeeze(Gauss_imp(i,1,:)),'k'); title('Imagem com ruído'); grid on; axis([0,256,-5,280]);
    subplot(2,4,2); plot(squeeze(Gauss_imp(i,2,:)),'b'); title('Filtro de Média'); grid on; axis([0,256,-5,280]);
    subplot(2,4,5); plot(squeeze(Gauss_imp(i,3,:)),'g'); title('Filtro Gaussiano'); grid on; axis([0,256,-5,280]);
    subplot(2,4,6); plot(squeeze(Gauss_imp(i,4,:)),'r'); title('Filtro de Mediana'); grid on; axis([0,256,-5,280]);
end

% ############################################################################## %
% Imagem com ruído ‘salt & pepper’
SaltP_imp = double(zeros(2,4,256));
for i=1:2
    % Cálculo
    SaltP_imp(i,1,:)=improfile(squeeze(SaltP(i,:,:)),[1 256],[100 100]);
    SaltP_imp(i,2,:)=improfile(squeeze(SaltP_mean(i,:,:)),[1 256],[100 100]);
    SaltP_imp(i,3,:)=improfile(squeeze(SaltP_gauss(i,:,:)),[1 256],[100 100]);
    SaltP_imp(i,4,:)=improfile(squeeze(SaltP_med(i,:,:)),[1 256],[100 100]);

    if i==1, figure('Name','Ruído ''Salt & Pepper'' - med=0, var=2');
    else, figure('Name','Ruído ''Salt & Pepper'' - med=10, var=20');
    end
    
    subplot(1,2,2); hold on; grid on; title('Comparação'); axis([0,256,-5,280]);
    plot(squeeze(SaltP_imp(i,1,:)),'k'); plot(squeeze(SaltP_imp(i,2,:)),'b');
    plot(squeeze(SaltP_imp(i,3,:)),'g'); plot(squeeze(SaltP_imp(i,4,:)),'r');
    legend('Imagem com ruído','Filtro de Média','Filtro Gaussiano','Filtro de Mediana');
    subplot(2,4,1); plot(squeeze(SaltP_imp(i,1,:)),'k'); title('Imagem com ruído'); grid on; axis([0,256,-5,280]);
    subplot(2,4,2); plot(squeeze(SaltP_imp(i,2,:)),'b'); title('Filtro de Média'); grid on; axis([0,256,-5,280]);
    subplot(2,4,5); plot(squeeze(SaltP_imp(i,3,:)),'g'); title('Filtro Gaussiano'); grid on; axis([0,256,-5,280]);
    subplot(2,4,6); plot(squeeze(SaltP_imp(i,4,:)),'r'); title('Filtro de Mediana'); grid on; axis([0,256,-5,280]);
end

% ############################################################################## %
% Imagem com ruído ‘salt & pepper’
Speckle_imp = double(zeros(4,256));
% Cálculo
Speckle_imp(1,:)=improfile(squeeze(Speckle(:,:)),[1 256],[100 100]);
Speckle_imp(2,:)=improfile(squeeze(Speckle_mean(:,:)),[1 256],[100 100]);
Speckle_imp(3,:)=improfile(squeeze(Speckle_gauss(:,:)),[1 256],[100 100]);
Speckle_imp(4,:)=improfile(squeeze(Speckle_med(:,:)),[1 256],[100 100]);

figure('Name','Ruído ''Speckle'' -  variância=0.8');
subplot(1,2,2); hold on; grid on; title('Comparação'); axis([0,256,-5,280]);
plot(squeeze(Speckle_imp(1,:)),'k'); plot(squeeze(Speckle_imp(2,:)),'b');
plot(squeeze(Speckle_imp(3,:)),'g'); plot(squeeze(Speckle_imp(4,:)),'r');
legend('Imagem com ruído','Filtro de Média','Filtro Gaussiano','Filtro de Mediana');
subplot(2,4,1); plot(squeeze(Speckle_imp(1,:)),'k'); title('Imagem com ruído'); grid on; axis([0,256,-5,280]);
subplot(2,4,2); plot(squeeze(Speckle_imp(2,:)),'b'); title('Filtro de Média'); grid on; axis([0,256,-5,280]);
subplot(2,4,5); plot(squeeze(Speckle_imp(3,:)),'g'); title('Filtro Gaussiano'); grid on; axis([0,256,-5,280]);
subplot(2,4,6); plot(squeeze(Speckle_imp(4,:)),'r'); title('Filtro de Mediana'); grid on; axis([0,256,-5,280]);


% % % Alínea c) Influência do desvio padrão % % %
% Cria novos filtros com diferentes valores do desvio padrão
h_gauss2 = fspecial('gaussian',[3 3],2);
h_gauss3 = fspecial('gaussian',[3 3],5);

% Aplica os filtros
Gauss_gauss2 = imfilter(Gauss, h_gauss2);
Gauss_gauss3 = imfilter(Gauss, h_gauss3);
% Apresenta as imagens com ruído Gaussiano
for i=1:4
    if i==1, figure('Name','Ruído Gaussiano - med=0, var=2');
    elseif i==2, figure('Name','Ruído Gaussiano - med=0, var=20');
    elseif i==3, figure('Name','Ruído Gaussiano - med=10, var=2');
    else, figure('Name','Ruído Gaussiano - med=10, var=20');
    end  
    subplot(2,2,1); imshow(squeeze(Gauss(i,:,:))); title('Imagem com ruído');
    subplot(2,2,2); imshow(squeeze(Gauss_gauss(i,:,:))); title('Sigma por defeito');
    subplot(2,2,3); imshow(squeeze(Gauss_gauss2(i,:,:))); title('Sigma = 2');
    subplot(2,2,4); imshow(squeeze(Gauss_gauss3(i,:,:))); title('Sigma = 5');
end

% Aplica os filtros
SaltP_gauss2 = imfilter(SaltP, h_gauss2);
SaltP_gauss3 = imfilter(SaltP, h_gauss3);
% Apresenta as imagens com ruído 'Salt & Pepper'
for i=1:2
    if i==1, figure('Name','Ruído ''Salt & Pepper'' - med=0, var=2');
    else, figure('Name','Ruído ''Salt & Pepper'' - med=10, var=20');
    end 
    subplot(2,2,1); imshow(squeeze(SaltP(i,:,:))); title('Imagem com ruído');
    subplot(2,2,2); imshow(squeeze(SaltP_gauss(i,:,:))); title('Sigma por defeito');
    subplot(2,2,3); imshow(squeeze(SaltP_gauss2(i,:,:))); title('Sigma = 2');
    subplot(2,2,4); imshow(squeeze(SaltP_gauss3(i,:,:))); title('Sigma = 5');
end

% Aplica os filtros
Speckle_gauss2 = imfilter(Speckle, h_gauss2);
Speckle_gauss3 = imfilter(Speckle, h_gauss3);
% Apresenta as imagens com ruído ‘Speckle’
figure('Name','Ruído ''Speckle'' - variância=0.8');
subplot(2,2,1); imshow(Speckle); title('Imagem com ruído');
subplot(2,2,2); imshow(Speckle_gauss); title('Sigma por defeito');
subplot(2,2,3); imshow(Speckle_gauss2); title('Sigma = 2');
subplot(2,2,4); imshow(Speckle_gauss3); title('Sigma = 5');


























